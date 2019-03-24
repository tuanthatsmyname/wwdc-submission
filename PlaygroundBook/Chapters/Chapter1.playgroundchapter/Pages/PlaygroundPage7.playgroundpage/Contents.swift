//#-code-completion(everything, hide)
//#-hidden-code

import Foundation
import PlaygroundSupport

//#-end-hidden-code

/*:
 # Deleting Files and Directories
 
 ## Deleting Files
 
 To delete a file use command `rm` (short for "remove") and pass a path to the file as an argument.
 
 Example: `rm ./file.txt`
 
 ## Deleting Directories
 
 Deleting directories require usage of special options:
 
 ###
 
 * Option `-r` deletes the directory and the whole hierarchy below it.
 * Option `-f` removes the files without prompting for confirmation.
 
 ### More options
 
 Adding two or more options to a command is simple. Either you specify every option separately or together as one option:

 ###
 
 * Example 1: `rm -r -f ./tmp`
 * Example 2: `rm -rf ./tmp`

 In both examples the directory "tmp" in the working directory and the whole hierarchy below it will be deleted.
 
 **Try this:**
 
 ###
 
 1. Create a hierarchy of folders in your home directory with directories and files.
 2. Experiment with deleting files and then directories with hierarchy.
 
 */

let command = /*#-editable-code*/""/*#-end-editable-code*/
    
//#-hidden-code
    
sendValue(.data(try NSKeyedArchiver.archivedData(withRootObject: command, requiringSecureCoding: true)))

//#-end-hidden-code


