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

 # Everyone Can Terminal
 
 The Terminal can be a scary place when you first encounter it. It seems like you’ve been sucked into the matrix, expected to decrypt an endless stream of indecipherable characters.
 
 **Fear not, it’s really not that difficult to use. You will see after finishing this Playground!**
 
 ## Anatomy of the Terminal
 
 ###
 
 * **Console** is the system as a whole.
 * **Command line** is a line where you type the command.
 * **Prompt** is a beginning of a command line. It provides some information. In our case the prompt consists of a **computer name and current working directory**.
 * **Terminal** is the interface of a console.
 
 ## Running A Command
 
 Nearly all commands follow a common pattern with 3 main parts: the program, the options (optional), and the arguments (optional).
 
 For example: `ls -l ./Desktop`
 
 ###
 
 * `ls` is the program.
 * `-l` is an option that changes the output of the program.
 * `./Desktop` is an argument of the program.
 
 Commands that are executed successfully do not print any output, if the command is not supposed to print an output. If the command was executed unsuccessfully the error will be printed in the terminal.
 
 ## Setting Up The Terminal
 
 **Set up a terminal that fits your personality!**
 
*/

let name: String = /*#-editable-code*/""/*#-end-editable-code*/
// for best experience set to 16
let textSize: CGFloat = /*#-editable-code*//*#-end-editable-code*/
let textColor: UIColor = /*#-editable-code*/#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)/*#-end-editable-code*/
let backgroundColor: UIColor = /*#-editable-code*/#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)/*#-end-editable-code*/
// set textFont to Font.menlo or Font.courier
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
