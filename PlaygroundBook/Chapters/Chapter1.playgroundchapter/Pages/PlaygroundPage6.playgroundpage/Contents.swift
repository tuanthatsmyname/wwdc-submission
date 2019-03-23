//#-hidden-code

import Foundation

//#-end-hidden-code

/*:
 # Create a new directory
 
 Creating a new directory is as easy as creating a new file. The command `mkdir`, short for "make directory", with a path and name of the directory, will create a new directory. You need to pass a path that exists, otherwise the comman won't be successfull. For example: `mkdir ./tmp/newFolder` will create a new folder called "newFolder" in the folder called "tmp" that is in the current directory.
 
 **Let's create a new directory called "tmp" in a current working directory!**
 
 */

let command: String = /*#-editable-code*//*#-end-editable-code*/
    
//#-hidden-code

sendValue(.data(try NSKeyedArchiver.archivedData(withRootObject: command, requiringSecureCoding: true)))

if command == "mkdir ./tmp" || command == "mkdir tmp" {
    PlaygroundPage.current.assessmentStatus = .pass(message: "Yes! You can move on to the [**next page**](@next) and learn how to delete files and directories.")
}

//#-end-hidden-code


