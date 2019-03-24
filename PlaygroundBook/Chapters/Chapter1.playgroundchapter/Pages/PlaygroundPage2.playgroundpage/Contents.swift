//#-code-completion(everything, hide)
//#-hidden-code

import Foundation
import PlaygroundSupport

//#-end-hidden-code

/*:
 # Get Some Help, Man!
 
 Learning nowadays is very simple and fast thanks to the internet. But how did people learn, when there was no internet?! **THEY READ MANUALS!**
 
 That is why most of the commands have manual pages. To read manual pages use the `man` command and pass a name of a command as an argument.
 
 You are going to learn more commands, so what about reading a manual before using a new command?
 
 ## Executing Commands
 
 Executing terminal commands in this Playground is very simple. Just set the variable `command` with your terminal command as a `String` and run the code.
 
 For example: `let command = "man man"`, if you want to execute `man man` in the terminal.
 
 ## Practice Time
 
 **Try this:**
 
 ###
 
 1. Execute command `man` to see what commands are available.
 2. Open manual pages of `man` or any other commands.
 
 */

let command = /*#-editable-code*/""/*#-end-editable-code*/

//#-hidden-code

sendValue(.data(try NSKeyedArchiver.archivedData(withRootObject: command, requiringSecureCoding: true)))

if command == "man man" || command == "man" {
    PlaygroundPage.current.assessmentStatus = .pass(message: "Well done! You just executed your first terminal command. You can move on to the [**next page**](@next) or read manuals of all commands!")

}

//#-end-hidden-code


