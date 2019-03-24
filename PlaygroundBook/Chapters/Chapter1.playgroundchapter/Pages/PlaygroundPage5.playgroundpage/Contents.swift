//#-code-completion(everything, hide)
//#-hidden-code

import Foundation
import PlaygroundSupport


//#-end-hidden-code

/*:
 
 # Creating a New File
 
 To create a new file use command `touch` and pass a path and a name of the new file as an argument.
 
 For example: `touch ./newFile.txt`
 
 The given example will create a file called "newFile.txt" in the current working directory. **You can not create a file in a nonexistent directory.** Therefore the path that you pass as an argument to the command must exist.
 
 ***Try this:***
 
 ###
 
 1. Navigate to a directory of your choice.
 2. Create a new file called "test.txt".
 
 */

let command = /*#-editable-code*/""/*#-end-editable-code*/
    
//#-hidden-code
    
sendValue(.data(try NSKeyedArchiver.archivedData(withRootObject: command, requiringSecureCoding: true)))

if command == "touch ./test.txt" || command == "touch test.txt" {
    PlaygroundPage.current.assessmentStatus = .pass(message: "GG! You can move on to the [**next page**](@next) and learn how to create a directory.")
}

//#-end-hidden-code


