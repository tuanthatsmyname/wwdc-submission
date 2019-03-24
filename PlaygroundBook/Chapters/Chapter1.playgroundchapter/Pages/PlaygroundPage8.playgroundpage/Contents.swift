//#-code-completion(everything, hide)
//#-hidden-code

import Foundation
import PlaygroundSupport

//#-end-hidden-code

/*:
 # Printing File Contents
 
 You can use command `cat` (short for "concatenate") with a path to the file as an argument to print the content of the file.
 
 Example: `cat ./helloWorld.swift`
 
 **Try this:**
 
 ###
 
 1. Navigate to "/Volumes/MacintoshHD".
 2. Check what file is in the directory.
 2. Print the content of that file.
 3. Be happy.
 
 */

let command = /*#-editable-code*/""/*#-end-editable-code*/
    
//#-hidden-code
    
sendValue(.data(try NSKeyedArchiver.archivedData(withRootObject: command, requiringSecureCoding: true)))

switch command {
case "cat ./messageWithLove.txt", "cat messageWithLove.txt":
    PlaygroundPage.current.assessmentStatus = .pass(message: "You are almost done, move on to the [**next page**](@next) and enjoy the ride!")
default:
    break
}

//#-end-hidden-code


