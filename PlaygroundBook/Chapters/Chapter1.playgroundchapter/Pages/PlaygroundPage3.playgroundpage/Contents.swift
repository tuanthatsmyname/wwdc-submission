//#-code-completion(everything, hide)
//#-hidden-code

import Foundation
import PlaygroundSupport

//#-end-hidden-code

/*:
 # What do we have here?
 
 Not always do we know the exact name of a file or a folder that we want to work with. Use command `ls` (short for "list") to list names of all files and folders in the working directory.
 
 If you want to list all of the files and folders from a directory different from the current working one, you can pass a path to the command as a argument. For example: `ls /Volumes`. Paths are explained in the [**next page**](@next), so don't worry!
 
 ## Options
 
 An option usually modifies the way the program runs. For example the option `-l` (short for "long") of the command `ls` will display a list of files and directories with more detailed information. Options are optional, and every command has different options. For example `ls -l` or `ls -l /Volumes`, if you want to specify the directory.
 
 **Try this:**
 ###
 
 1. List names of all files and folders in the working directory.
 2. List names of all files and folders with more detailed information in the working directory.
 
 */

let command: String = /*#-editable-code*//*#-end-editable-code*/
    
//#-hidden-code
    
sendValue(.data(try NSKeyedArchiver.archivedData(withRootObject: command, requiringSecureCoding: true)))

switch command {
case "ls -l .", "ls -l ./", "ls -l":
    PlaygroundPage.current.assessmentStatus = .pass(message: "Good job! You just executed a command with an option. You can move on to the [**next page**](@next) and learn something new!")
default:
    break
}

//#-end-hidden-code


