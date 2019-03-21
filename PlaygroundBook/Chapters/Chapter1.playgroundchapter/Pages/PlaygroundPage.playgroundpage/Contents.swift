//#-hidden-code

import Foundation
import UIKit

//#-end-hidden-code

//: # Every one can Terminal

let name: String = /*#-editable-code*//*#-end-editable-code*/
let textSize: CGFloat = /*#-editable-code*//*#-end-editable-code*/
let textColor: UIColor = /*#-editable-code*/#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)/*#-end-editable-code*/
let backgroundColor: UIColor = /*#-editable-code*/#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)/*#-end-editable-code*/
let textFont: Fonts = /*#-editable-code*//*#-end-editable-code*/

//#-hidden-code
let terminalSettings = TerminalSettings(textColor: textColor, textSize: textSize, backgroundColor: backgroundColor, username: name, textFont: textFont)
//let terminalSettings = TerminalSettings(textColor: UIColor.blue, textSize: 16, backgroundColor: UIColor.red, username: "name", textFont: Fonts.menlo)
let encoder = JSONEncoder()
sendValue(.data(try encoder.encode(terminalSettings)))
//sendValue(.data(try encoder.encode(name)))
//#-end-hidden-code
//#-code-completion(identifier, show, moveForward(), turnLeft(), collectGem(), toggleSwitch())
