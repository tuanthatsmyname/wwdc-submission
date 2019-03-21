//
//  Extensions.swift
//  Book_Sources
//
//  Created by Tuan Tu Do on 21/03/2019.
//

import Foundation
import UIKit

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
    
    // TODO
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
