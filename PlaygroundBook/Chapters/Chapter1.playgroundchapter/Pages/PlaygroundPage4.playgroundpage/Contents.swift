//#-hidden-code

import Foundation

//#-end-hidden-code

/*:
 
 # Is it in the Downloads?
 
 You can change your directory with the command `cd` (short for "change directory") and a path that you pass to it as an argument. The directory will be changed according to the path, if it exists.
 
 Paths and hierarchy
 
 There are different ways how to pass a path to `cd` or any other commands:
 
 ###
 * `cd ./Desktop` or `cd Desktop`: Relative paths related to the current location are passed as an argument. The working directory will be changed if there is a folder called "Desktop" in the current working directory. `cd ./Desktop` can be translated as "change to the directory (cd) that is in the current working directory (./) and it is called Desktop". `cd .` or `cd ./` would mean that working directory is being changed to the current working directory - that means that the directory is not changing.
 
 * `cd /Users/user/Desktop`: Absoluthe path is passed as an argument. The hierarchy of folders starts with folder **"\/"**. The command begins navigating to the final directory from the the start of the hierarchy. `cd /` would mean that the working directory is being changed to the highest folder in the hierarchy.
 
 * `cd ..`: A special folder name **.** can be used for navigating one level up in the hierarchy. `cd ../users` can be translated to "change directory (cd) that is one level above the current working directory and it is named users". That means that folder "users" is on the same level of the hierarchy like the current one and both directories are in the same directory. `cd ..` or `cd ../` would mean that the working directory is being changed to the directory that the current directory is in.
 
 **Try this:**
 ###
 
 1. List names of all files and folders with more detailed information in the working directory with [`ls`](@previous).
 2. Select one directory and change the working directory to it.
 3. Change the working directory to the "/".
 4. Change the directory to directory called "Volumes"
 
 */

let command: String = /*#-editable-code*//*#-end-editable-code*/
    
//#-hidden-code
    
sendValue(.data(try NSKeyedArchiver.archivedData(withRootObject: command, requiringSecureCoding: true)))
if command == "cd /" {
    PlaygroundPage.current.assessmentStatus = .pass(message: "WOW! You know how navigate through the hierarchy of folders. You can go to the [**previous page**](@previous) and try `ls` with different paths or you can move on to the [**next page**](@next).")
}

//#-end-hidden-code


