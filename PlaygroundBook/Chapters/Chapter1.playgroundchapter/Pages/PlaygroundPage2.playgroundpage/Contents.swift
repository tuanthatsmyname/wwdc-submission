//#-hidden-code

import Foundation

//#-end-hidden-code

let name: String = /*#-editable-code*//*#-end-editable-code*/

//#-hidden-code

sendValue(.data(try NSKeyedArchiver.archivedData(withRootObject: name, requiringSecureCoding: true)))

//#-end-hidden-code


