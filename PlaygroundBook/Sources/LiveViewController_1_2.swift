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
    
    var boldAttributes: [NSAttributedString.Key : Any]!
    var normalAttributes: [NSAttributedString.Key : Any]!
    var prompt: NSMutableAttributedString!
    var timer: Timer!
    let lineSpacing = NSMutableParagraphStyle()
    var terminal: Terminal!
    var counter = 0
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupTerminalTextView()
        showPrompt()
    }
    
    private func setupTerminalTextView() {
        var terminalSettings: TerminalSettings
        if let settings = DataManager.loadTerminalSettings() {
            terminalSettings = settings
        } else {
            terminalSettings = TerminalSettings()
        }
        
        view.backgroundColor = terminalSettings.backgroundColor
        terminalTextView.backgroundColor = .clear
        terminalTextView.isEditable = false
        terminalTextView.isUserInteractionEnabled = false
        lineSpacing.lineSpacing = 5
        
        boldAttributes = [.font : UIFont(name: "\(terminalSettings.textFont)-Bold", size: terminalSettings.textSize)!, .foregroundColor : terminalSettings.textColor, .paragraphStyle : lineSpacing]
        normalAttributes = [.font : UIFont(name: "\(terminalSettings.textFont)", size: terminalSettings.textSize)!, .foregroundColor : terminalSettings.textColor, .paragraphStyle : lineSpacing]
        prompt = NSMutableAttributedString(string: "\(terminalSettings.username)-mac: \(terminalSettings.currentPath) $ ", attributes: boldAttributes)
        terminal = Terminal(paths: DataManager.loadHierarchy(with: terminalSettings.username), currentPath: terminalSettings.currentPath, username: terminalSettings.username)
    }
    
    private func showPrompt() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
            if self.counter % 2 == 0 {
                self.terminalTextView.attributedText = self.prompt
            } else {
                let attributedString = NSMutableAttributedString(attributedString: self.prompt)
                attributedString.append(NSMutableAttributedString(string: "|", attributes: self.boldAttributes))
                self.terminalTextView.attributedText = attributedString
            }
            self.counter += 1
        }
    }
    
    private func executeCommand(command: String) {
        timer.invalidate()
        var index = 0
        
        let _ = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            // delete "|" from the animation
            let attributedText = NSMutableAttributedString(attributedString: self.terminalTextView.attributedText)
            attributedText.append(NSMutableAttributedString(string: String(command.characters[index]), attributes: self.normalAttributes))
            self.terminalTextView.attributedText = attributedText
            // TODO: scroll

            index += 1

            if index == command.characters.count {
                timer.invalidate()
                let attributedText = NSMutableAttributedString(attributedString: self.terminalTextView.attributedText)
                attributedText.append(NSMutableAttributedString(string: "\n"))
                if let result = self.terminal.execute(command: command) {
                    attributedText.append(NSMutableAttributedString(string: result, attributes: self.normalAttributes))
                    self.prompt = NSMutableAttributedString(string: "\(self.terminal.username)-mac: \(self.terminal.currentPath) $ ", attributes: self.boldAttributes)
                }
                attributedText.append(self.prompt)
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
