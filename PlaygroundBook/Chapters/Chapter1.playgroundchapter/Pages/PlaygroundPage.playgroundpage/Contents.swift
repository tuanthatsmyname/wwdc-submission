//#-code-completion(everything, hide)
//#-code-completion(currentmodule, show)
//#-hidden-code

import Foundation
import UIKit
import PlaygroundSupport

public enum Font {
    case menlo
    case courier
}

//#-end-hidden-code

/*:

 # Everyone can Terminal
 
 **Set up a terminal that fits your personality!**
 
*/

let name: String = /*#-editable-code*//*#-end-editable-code*/
let textSize: CGFloat = /*#-editable-code*//*#-end-editable-code*/
let textColor: UIColor = /*#-editable-code*/#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)/*#-end-editable-code*/
let backgroundColor: UIColor = /*#-editable-code*/#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)/*#-end-editable-code*/
let textFont: Font = /*#-editable-code*//*#-end-editable-code*/

//#-hidden-code

var font: Fonts!

switch textFont {
case .menlo:
    font = Fonts.menlo
case .courier:
    font = Fonts.courier
}

let terminalSettings = TerminalSettings(textColor: textColor, textSize: textSize, backgroundColor: backgroundColor, username: name, textFont: font)
let encoder = JSONEncoder()
sendValue(.data(try encoder.encode(terminalSettings)))

PlaygroundPage.current.assessmentStatus = .pass(message: "Awesome, you just set up your terminal. Move on to the [**next page**](@next) and learn about interesting terminal commands!")

//#-end-hidden-code
