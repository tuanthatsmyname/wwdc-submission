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
    }
    
    private func showPrompt() {
        var index = 0
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
            if index % 2 == 0 {
                self.terminalTextView.attributedText = self.prompt
            } else {
                let attributedString = NSMutableAttributedString(attributedString: self.prompt)
                attributedString.append(NSMutableAttributedString(string: "|", attributes: self.boldAttributes))
                self.terminalTextView.attributedText = attributedString
            }
            index += 1
        }
    }
    
    private func executeCommand(from: String) {
//        timer.invalidate()
    }
    
    override public func receive(_ message: PlaygroundValue) {
        
        guard case .data(let messageData) = message else { return }
        
        do {
            if let command = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(messageData) as? String {
                executeCommand(from: command)
            }
        } catch let error { fatalError("\(error) Unable to receive the message from the Playground page") }
        
    }
}
