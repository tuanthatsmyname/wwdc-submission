//#-code-completion(everything, hide)
//#-hidden-code

import Foundation
import PlaygroundSupport

//#-end-hidden-code

/*:
 # Deleting Files And Directories
 
 ## Deleting Files
 
 To delete a file use command `rm` (short for "remove") and pass a path to the file as an argument.
 
 Examples: `rm ./file.txt`
 
 ## Deleting Directories
 
 Deleting directories require usage of special options.
 
 Example: `rm -rf /`
 
 Option `-r` deletes the whole hierarchy and option `-f` removes the files without prompting for confirmation. In the given example you would delete the root directory which means you would delete the whole Mac. **BE CAREFUL! NEVER DO THAT!**
 
 **Try this:**
 
 ###
 
 1. Create a hierarchy of folders in your home directory with directories and files.
 2. Experiment with deleting files and then directories with hierarchy.
 
 */

let command: String = /*#-editable-code*/""/*#-end-editable-code*/
    
//#-hidden-code
    
sendValue(.data(try NSKeyedArchiver.archivedData(withRootObject: command, requiringSecureCoding: true)))

//#-end-hidden-code


