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
    var computerName = "TuanTuDo-mac"
    var currentPath = "/WWDC/playground"
    var command = "cat ./welcome.txt"
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupTerminalTextView()
    }
    
    private func setupTerminalTextView() {
//        terminalTextView.font = UIFont(name: "Menlo", size: 25)
        terminalTextView.backgroundColor = .clear
        terminalTextView.isEditable = false
        terminalTextView.isUserInteractionEnabled = false
//        terminalTextView.text = "tuantudo-mac: /WWDC/playground/ $ ls welcome.txt"
        showText()
    }
    
    private func showText() {
        var index = 0
        let prompt = NSMutableAttributedString(string: "tuantudo-mac: /WWDC/playground/ $ ", attributes: [.font : UIFont(name: "Menlo-Bold", size: 20)!, .foregroundColor : UIColor.white])
        terminalTextView.attributedText = prompt
        let command = "cat ./welcome.txt"
        
        let _ = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { timer in
            if index < command.characters.count {
                let attributedText = NSMutableAttributedString(attributedString: self.terminalTextView.attributedText)
                attributedText.append(NSMutableAttributedString(string: String(command.characters[index]), attributes: [.font : UIFont(name: "Menlo", size: 20)!, .foregroundColor : UIColor.white]))
                self.terminalTextView.attributedText = attributedText
            }
            index += 1
            if index == command.characters.count + 1 {
//                timer.invalidate()
                let result = NSMutableAttributedString(string: "\nWelcome to my Playground! Let's choose your own terminal settings and we can start!", attributes: [.font : UIFont(name: "Menlo", size: 20)!, .foregroundColor : UIColor.white])
                let prompt = NSMutableAttributedString(string: "\ntuantudo-mac: /WWDC/playground/ $ ", attributes: [.font : UIFont(name: "Menlo-Bold", size: 20)!, .foregroundColor : UIColor.white])
                let attributedText = NSMutableAttributedString(attributedString: self.terminalTextView.attributedText)
                attributedText.append(result)
                attributedText.append(prompt)
                self.terminalTextView.attributedText = attributedText
                index = 0
                let bottom = self.terminalTextView.contentSize.height
                if bottom > self.terminalTextView.frame.height {
//                                    let bottom = NSMakeRange(textLog.text.count - 1, 1)
//                                    textLog.scrollRangeToVisible(bottom)
                    let b = NSMakeRange(self.terminalTextView.attributedText.length - 1, 1)
                    self.terminalTextView.scrollRangeToVisible(b)
                }
            }
        }
        
    }
    
     override public func receive(_ message: PlaygroundValue) {
        guard case .data(let messageData) = message else { return }
        let decoder = JSONDecoder()
        if let terminalSettings = try? decoder.decode(TerminalSettings.self, from: messageData) {
            computerName = "\(terminalSettings.username)-mac"
            view.backgroundColor = terminalSettings.backgroundColor
            terminalTextView.textColor = terminalSettings.textColor
            terminalTextView.font = UIFont(name: terminalSettings.fontName, size: CGFloat(terminalSettings.textSize))
        }
    }
}
