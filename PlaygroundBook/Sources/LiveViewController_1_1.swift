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
    var terminalSettings = TerminalSettings()
    var boldAttributes: [NSAttributedString.Key : Any]!
    var normalAttributes: [NSAttributedString.Key : Any]!
    var prompt: NSMutableAttributedString!
    var result: NSMutableAttributedString!
    var timer: Timer!
    let lineSpacing = NSMutableParagraphStyle()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupTerminalTextView()
        runCommand()
    }
    
    private func setupTerminalTextView() {
        view.backgroundColor = terminalSettings.backgroundColor
        terminalTextView.backgroundColor = .clear
        terminalTextView.isEditable = false
        terminalTextView.isUserInteractionEnabled = false
        lineSpacing.lineSpacing = 5
        boldAttributes = [.font : UIFont(name: "\(terminalSettings.textFont)-Bold", size: terminalSettings.textSize)!, .foregroundColor : terminalSettings.textColor, .paragraphStyle : lineSpacing]
        normalAttributes = [.font : UIFont(name: "\(terminalSettings.textFont)", size: terminalSettings.textSize)!, .foregroundColor : terminalSettings.textColor, .paragraphStyle : lineSpacing]
        prompt = NSMutableAttributedString(string: "\(terminalSettings.username)-mac: \(terminalSettings.currentPath) $ ", attributes: boldAttributes)
        result = NSMutableAttributedString(string: "Hi there, welcome to my Playground! Let's choose your own terminal settings and we can start!", attributes: normalAttributes)
    }
    
    private func runCommand() {
        var index = 0
        var counter = 0
        let command = "cat ./welcome.txt"
        terminalTextView.attributedText = prompt
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            if index < command.characters.count {
                let attributedTextViewText = NSMutableAttributedString(attributedString: self.terminalTextView.attributedText)
                attributedTextViewText.append(NSMutableAttributedString(string: String(command.characters[index]), attributes: self.normalAttributes))
                self.terminalTextView.attributedText = attributedTextViewText
            }
            
            index += 1
            
            if index == command.characters.count + 3 {
                index = 0
                let attributedTextViewText = NSMutableAttributedString(attributedString: self.terminalTextView.attributedText)
                attributedTextViewText.append(NSMutableAttributedString(string: "\n"))
                attributedTextViewText.append(self.result)
                attributedTextViewText.append(NSMutableAttributedString(string: "\n"))
                attributedTextViewText.append(self.prompt)
                self.terminalTextView.attributedText = attributedTextViewText
                counter += 1
//                if self.terminalTextView.contentSize.height > self.terminalTextView.frame.height {
//                    let range = NSMakeRange(self.terminalTextView.attributedText.length - 1, 1)
//                    self.terminalTextView.scrollRangeToVisible(range)
//                }
            }
            
            if counter == 9 {
                timer.invalidate()
            }
        }
    }

    override public func receive(_ message: PlaygroundValue) {
        guard case .data(let messageData) = message else { return }
        let decoder = JSONDecoder()
        if let terminalSettings = try? decoder.decode(TerminalSettings.self, from: messageData) {
            boldAttributes = [.font : UIFont(name: "\(terminalSettings.textFont)-Bold", size: terminalSettings.textSize)!, .foregroundColor : terminalSettings.textColor, .paragraphStyle : lineSpacing]
            normalAttributes = [.font : UIFont(name: "\(terminalSettings.textFont)", size: terminalSettings.textSize)!, .foregroundColor : terminalSettings.textColor, .paragraphStyle : lineSpacing]
            prompt = NSMutableAttributedString(string: "\(terminalSettings.username)-mac: \(terminalSettings.currentPath) $ ", attributes: boldAttributes)
            result = NSMutableAttributedString(string: "Hi there, welcome to my Playground! Let's choose your own terminal settings and we can start!", attributes: normalAttributes)
            view.backgroundColor = terminalSettings.backgroundColor
            DataManager.saveTerminalSettings(of: terminalSettings)
            timer.invalidate()
            runCommand()
        }
    }
}
