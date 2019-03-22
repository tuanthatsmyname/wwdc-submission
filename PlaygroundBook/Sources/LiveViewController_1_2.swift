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
        terminalTextView.isUserInteractionEnabled = false

    }
    
    // TODO: show the whole history
    private func showPrompt() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
            if self.counter % 2 == 0 {
                self.terminalTextView.attributedText = self.terminalSettings.prompt
            } else {
                let attributedString = NSMutableAttributedString(attributedString: self.terminalSettings.prompt)
                attributedString.append(NSMutableAttributedString(string: "|", attributes: self.terminalSettings.boldAttributes))
                self.terminalTextView.attributedText = attributedString
            }
            self.counter += 1
        }
    }
    
    // TODO: show history
    // TODO: delete "|" from the animation
    // TODO: scroll when the textview is full
    // TODO: show "|" when entering a new command
    private func executeCommand(command: String) {
        timer.invalidate()
        var index = 0
        
        let _ = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            let attributedText = NSMutableAttributedString(attributedString: self.terminalTextView.attributedText)
            attributedText.append(NSMutableAttributedString(string: String(command.characters[index]), attributes: self.terminalSettings.normalAttributes))
            self.terminalTextView.attributedText = attributedText

            index += 1

            if index == command.characters.count {
                timer.invalidate()
                let attributedText = NSMutableAttributedString(attributedString: self.terminalTextView.attributedText)
                attributedText.append(NSMutableAttributedString(string: "\n"))
                if let result = self.terminal.execute(command: command) {
                    attributedText.append(NSMutableAttributedString(string: result, attributes: self.terminalSettings.normalAttributes))
                    self.terminalSettings.currentPath = self.terminal.currentPath
                }
                attributedText.append(NSMutableAttributedString(string: "\n"))
                attributedText.append(self.terminalSettings.prompt)
                self.terminalTextView.attributedText = attributedText
            }

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
