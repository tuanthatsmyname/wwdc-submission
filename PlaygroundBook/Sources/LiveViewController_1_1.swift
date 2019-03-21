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
        
        let _ = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { timer in
            if index < command.characters.count {
                var attributedText = NSMutableAttributedString(attributedString: self.terminalTextView.attributedText)
                attributedText.append(NSMutableAttributedString(string: String(command.characters[index]), attributes: [.font : UIFont(name: "Menlo", size: 20)!, .foregroundColor : UIColor.white]))
                self.terminalTextView.attributedText = attributedText
            }
            index += 1
            if index == command.characters.count + 1 {
                timer.invalidate()
                // print result and prompt
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

extension UITextView {
    func typeOn(string: String) {
        let characterArray = string.characters
        var characterIndex = 0
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { (timer) in
            if characterArray[characterIndex] != "$" {
                while characterArray[characterIndex] == " " {
                    self.text.append(" ")
                    characterIndex += 1
                    if characterIndex == characterArray.count {
                        timer.invalidate()
                        return
                    }
                }
                self.text.append(characterArray[characterIndex])
            }
            characterIndex += 1
            if characterIndex == characterArray.count {
                timer.invalidate()
            }
        }
    }
    
    func type(command: String, result: String) {
        
    }
    
}

extension String {
    var characters: [Character] {
        var characters = [Character]()
        for character in self {
            characters.append(character)
        }
        return characters
    }
}
