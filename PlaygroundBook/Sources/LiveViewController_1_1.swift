//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  Provides supporting functions for setting up a live view.
//

import UIKit
import Foundation
import PlaygroundSupport

public class LiveViewController_1_1: LiveViewController {
    
    @IBOutlet weak var terminalTextView: UITextView!
    
    var terminalSettings: TerminalSettings!
    var timer: Timer!
    // TODO: check the text with someone
    var resultString = "Hi there, let's choose your own terminal settings and start!"
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupTerminal()
        setupTerminalTextView()
        runCommand()
    }
    
    private func setupTerminal() {
        if let settings = DataManager.loadTerminalSettings() {
            terminalSettings = settings
        } else {
            terminalSettings = TerminalSettings()
        }
    }
    
    private func setupTerminalTextView() {
        view.backgroundColor = terminalSettings.backgroundColor
        terminalTextView.backgroundColor = .clear
        terminalTextView.isEditable = false
        terminalTextView.isUserInteractionEnabled = false
    }
    
    private func runCommand() {
        var index = 0
        var counter = 0
        let command = "cat ./welcome.txt"
        terminalTextView.attributedText = terminalSettings.prompt
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            if index < command.characters.count {
                let attributedTextViewText = NSMutableAttributedString(attributedString: self.terminalTextView.attributedText)
                
                // deleting "|" from the type animation
                if index != 0 {
                    attributedTextViewText.deleteCharacters(in: NSRange(location: attributedTextViewText.length - 1, length: 1))
                }
                attributedTextViewText.append(NSMutableAttributedString(string: String(command.characters[index]) + "│", attributes: self.terminalSettings.normalAttributes))
                self.terminalTextView.attributedText = attributedTextViewText
            }
            
            index += 1
            
            if index == command.characters.count + 3 {
                index = 0
                let attributedTextViewText = NSMutableAttributedString(attributedString: self.terminalTextView.attributedText)
                attributedTextViewText.deleteCharacters(in: NSRange(location: attributedTextViewText.length - 1, length: 1))
                attributedTextViewText.append(NSMutableAttributedString(string: "\n"))
                attributedTextViewText.append(NSMutableAttributedString(string: self.resultString, attributes: self.terminalSettings.normalAttributes))
                attributedTextViewText.append(NSMutableAttributedString(string: "\n"))
                attributedTextViewText.append(self.terminalSettings.prompt)
                self.terminalTextView.attributedText = attributedTextViewText
                counter += 1
            }
            
            if counter == 5 {
                timer.invalidate()
                self.animateCursor()
            }
        }
    }
    
    private func animateCursor() {
        var counter = 0
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
            if counter % 2 == 0 {
                let attributedText = NSMutableAttributedString(attributedString: self.terminalTextView.attributedText)
                attributedText.append(NSMutableAttributedString(string: "│", attributes: self.terminalSettings.normalAttributes))
                self.terminalTextView.attributedText = attributedText
            } else {
                let attributedText = NSMutableAttributedString(attributedString: self.terminalTextView.attributedText)
                attributedText.deleteCharacters(in: NSRange(location: attributedText.length - 1, length: 1))
                self.terminalTextView.attributedText = attributedText
            }
            counter += 1
        }
    }

    override public func receive(_ message: PlaygroundValue) {
        guard case .data(let messageData) = message else { return }
        let decoder = JSONDecoder()
        if let terminalSettings = try? decoder.decode(TerminalSettings.self, from: messageData) {
            self.terminalSettings = terminalSettings
            DataManager.saveTerminalSettings(of: terminalSettings)
            // TODO: check the text with someone
            resultString = "Well done, you just set up your terminal! Let's start!"
            timer.invalidate()
            setupTerminalTextView()
            runCommand()
        }
    }
}
