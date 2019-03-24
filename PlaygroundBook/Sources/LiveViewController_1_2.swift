//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  Provides supporting functions for setting up a live view.
//

import UIKit
import Foundation
import PlaygroundSupport

public class LiveViewController_1_2: LiveViewController {
    
    @IBOutlet weak var terminalTextView: UITextView!
    
    var timer: Timer!
    var terminal: Terminal!
    var counter = 0
    var terminalSettings: TerminalSettings!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupTerminalSettings()
        setupTerminalTextView()
        showPrompt()
    }
    
    private func setupTerminalSettings() {
        if let settings = DataManager.loadTerminalSettings() {
            terminalSettings = settings
        } else {
            terminalSettings = TerminalSettings()
        }
        
        terminal = Terminal(currentPath: terminalSettings.currentPath, username: terminalSettings.username)
    }
    
    private func setupTerminalTextView() {
        
        view.backgroundColor = terminalSettings.backgroundColor
        terminalTextView.backgroundColor = .clear
        terminalTextView.isEditable = false
//        terminalTextView.isUserInteractionEnabled = false

    }
    
    private func showPrompt() {
        
        if let terminalHistory = DataManager.loadTerminalHistory() {
            terminalTextView.attributedText = terminalHistory
            animateCursor()
        } else {
            timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
                if self.counter % 2 == 0 {
                    let attributedString = NSMutableAttributedString(attributedString: self.terminalSettings.prompt)
                    attributedString.append(NSMutableAttributedString(string: "│", attributes: self.terminalSettings.normalAttributes))
                    self.terminalTextView.attributedText = attributedString
                } else {
                    self.terminalTextView.attributedText = self.terminalSettings.prompt
                }
                self.counter += 1
            }
        }
    
    }
    
    private func executeCommand(command: String) {
        timer.invalidate()
        var index = 0
        
        let _ = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            
            if index < command.count {
                let attributedText = NSMutableAttributedString(attributedString: self.terminalTextView.attributedText)
                
                // deleting "|" from the prompt animation
                if index == 0, attributedText.string.last! == "│" {
                    attributedText.deleteCharacters(in: NSRange(location: attributedText.length - 1, length: 1))
                }
                
                // deleting "|" from the type animation
                if index != 0 {
                    attributedText.deleteCharacters(in: NSRange(location: attributedText.length - 1, length: 1))
                }
                attributedText.append(NSMutableAttributedString(string: String(command.characters[index]) + "│", attributes: self.terminalSettings.normalAttributes))
                self.terminalTextView.attributedText = attributedText
            }

            index += 1

            if index == command.count + 3 {
                timer.invalidate()
                
                let attributedText = NSMutableAttributedString(attributedString: self.terminalTextView.attributedText)
                // deleting "|" from the type animation
                attributedText.deleteCharacters(in: NSRange(location: attributedText.length - 1, length: 1))
                attributedText.append(NSMutableAttributedString(string: "\n"))
                if let result = self.terminal.execute(command: command) {
                    attributedText.append(NSMutableAttributedString(string: result, attributes: self.terminalSettings.normalAttributes))
                    attributedText.append(NSMutableAttributedString(string: "\n"))
                }
                self.terminalSettings.currentPath = self.terminal.currentPath
                attributedText.append(self.terminalSettings.prompt)
                self.terminalTextView.attributedText = attributedText
                
                if self.terminalTextView.contentSize.height > self.terminalTextView.frame.height {
                    let range = NSMakeRange(self.terminalTextView.attributedText.length - 1, 1)
                    self.terminalTextView.scrollRangeToVisible(range)
                }
                
                DataManager.saveTerminalHistory(from: attributedText)
                DataManager.saveTerminalSettings(of: self.terminalSettings)
                
                self.animateCursor()
                
            }

        }
    }
    
    private func animateCursor() {
        counter = 0
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
            if self.counter % 2 == 0 {
                let attributedText = NSMutableAttributedString(attributedString: self.terminalTextView.attributedText)
                attributedText.append(NSMutableAttributedString(string: "│", attributes: self.terminalSettings.normalAttributes))
                self.terminalTextView.attributedText = attributedText
            } else {
                let attributedText = NSMutableAttributedString(attributedString: self.terminalTextView.attributedText)
                attributedText.deleteCharacters(in: NSRange(location: attributedText.length - 1, length: 1))
                self.terminalTextView.attributedText = attributedText
            }
            self.counter += 1
        }
    }
    
    override public func receive(_ message: PlaygroundValue) {
        
        guard case .data(let messageData) = message else { return }
        
        do {
            if let command = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(messageData) as? String {
                executeCommand(command: command)
            }
        } catch let error { fatalError("\(error) Unable to receive the message from the Playground page") }
        
    }
}
