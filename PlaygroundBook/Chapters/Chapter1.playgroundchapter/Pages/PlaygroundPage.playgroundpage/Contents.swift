//#-hidden-code
//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  The Swift file containing the source code edited by the user of this playground book.
//


//Messaging from Page to Live View:
import Foundation
import UIKit
//Use the call below to send a message with an object to the LiveView of this page. Import Foundation is required.
//sendValue(.data(try NSKeyedArchiver.archivedData(withRootObject: /*YourObject*/, requiringSecureCoding: true)))



//Give hints and final solution:
//PlaygroundPage.current.assessmentStatus = .fail(
//hints: [
//"You could [...].",
//"Try also [...]."
//],
//solution:
//"Do [...]."
//)



// Completion of user-entered code:
//Use //#-code-completion syntax to allow only specified code to be entered by the user. (info here: https://developer.apple.com/documentation/swift_playgrounds/customizing_the_completions_in_the_shortcut_bar)


//#-end-hidden-code

let name = /*#-editable-code*/<#T##your name##String#>/*#-end-editable-code*/
let textSize = /*#-editable-code*/<#T##size of the text##String#>/*#-end-editable-code*/
let textColor = /*#-editable-code*/#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)/*#-end-editable-code*/
let backgroundColor = /*#-editable-code*/#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)/*#-end-editable-code*/

//#-hidden-code
let terminalSettings = TerminalSettings(textColor: textColor, textSize: textSize, backgroundColor: backgroundColor, username: name)
let encoder = JSONEncoder()
sendValue(.data(try encoder.encode(terminalSettings)))
//#-end-hidden-code
