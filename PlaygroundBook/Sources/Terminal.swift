//
//  Terminal.swift
//  Book_Sources
//
//  Created by Tuan Tu Do on 16/03/2019.
//

import Foundation

enum Commands: String {
    case ls = "ls"
    case cd = "cd"
    case man = "man"
    case touch = "touch"
    case mkdir = "mkdir"
    case rm = "rm"
    case cat = "cat"
    case swift = "swift"
}

public class Terminal {
    
    private var paths: [String : [TerminalElement]]
    public var currentPath: String // TODO: make private
    
    public init(paths: [String : [TerminalElement]], currentPath: String) {
        self.paths = paths
        self.currentPath = currentPath
    }
    
    // execute command given by the user
    public func execute(command: String) {
        
        let splittedCommand = command.split(separator: " ")
        
        // no command was given by the user
        if splittedCommand.count == 0 {
            // TODO: print in the terminal
            // TODO: add another text for MAN
            print("command not found")
            return
        }
        
        // command given by the user
        let command = String(splittedCommand[0])
        
        // arguments given by the user
        var arguments = [String]()
        for index in 1..<splittedCommand.count {
            arguments.append(String(splittedCommand[index]))
        }
        
        // executing commands with arguments given by the user
        switch command {
        case Commands.ls.rawValue:
            ls(with: arguments)
        case Commands.cd.rawValue:
            cd(with: arguments)
        case Commands.touch.rawValue:
            touch(with: arguments)
        case Commands.mkdir.rawValue:
            mkdir(with: arguments)
        case Commands.rm.rawValue:
            rm(with: arguments)
        case Commands.cat.rawValue:
            cat(with: arguments)
        case Commands.swift.rawValue:
            swift(with: arguments)
        case Commands.man.rawValue:
            man(with: arguments)
        default:
            // TODO: print in the terminal
            // TODO: add another text for MAN
            print("\(command): command not found")
            return
        }
        
    }
    
    private func listAllTerminalElements(from path: String) {
        for terminalElement in paths[path]! {
            // TODO: print in the terminal
            print(terminalElement.name)
        }
    }
    
    private func listAllTerminalElements(from directory: [TerminalElement]) {
        for terminalElement in directory {
            // TODO: print in the terminal
            print(terminalElement.name)
        }
    }
    
    private func listAllTerminalElementsWithDetails(from path: String) {
        for terminalElement in paths[path]! {
            // TODO: print in the terminal
            print(terminalElement.print())
        }
    }
    
    private func listAllTerminalElementsWithDetails(from directory: [TerminalElement]) {
        for terminalElement in directory {
            // TODO: print in the terminal
            print(terminalElement.print())
        }
    }
    
    private func getParentFolderPath(from path: String) -> String {
        let directories = path.split(separator: "/")
        var parentFolderPath = ""
        if directories.count < 2 {
            parentFolderPath += "/"
        } else {
            for index in 0..<directories.count-1 {
                parentFolderPath += "/\(directories[index])"
            }
        }
        return parentFolderPath
    }
    
    private func ls(with arguments: [String]) {
        
        switch arguments.count {
            
        // ls
        case 0:
            listAllTerminalElements(from: currentPath)
            
        // ls -l | ls directory
        case 1:
            
            let argument = String(arguments[0])
            
            // check if the argument should be an option or a directory
            switch argument.first! {
                
            // should be an option
            case "-":
                if argument == "-l" {
                    listAllTerminalElementsWithDetails(from: currentPath)
                } else {
                    // TODO: print in the terminal
                    print("ls: illegal option \(argument)")
                    print("usage: ls [-l] [directory]")
                }
                
            // should be a directory
            default:
                switch argument {
                case "..", "../":
                    if currentPath == "/" {
                        listAllTerminalElements(from: currentPath)
                    } else {
                        let parentFolderPath = getParentFolderPath(from: currentPath)
                        listAllTerminalElements(from: parentFolderPath)
                    }
                case ".", "./":
                    listAllTerminalElements(from: currentPath)
                case "/":
                    listAllTerminalElements(from: "/")
                default:
                    switch argument.first! {
                    case ".":
                        let splittedArgument = argument.split(separator: "/")
                        
                        if splittedArgument.count < 2 {
                            // TODO: print in the terminal
                            print("ls: \(argument): no such file or directory")
                            return
                        }
                        
                        var path = ""
                        
                        switch String(splittedArgument[0]) {
                        case ".":
                            path = currentPath
                        case "..":
                            if currentPath == "/" {
                                path = currentPath
                            } else {
                                path = getParentFolderPath(from: currentPath)
                            }
                        default:
                            // TODO: print in the terminal
                            print("ls: \(argument): no such file or directory")
                            return
                        }
                        
                        for index in 1..<splittedArgument.count {
                            path += "/\(splittedArgument[index])"
                        }
                        
                        if let directory = paths[path] {
                            listAllTerminalElements(from: directory)
                        } else {
                            // TODO: print in the terminal
                            print("ls: \(argument): No such file or directory")
                        }
                        
                    case "/":
                        if let directory = paths[argument] {
                            listAllTerminalElements(from: directory)
                        } else {
                            // TODO: print in the terminal
                            print("ls: \(argument): no such file or directory")
                        }
                    default:
                        let path = currentPath + "/" + argument
                        if let directory = paths[path] {
                            listAllTerminalElements(from: directory)
                        } else {
                            // TODO: print in the terminal
                            print("ls: \(argument): no such file or directory")
                        }
                    }
                }
            }
            
        // ls -l directory
        case 2:
            let option = arguments[0]
            let directory = arguments[1]
            
            if option != "-l" {
                // TODO: print in the terminal
                print("ls: illegal option \(arguments[0])")
                print("usage: ls [-l] [directory]")
                return
            }
            
            switch directory {
            case "..", "../":
                if currentPath == "/" {
                    listAllTerminalElementsWithDetails(from: currentPath)
                } else {
                    let parentFolderPath = getParentFolderPath(from: currentPath)
                    listAllTerminalElementsWithDetails(from: parentFolderPath)
                }
            case ".", "./":
                listAllTerminalElementsWithDetails(from: currentPath)
            case "/":
                listAllTerminalElementsWithDetails(from: "/")
            default:
                switch directory.first! {
                case ".":
                    let splittedArgument = directory.split(separator: "/")
                    
                    if splittedArgument.count < 2 {
                        // TODO: print in the terminal
                        print("ls: \(directory): No such file or directory")
                        return
                    }
                    
                    var path = ""
                    
                    switch String(splittedArgument[0]) {
                    case ".":
                        path = currentPath
                    case "..":
                        if currentPath == "/" {
                            path = currentPath
                        } else {
                            path = getParentFolderPath(from: currentPath)
                        }
                    default:
                        // TODO: print in the terminal
                        print("ls: \(directory): No such file or directory")
                    }
                    
                    for index in 1..<splittedArgument.count {
                        path += "/\(splittedArgument[index])"
                    }
                    
                    if let directory = paths[path] {
                        listAllTerminalElementsWithDetails(from: directory)
                    } else {
                        // TODO: print in the terminal
                        print("ls: \(directory): No such file or directory")
                    }
                    
                case "/":
                    if let directory = paths[directory] {
                        listAllTerminalElementsWithDetails(from: directory)
                    } else {
                        // TODO: print in the terminal
                        print("ls: \(directory): No such file or directory")
                    }
                default:
                    let path = currentPath + "/" + directory
                    if let directory = paths[path] {
                        listAllTerminalElementsWithDetails(from: directory)
                    } else {
                        // TODO: print in the terminal
                        print("ls: \(directory): No such file or directory")
                    }
                }
            }
            
        default:
            // TODO: print in the terminal
            print("ls: too many arguments")
        }
        
    }
    
    private func cd(with arguments: [String]) {
        
        if arguments.count != 1 {
            // TODO: print in the terminal
            print("cd: too many arguments")
            return
        }
        
        let argument = String(arguments[0])
        
        switch argument {
        case "..", "../":
            if currentPath != "/" {
                currentPath = getParentFolderPath(from: currentPath)
            }
        case ".", "./":
            break
        case "/":
            currentPath = "/"
        default:
            
            var path = ""
            
            switch argument.first! {
            case ".":
                let splittedArgument = argument.split(separator: "/")
                
                if splittedArgument.count < 2 {
                    // TODO: print in the terminal
                    print("cd: \(argument): No such file or directory")
                    break
                }
                
                switch String(splittedArgument[0]) {
                case ".":
                    if currentPath != "/" {
                        path = currentPath
                    }
                case "..":
                    if currentPath == "/" {
                        path = currentPath
                    } else {
                        path = getParentFolderPath(from: currentPath)
                    }
                default:
                    // TODO: print in the terminal
                    print("cd: \(argument): No such file or directory")
                }
                
                for index in 1..<splittedArgument.count {
                    path += "/\(splittedArgument[index])"
                }
                
            case "/":
                break
            default:
                path = currentPath + "/" + argument
            }
            
            if paths[path] != nil {
                currentPath = path
            } else {
                // TODO: print in the terminal
                print("cd: \(argument): No such file or directory")
            }
            
        }
        
        
    }
    
    private func touch(with arguments: [String]) {
        
        if arguments.count != 1 {
            // TODO: print in the terminal
            print("touch: too many arguments")
            return
        }
        
        let argument = String(arguments[0])
        
        var path = ""
        var newFileName = ""
        
        switch argument.first! {
        case ".":
            let splittedArgument = argument.split(separator: "/")
            
            if splittedArgument.count < 2 {
                // TODO: print in the terminal
                print("touch: \(argument): no such file or directory")
                return
            }
            
            switch String(splittedArgument[0]) {
            case ".":
                if currentPath != "/" {
                    path = currentPath
                }
            case "..":
                if currentPath == "/" {
                    path = currentPath
                } else {
                    path = getParentFolderPath(from: currentPath)
                }
            default:
                // TODO: print in the terminal
                print("touch: \(argument): no such file or directory")
                return
            }
            
            for index in 1..<splittedArgument.count-1 {
                path += "/\(splittedArgument[index])"
            }
            
            newFileName = String(splittedArgument.last!)
        case "/":
            let splitted = argument.split(separator: "/")
            if splitted.count < 1 {
                // TODO: print in the terminal
                print("touch: \(argument): invalid name of a file")
                print("usage: touch [name.extension]")
                return
            }
            
            path = getParentFolderPath(from: argument)
            newFileName = String(splitted.last!)
        default:
            path = currentPath
            newFileName = argument
        }
        
        if paths[path] == nil {
            // TODO: print in the terminal
            print("touch: \(argument): no such file or directory")
            return
        }
        
        if newFileName.isValidFileName {
            var sameFileNameFound = false
            for terminalElement in paths[path]! {
                if let file = terminalElement as? File {
                    if file.name == newFileName {
                        // TODO: print in the terminal
                        print("touch: \(newFileName): file already exists")
                        sameFileNameFound = true
                        break
                    }
                }
            }
            if sameFileNameFound == false {
                let file = File(permissions: "f", numberOfLinks: 1, ownerName: "Tuan", ownerGroup: "root", size: 128, timeOfLastModification: Date(), name: newFileName, content: "")
                paths[path]!.append(file)
            }
        } else {
            // TODO: print in the terminal
            print("touch: \(newFileName): invalid name of a file")
            print("usage: touch [name.extension]")
        }
    }
    
    private func mkdir(with arguments: [String]) {
        if arguments.count != 1 {
            // TODO: print in the terminal
            print("mdkir: too many arguments")
            return
        }
        
        let argument = String(arguments[0])
        var path = ""
        var newFolderName = ""
        
        switch argument.first! {
        case ".":
            let splittedArgument = argument.split(separator: "/")
            if splittedArgument.count < 2 {
                // TODO: print in the terminal
                print("mkdir: \(argument): no such file or directory")
                return
            }
            
            switch String(splittedArgument[0]) {
            case ".":
                if currentPath != "/" {
                    path = currentPath
                }
            case "..":
                if currentPath == "/" {
                    path = currentPath
                } else {
                    path = getParentFolderPath(from: currentPath)
                }
            default:
                // TODO: print in the terminal
                print("mkdir: \(argument): no such file or directory")
                return
            }
            
            for index in 1..<splittedArgument.count-1 {
                path += "/\(splittedArgument[index])"
            }
            
            newFolderName = String(splittedArgument.last!)
            
        // touch /text.txt
        case "/":
            let splitted = argument.split(separator: "/")
            if splitted.count < 1 {
                // TODO: print in the terminal
                print("mkdir: \(argument): invalid name of a directory")
                return
            }
            path = getParentFolderPath(from: argument)
            newFolderName = String(splitted.last!)
            
        // command argument
        default:
            path = currentPath
            newFolderName = argument
        }
        
        if paths[path] == nil {
            // TODO: print in the terminal
            print("mdkir: \(argument): no such file or directory")
            return
        }
        
        if newFolderName.isValidFolderName {
            var sameFolderNameFound = false
            for terminalElement in paths[path]! {
                if let folder = terminalElement as? Folder {
                    if folder.name == newFolderName {
                        // TODO: print in the terminal
                        print("mkdir: \(newFolderName): directory already exists")
                        sameFolderNameFound = true
                        break
                    }
                }
            }
            if sameFolderNameFound == false {
                let folder = Folder(permissions: "d", numberOfLinks: 1, ownerName: "Tuan", ownerGroup: "root", size: 256, timeOfLastModification: Date(), name: newFolderName, parentFolderPath: path)
                paths[path]!.append(folder)
                paths[path + "/" + newFolderName] = [TerminalElement]()
            }
        } else {
            // TODO: print in the terminal
            print("mkdir: \(newFolderName): invalid name of a directory")
            print("usage: mkdir [name]")
        }
        
    }
    
    private func rm(with arguments: [String]) {
        switch arguments.count {
        case 1:
            let argument = String(arguments[0])
            var fileName = ""
            var path = ""
            
            switch argument.first! {
                
            case ".":
                let splittedArgument = argument.split(separator: "/")
                
                if splittedArgument.count < 2 {
                    // TODO: print in the terminal
                    print("rm: \(argument): no such file or directory")
                    return
                }
                
                switch String(splittedArgument[0]) {
                    
                case ".":
                    
                    if currentPath != "/" {
                        path = currentPath
                    }
                    for index in 1..<splittedArgument.count-1 {
                        path += "/\(splittedArgument[index])"
                    }
                    
                    fileName = String(splittedArgument.last!)
                    
                case "..":
                    
                    if currentPath == "/" {
                        path = currentPath
                    } else {
                        path = getParentFolderPath(from: currentPath)
                    }
                    for index in 1..<splittedArgument.count-1 {
                        path += "/\(splittedArgument[index])"
                    }
                    
                    fileName = String(splittedArgument.last!)
                    
                default:
                    // TODO: print in the terminal
                    print("rm: \(argument): no such file or directory")
                    return
                }
                
            case "/":
                let splitted = argument.split(separator: "/")
                if splitted.count < 1 {
                    // TODO: print in the terminal
                    print("rm: illegal usage")
                    print("usage: rm [-rf] [directory/file]")
                    return
                }
                
                path = getParentFolderPath(from: argument)
                fileName = String(splitted.last!)
                
            default:
                fileName = argument
                path = currentPath
            }
            
            if let directory = paths[path] {
                var fileFound = false
                var directoryFound = false
                var fileFoundIndex: Int? = nil
                
                for index in 0..<directory.count {
                    let terminalElement = directory[index]
                    if terminalElement.name == fileName {
                        if let _ = terminalElement as? File {
                            fileFound = true
                            fileFoundIndex = index
                            break
                        } else {
                            directoryFound = true
                        }
                    }
                }
                if fileFound == false {
                    if directoryFound == true {
                        // TODO: print in the terminal
                        print("rm: \(argument): is a directory")
                    } else {
                        // TODO: print in the terminal
                        print("rm: \(argument): no such file or directory")
                    }
                } else {
                    paths[path]!.remove(at: fileFoundIndex!)
                }
            } else {
                // TODO: print in the terminal
                print("rm: \(argument): no such file or directory")
            }
        // TODO
        case 2:
            if String(arguments[0]) != "-rf" {
                // TODO: print in the terminal
                print("rm: illegal usage")
                print("usage: rm [-rf] [directory/file]")
            }
            
            let argument = String(arguments[1])
            
            var folderName = ""
            var path = ""
            
            switch argument.first! {
                
            case ".":
                let splittedArgument = argument.split(separator: "/")
                
                if splittedArgument.count < 2 {
                    // TODO: print in the terminal
                    print("rm -rf: \(argument): no such file or directory")
                    return
                }
                
                switch String(splittedArgument[0]) {
                    
                case ".":
                    
                    if currentPath != "/" {
                        path = currentPath
                    }
                    for index in 1..<splittedArgument.count-1 {
                        path += "/\(splittedArgument[index])"
                    }
                    
                    folderName = String(splittedArgument.last!)
                    
                case "..":
                    
                    if currentPath == "/" {
                        path = currentPath
                    } else {
                        path = getParentFolderPath(from: currentPath)
                    }
                    for index in 1..<splittedArgument.count-1 {
                        path += "/\(splittedArgument[index])"
                    }
                    
                    folderName = String(splittedArgument.last!)
                    
                default:
                    // TODO: print in the terminal
                    print("rm -rf: \(argument): no such file or directory")
                    return
                }
                
            case "/":
                let splitted = argument.split(separator: "/")
                if splitted.count < 1 {
                    // TODO: print in the terminal
                    print("rm -rf: illegal usage")
                    print("usage: rm [-rf] [directory/file]")
                    return
                }
                
                path = getParentFolderPath(from: argument)
                folderName = String(splitted.last!)
                
            default:
                folderName = argument
                path = currentPath
            }
            
            if let directory = paths[path] {
                var fileFound = false
                var directoryFound = false
                var folderFoundIndex: Int? = nil
                
                for index in 0..<directory.count {
                    let terminalElement = directory[index]
                    if terminalElement.name == folderName {
                        if let _ = terminalElement as? Folder {
                            directoryFound = true
                            folderFoundIndex = index
                            break
                        } else {
                            fileFound = true
                        }
                    }
                }
                if directoryFound == false {
                    if fileFound == true {
                        // TODO: print in the terminal
                        print("rm -rf: \(argument): is a file")
                    } else {
                        // TODO: print in the terminal
                        print("rm -rf: \(argument): no such file or directory")
                    }
                } else {
                    paths[path]!.remove(at: folderFoundIndex!)
                }
            } else {
                // TODO: print in the terminal
                print("rm -rf: \(argument): no such file or directory")
            }
            
        default:
            // TODO: print in the terminal
            print("rm: illegal usage")
            print("usage: rm [-rf] [directory/file]")
        }
    }
    
    private func cat(with arguments: [String]) {
        if arguments.count != 1 {
            // TODO: print in the terminal
            print("cat: too many arguments")
            return
        }
        
        let argument = String(arguments[0])
        var fileName = ""
        var path = ""
        
        switch argument.first! {
            
        case ".":
            let splittedArgument = argument.split(separator: "/")
            
            if splittedArgument.count < 2 {
                // TODO: print in the terminal
                print("cat: \(argument): no such file or directory")
                return
            }
            
            switch String(splittedArgument[0]) {
                
            case ".":
                
                if currentPath != "/" {
                    path = currentPath
                }
                for index in 1..<splittedArgument.count-1 {
                    path += "/\(splittedArgument[index])"
                }
                
                fileName = String(splittedArgument.last!)
                
            case "..":
                
                if currentPath == "/" {
                    path = currentPath
                } else {
                    path = getParentFolderPath(from: currentPath)
                }
                for index in 1..<splittedArgument.count-1 {
                    path += "/\(splittedArgument[index])"
                }
                
                fileName = String(splittedArgument.last!)
                
            default:
                // TODO: print in the terminal
                print("cat: \(argument): no such file or directory")
                return
            }
            
        case "/":
            let splitted = argument.split(separator: "/")
            if splitted.count < 1 {
                // TODO: print in the terminal
                print("cat: \(argument): invalid name of a file")
                return
            }
            
            path = getParentFolderPath(from: argument)
            fileName = String(splitted.last!)
            
        default:
            fileName = argument
            path = currentPath
        }
        
        if let directory = paths[path] {
            var fileFound = false
            for terminalElement in directory {
                if let file = terminalElement as? File {
                    if file.name == fileName {
                        // TODO: print in the terminal
                        print(file.content)
                        fileFound = true
                        break
                    }
                }
            }
            if fileFound == false {
                // TODO: print in the terminal
                print("cat: \(argument): no such file or directory")
            }
        } else {
            // TODO: print in the terminal
            print("cat: \(argument): no such file or directory")
        }
        
    }
    
    private func swift(with arguments: [String]) {
        if arguments.count != 1 {
            // TODO: print in the terminal
            print("swift: too many arguments")
            return
        }
        
        let argument = String(arguments[0])
        var fileName = ""
        var path = ""
        
        switch argument.first! {
            
        case ".":
            let splittedArgument = argument.split(separator: "/")
            
            if splittedArgument.count < 2 {
                // TODO: print in the terminal
                print("swift: \(argument): no such file or directory")
                return
            }
            
            switch String(splittedArgument[0]) {
                
            case ".":
                
                if currentPath != "/" {
                    path = currentPath
                }
                for index in 1..<splittedArgument.count-1 {
                    path += "/\(splittedArgument[index])"
                }
                
                fileName = String(splittedArgument.last!)
                
            case "..":
                
                if currentPath == "/" {
                    path = currentPath
                } else {
                    path = getParentFolderPath(from: currentPath)
                }
                for index in 1..<splittedArgument.count-1 {
                    path += "/\(splittedArgument[index])"
                }
                
                fileName = String(splittedArgument.last!)
                
            default:
                // TODO: print in the terminal
                print("swift: \(argument): no such file or directory")
                return
            }
            
        case "/":
            let splitted = argument.split(separator: "/")
            if splitted.count < 1 {
                // TODO: print in the terminal
                print("swift: \(argument): invalid name of a file")
                return
            }
            
            path = getParentFolderPath(from: argument)
            fileName = String(splitted.last!)
            
        default:
            fileName = argument
            path = currentPath
        }
        
        if path == "/Users/Tuan", fileName == "helloWorld.swift" {
            print("Hello, world!")
        } else {
            // TODO: print in the terminal
            print("swift: \(argument): could not build")
        }
        
    }
    
    // TODO
    private func man(with arguments: [String]) {
        
    }
    
}

public extension String {
    public var isValidFileName: Bool {
        
        var numberOfPeriods = 0
        for i in self {
            if i == "." {
                numberOfPeriods += 1
            }
        }
        if numberOfPeriods != 1 {
            return false
        }
        
        let splittedString = self.split(separator: ".")
        if splittedString.count != 2 {
            return false
        }
        
        return String(splittedString[0]).range(of: "[^a-zA-Z0-9]", options: .regularExpression, range: nil, locale: nil) == nil && String(splittedString[1]).range(of: "[^a-zA-Z0-9]", options: .regularExpression, range: nil, locale: nil) == nil
    }
    
    public var isValidFolderName: Bool {
        return self.range(of: "[^a-zA-Z0-9]", options: .regularExpression, range: nil, locale: nil) == nil
    }
}
