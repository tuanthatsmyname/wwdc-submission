//#-code-completion(everything, hide)
//#-hidden-code

import Foundation
import PlaygroundSupport

//#-end-hidden-code

/*:
 # What Do We Have Here?
 
 Use command `ls` (short for "list") to list names of all files and folders in the working directory.
 
 If you want to list all of the files and folders in a different directory, pass a path to the directory as an argument.
 
 Example: `ls` or `ls /Volumes`
 
 Paths and directories are explained in the [**next page**](@next).
 
 ## Options
 
 An option modifies the way the program runs.
 
 For example: `ls -l` or `ls -l /Volumes`
 
 In the given example the option will display list of all files and directories with additional detailed information. Options are optional, and every command has different option.
 
 ## Reading An Output Of `ls -l`
 
 
 
 **Try this:**
 ###
 
 1. List names of all files and directories in the working directory.
 2. List names of all files and directories with more detailed information in the working directory.
 
 */

let command: String = /*#-editable-code*/""/*#-end-editable-code*/
    
//#-hidden-code
    
sendValue(.data(try NSKeyedArchiver.archivedData(withRootObject: command, requiringSecureCoding: true)))

switch command {
case "ls -l .", "ls -l ./", "ls -l":
    PlaygroundPage.current.assessmentStatus = .pass(message: "Good job! You just executed a command with an option. You can move on to the [**next page**](@next) and learn something new!")
default:
    break
}

//#-end-hidden-code


