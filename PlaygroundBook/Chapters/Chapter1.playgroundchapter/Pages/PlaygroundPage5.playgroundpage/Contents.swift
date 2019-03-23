//#-hidden-code

import Foundation

//#-end-hidden-code

/*:
 
 # Create a new file
 
 Creating a new file is easy with the command `touch`. All you have to do is pass it a path with a file name as an argument. For example: `touch ./newFile.txt` will create a file called newFile.txt in the current working directory. But you can create files whenever you want to, if the directory exists!
 
 **Try to create a new file in a directory of your choice called "test.txt".**
 
 */

let command: String = /*#-editable-code*//*#-end-editable-code*/
    
//#-hidden-code
    
sendValue(.data(try NSKeyedArchiver.archivedData(withRootObject: command, requiringSecureCoding: true)))

if command == "touch ./test.txt" || command == "touch test.txt" {
    PlaygroundPage.current.assessmentStatus = .pass(message: "GG! You can move on to the [**next page**](@next) and learn how to create a directory.")
}

//#-end-hidden-code


