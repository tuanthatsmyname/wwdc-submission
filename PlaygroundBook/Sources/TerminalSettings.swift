//
//  TerminalSettings.swift
//  Book_Sources
//
//  Created by Tuan Tu Do on 17/03/2019.
//

import Foundation
import UIKit

enum ComputerType: String {
    case macbook = "macbook"
    case imac = "imac"
}

class TerminalSettings {
    var textColor: UIColor
    var textSize: Int
    var backgroundColor: UIColor
    var computerType: ComputerType
    
    init(textColor: UIColor, textSize: Int, backgroundColor: UIColor, computerType: ComputerType) {
        self.textColor = textColor
        self.textSize = textSize
        self.backgroundColor = backgroundColor
        self.computerType = computerType
    }
}
