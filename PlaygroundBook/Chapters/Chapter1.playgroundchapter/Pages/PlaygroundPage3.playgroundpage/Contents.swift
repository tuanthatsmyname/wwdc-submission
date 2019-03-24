//#-code-completion(everything, hide)
//#-hidden-code

import Foundation
import PlaygroundSupport

//#-end-hidden-code

/*:
 # What Do We Have Here?
 
 Use command `ls` (short for "list") to list names of all files and directories in the working directory.
 
 Example: `ls`
 
 If you want to list all of the files and directories in a different directory, pass a path to the directory as an argument.
 
 Example: `ls /Volumes`
 
 In the given exmaple "/Volumes" is the path. Paths and directories are explained in the [**next page**](@next).
 
 ## Options
 
 An option modifies the way the program runs.
 
 Example 1: `ls -l`
 
 Example 2: `ls -l /Volumes`
 
 Option `-l` of a command `ls` will display list of all files and directories with additional detailed information. Options are optional, and every command has different options.
 
 ## Reading an Output
 
 What do all of the lines from command `ls -l` mean? Let's find out! Every line is information of a file or a directory. Each information on the line is separated by a space.
 
 Example: `d 1 username staff 256 03-24-19 12:01 Desktop`
 
 ###
 
 1. column specifies the permissions of the file. In our terminal it specifies the type - `d` for directories and `f` for files.
 2. column specifies number of links that are connected.
 3. column specifies the owner of the file/directory.
 4. column specifies user group that the owner belongs to.
 5. column specifies the size.
 6. column specifies the date of the last modification.
 7. column specifies the time of the last modification.
 8. column sepcifies the name.
 
 ## Practice Time
 
 **Try this:**
 ###
 
 1. List names of all files and directories in the working directory.
 2. List names of all files and directories with more detailed information in the working directory.
 
 */

let command = /*#-editable-code*/""/*#-end-editable-code*/
    
//#-hidden-code
    
sendValue(.data(try NSKeyedArchiver.archivedData(withRootObject: command, requiringSecureCoding: true)))

switch command {
case "ls -l .", "ls -l ./", "ls -l":
    PlaygroundPage.current.assessmentStatus = .pass(message: "Good job! You just executed a command with an option. You can move on to the [**next page**](@next) and learn something new!")
default:
    break
}

//#-end-hidden-code


