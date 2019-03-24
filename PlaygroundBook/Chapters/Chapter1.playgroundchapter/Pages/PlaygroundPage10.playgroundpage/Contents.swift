//#-code-completion(everything, hide)
//#-hidden-code

import Foundation
import PlaygroundSupport

//#-end-hidden-code

/*:
 # Conclusion
 
 Congratulations, you made it to the end of the **Every one can Terminal** Playground!
 
 From now on, you don't have to be scared of using **Terminal**, because you can use:
 
 ###
 1. `man` to read manuals,
 2. `ls` to list files and directories,
 3. `cd` to change directories,
 4. `touch` to create files,
 5. `mkdir` to create directories,
 6. `rm` to delete files or directories,
 7. `cat` to print content of files and
 8. `swift` to execute Swift programs.
 
 Although the technology is moving forward very fast, do remember where all of this fantastic technology comes from and appreciate the hard work of people that helped throughout the whole process. Technology is not necessarily obsolete if it is older. **Using Terminal is cool and sometimes very fast!**
 
 **Maybe it can inspire you to use something new and out of your comfort zone.**
 
 */

// you can still play and experiment with the Terminal
let command = /*#-editable-code*/""/*#-end-editable-code*/
    
//#-hidden-code
    
sendValue(.data(try NSKeyedArchiver.archivedData(withRootObject: command, requiringSecureCoding: true)))

//#-end-hidden-code


