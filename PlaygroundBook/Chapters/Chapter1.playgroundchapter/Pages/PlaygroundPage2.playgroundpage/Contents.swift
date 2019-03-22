//#-hidden-code

import Foundation

//#-end-hidden-code

let command: String = /*#-editable-code*//*#-end-editable-code*/

//#-hidden-code

sendValue(.data(try NSKeyedArchiver.archivedData(withRootObject: command, requiringSecureCoding: true)))

//#-end-hidden-code


