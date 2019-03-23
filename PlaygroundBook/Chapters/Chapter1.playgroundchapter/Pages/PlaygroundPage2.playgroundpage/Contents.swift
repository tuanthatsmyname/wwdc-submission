//#-code-completion(everything, hide)
//#-hidden-code

import Foundation
import PlaygroundSupport

//#-end-hidden-code

/*:
 # Get some help, man!
 
 Learning nowadays is very simple and fast thanks to the internet. But how did people learn, when there was no internet?! **THEY READ MANUALS!**
 
 That is why most of the commands have manual pages. To read those pages use the `man` command and pass a name of a command that you would like to know more about as an argument.
 
 You are going to learn more commands, so what about reading a manual before using a new command?
 
 ## Executing commands
 
 Executing terminal commands in this Playground is very simple. Just set the variable `command` with your terminal command as a `String` and run the code. For example: `let command: String = "man man"`.
 
 **Let's read a manual page for the command `man`**.
 
 */

let command: String = /*#-editable-code*//*#-end-editable-code*/

//#-hidden-code

sendValue(.data(try NSKeyedArchiver.archivedData(withRootObject: command, requiringSecureCoding: true)))

if command == "man man" {
    PlaygroundPage.current.assessmentStatus = .pass(message: "Well done! You just executed your first terminal command. You can move on to the [**next page**](@next) and learn something new!")

}

//#-end-hidden-code


