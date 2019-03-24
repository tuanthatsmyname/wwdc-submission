//#-code-completion(everything, hide)
//#-hidden-code

import Foundation
import PlaygroundSupport

//#-end-hidden-code

/*:
 # Executing Swift Programs
 
 To execute Swift programs use command `swift` with a path to a Swift file as an argument.
 
 For example: `swift ./hello.swift`
 
 **Try this:**
 
 ###
 
 1. Navigate to your home directory.
 2. Execute Swift file called "helloWorld.swift".
 
 */

let command = /*#-editable-code*/""/*#-end-editable-code*/
    
//#-hidden-code
    
sendValue(.data(try NSKeyedArchiver.archivedData(withRootObject: command, requiringSecureCoding: true)))

switch command {
case "swift ./helloWorld.swift", "swift helloWorld.swift":
    PlaygroundPage.current.assessmentStatus = .pass(message: "Yay! So you want to be a Swift developer, heh? You can move on to the [**next page**](@next).")
default:
    break
}

//#-end-hidden-code


