//#-code-completion(everything, hide)
//#-hidden-code

import Foundation
import PlaygroundSupport


//#-end-hidden-code

/*:
 # Creating a New Directory
 
 Creating a new directory is as easy as creating a new file. Use command `mkdir` (short for "make directory") with a path and a name as an argument to create a new directory.
 
 For example: `mkdir ./tmp/newFolder`
 
 The given example will create a new directory called "newFolder" in the directory "tmp" that is in the current working directory. **You can not create a directory in a nonexistent directory.** Therefore the path that you pass as an argument to the command must exist.
 
 **Try this:**
 
 ###
 
 1. Navigate to your home directory.
 2. Create a new directory called "tmp".
 
 */

let command = /*#-editable-code*/""/*#-end-editable-code*/
    
//#-hidden-code

sendValue(.data(try NSKeyedArchiver.archivedData(withRootObject: command, requiringSecureCoding: true)))

if command == "mkdir ./tmp" || command == "mkdir tmp" {
    PlaygroundPage.current.assessmentStatus = .pass(message: "Yes! You can move on to the [**next page**](@next) and learn how to delete files and directories.")
}

//#-end-hidden-code


