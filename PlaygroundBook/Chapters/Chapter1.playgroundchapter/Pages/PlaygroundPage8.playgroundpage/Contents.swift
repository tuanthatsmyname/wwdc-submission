//#-hidden-code

import Foundation

//#-end-hidden-code

/*:
 
 **Let's try the new command that you have just learn!**
 
 */

let command: String = /*#-editable-code*//*#-end-editable-code*/
    
    //#-hidden-code
    
    sendValue(.data(try NSKeyedArchiver.archivedData(withRootObject: command, requiringSecureCoding: true)))

//#-end-hidden-code


