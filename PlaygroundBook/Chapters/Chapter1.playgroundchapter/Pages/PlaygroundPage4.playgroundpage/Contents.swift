//#-code-completion(everything, hide)
//#-hidden-code

import Foundation
import PlaygroundSupport

//#-end-hidden-code

/*:
 
 # Is It In The Downloads?
 
 You can change your working directory with the command `cd` (short for "change directory") and a path that you pass as an argument. The directory will be changed according to the path, if it exists.
 
 For example: `cd ./Desktop`
 
 ## Paths and hierarchy
 
 There are different ways how to pass a path to commands:
 
 ###
 * `cd ./Desktop` or `cd Desktop` are relative paths that are related to the current working directory. Both examples are meant to change the working directory to the directory called "Desktop" that is in the current working directory.
 
 * `cd /Users/user/Desktop` is an absolute path. The hierarchy of directories starts with directory "/" called "root". `cd /` would mean that the working directory is being changed to the highest directory in the hierarchy.
 
 * `cd ..` is a relative path with special directory name "..". `cd ..` or `cd ../` would mean that the working directory is being changed to the directory that the current directory is in.
 
 ## Directories
 
 ###
 
 * **Working directory** is a directory that a user is currently in. In our case the absolute path of the working directory is shown in the prompt. You can use relative paths `.` or `./` as well.
 * **Root directory** is a highest directory in the hierarchy. There is no other directory above that level. The absoluthe path is `/`.
 * **Home directory** is a directory of a user. In our case the absolute path to the home directory is "/Users/username".
 
 **Try this:**
 ###
 
 1. List names of all files and folders with more detailed information in the working directory.
 2. Select one directory and change the working directory to it.
 3. Change the working directory to the "/".
 4. Change the working directory to a directory called "Volumes"
 
 */

let command: String = /*#-editable-code*/""/*#-end-editable-code*/
    
//#-hidden-code
    
sendValue(.data(try NSKeyedArchiver.archivedData(withRootObject: command, requiringSecureCoding: true)))
if command == "cd /" {
    PlaygroundPage.current.assessmentStatus = .pass(message: "WOW! You know how navigate through the hierarchy of folders. You can go to the [**previous page**](@previous) and try `ls` with different paths or you can move on to the [**next page**](@next).")
}

//#-end-hidden-code


