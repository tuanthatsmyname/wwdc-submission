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
    public var currentPath: String
    public var username: String
    
    public init(paths: [String : [TerminalElement]], currentPath: String, username: String) {
        self.paths = paths
        self.currentPath = currentPath
        self.username = username
    }
    
    public init(currentPath: String, username: String) {
        self.paths = DataManager.loadHierarchy(with: username)
        self.currentPath = currentPath
        self.username = username
    }
    
    // execute command given by the user
    public func execute(command: String) -> String? {
        
        let splittedCommand = command.split(separator: " ")
        
        // no command was given by the user
        if splittedCommand.count == 0 {
            // TODO: add another text for MAN
            return "command not found"
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
            return ls(with: arguments)
        case Commands.cd.rawValue:
            return cd(with: arguments)
        case Commands.touch.rawValue:
            return touch(with: arguments)
        case Commands.mkdir.rawValue:
            return mkdir(with: arguments)
        case Commands.rm.rawValue:
            return rm(with: arguments)
        case Commands.cat.rawValue:
            return cat(with: arguments)
        case Commands.swift.rawValue:
            return swift(with: arguments)
        case Commands.man.rawValue:
            return man(with: arguments)
        default:
            // TODO: add another text for MAN
            return "\(command): command not found"
        }
        
    }
    
    private func listAllTerminalElements(from path: String) -> String {
        
        var directory = paths[path]!
        var output = ""
        for index in 0..<directory.count {
            if index != 0 {
                output.append(contentsOf: "\n\(directory[index].name)")
            } else {
                output.append(contentsOf: directory[index].name)
            }
        }
        
        return output
    }
    
    private func listAllTerminalElements(from directory: [TerminalElement]) -> String {
        
        var output = ""
        for index in 0..<directory.count {
            if index != 0 {
                output.append(contentsOf: "\n\(directory[index].name)")
            } else {
                output.append(contentsOf: directory[index].name)
            }
        }
        
        return output
    }
    
    private func listAllTerminalElementsWithDetails(from path: String) -> String {
    
        var directory = paths[path]!
        var output = ""
        for index in 0..<directory.count {
            if index != 0 {
                output.append(contentsOf: "\n\(directory[index].print())")
            } else {
                output.append(contentsOf: directory[index].print())
            }
        }
        
        return output
        
    }
    
    private func listAllTerminalElementsWithDetails(from directory: [TerminalElement]) -> String {
        // TODO: delete comments if the method works
        //        for terminalElement in directory {
        //            print(terminalElement.print())
        //        }
        
        var output = ""
        for index in 0..<directory.count {
            if index != 0 {
                output.append(contentsOf: "\n\(directory[index].print())")
            } else {
                output.append(contentsOf: directory[index].print())
            }
        }
        
        return output
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
    
    private func ls(with arguments: [String]) -> String {
        
        switch arguments.count {
            
        // ls
        case 0:
            return listAllTerminalElements(from: currentPath)
            
        // ls -l | ls directory
        case 1:
            
            let argument = String(arguments[0])
            
            // check if the argument is an option or a directory
            switch argument.first! {
                
            // should be an option
            case "-":
                if argument == "-l" {
                    return listAllTerminalElementsWithDetails(from: currentPath)
                } else {
                    return "ls: illegal option \(argument)\nusage: ls [-l] [directory]"
                }
                
            // should be a directory
            default:
                switch argument {
                case "..", "../":
                    if currentPath == "/" {
                        return listAllTerminalElements(from: currentPath)
                    } else {
                        let parentFolderPath = getParentFolderPath(from: currentPath)
                        return listAllTerminalElements(from: parentFolderPath)
                    }
                case ".", "./":
                    return listAllTerminalElements(from: currentPath)
                case "/":
                    return listAllTerminalElements(from: "/")
                default:
                    switch argument.first! {
                    case ".":
                        let splittedArgument = argument.split(separator: "/")
                        
                        if splittedArgument.count < 2 {
                            return "ls: \(argument): no such file or directory"
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
                            return "ls: \(argument): no such file or directory"
                        }
                        
                        for index in 1..<splittedArgument.count {
                            path += "/\(splittedArgument[index])"
                        }
                        
                        if let directory = paths[path] {
                            return listAllTerminalElements(from: directory)
                        } else {
                            return "ls: \(argument): No such file or directory"
                        }
                        
                    case "/":
                        if let directory = paths[argument] {
                            return listAllTerminalElements(from: directory)
                        } else {
                            return "ls: \(argument): no such file or directory"
                        }
                    default:
                        let path = currentPath + "/" + argument
                        if let directory = paths[path] {
                            return listAllTerminalElements(from: directory)
                        } else {
                            return "ls: \(argument): no such file or directory"
                        }
                    }
                }
            }
            
        // ls -l directory
        case 2:
            let option = arguments[0]
            let directory = arguments[1]
            
            if option != "-l" {
                return "ls: illegal option \(arguments[0])\nusage: ls [-l] [directory]"
            }
            
            switch directory {
            case "..", "../":
                if currentPath == "/" {
                    return listAllTerminalElementsWithDetails(from: currentPath)
                } else {
                    let parentFolderPath = getParentFolderPath(from: currentPath)
                    return listAllTerminalElementsWithDetails(from: parentFolderPath)
                }
            case ".", "./":
                return listAllTerminalElementsWithDetails(from: currentPath)
            case "/":
                return listAllTerminalElementsWithDetails(from: "/")
            default:
                switch directory.first! {
                case ".":
                    let splittedArgument = directory.split(separator: "/")
                    
                    if splittedArgument.count < 2 {
                        return "ls: \(directory): No such file or directory"
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
                        return "ls: \(directory): No such file or directory"
                    }
                    
                    for index in 1..<splittedArgument.count {
                        path += "/\(splittedArgument[index])"
                    }
                    
                    if let directory = paths[path] {
                        return listAllTerminalElementsWithDetails(from: directory)
                    } else {
                        return "ls: \(directory): No such file or directory"
                    }
                    
                case "/":
                    if let directory = paths[directory] {
                        return listAllTerminalElementsWithDetails(from: directory)
                    } else {
                        return "ls: \(directory): No such file or directory"
                    }
                default:
                    let path = currentPath + "/" + directory
                    if let directory = paths[path] {
                        return listAllTerminalElementsWithDetails(from: directory)
                    } else {
                        return "ls: \(directory): No such file or directory"
                    }
                }
            }
            
        default:
            return "ls: too many arguments"
        }
        
    }
    
    private func cd(with arguments: [String]) -> String? {
        
        if arguments.count != 1 {
            return "cd: too many arguments"
        }
        
        let argument = String(arguments[0])
        
        switch argument {
        case "..", "../":
            if currentPath != "/" {
                currentPath = getParentFolderPath(from: currentPath)
            }
            return nil
        case ".", "./":
            return nil
        case "/":
            currentPath = "/"
            return nil
        default:
            
            var path = ""
            
            switch argument.first! {
            case ".":
                let splittedArgument = argument.split(separator: "/")
                
                if splittedArgument.count < 2 {
                    return "cd: \(argument): No such file or directory"
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
                    return "cd: \(argument): No such file or directory"
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
                return nil
            } else {
                return "cd: \(argument): No such file or directory"
            }
            
        }
        
        
    }
    
    private func touch(with arguments: [String]) -> String? {
        
        if arguments.count != 1 {
            return "touch: too many arguments"
        }
        
        let argument = String(arguments[0])
        
        var path = ""
        var newFileName = ""
        
        switch argument.first! {
        case ".":
            let splittedArgument = argument.split(separator: "/")
            
            if splittedArgument.count < 2 {
                return "touch: \(argument): no such file or directory"
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
                return "touch: \(argument): no such file or directory"
            }
            
            for index in 1..<splittedArgument.count-1 {
                path += "/\(splittedArgument[index])"
            }
            
            newFileName = String(splittedArgument.last!)
        case "/":
            let splitted = argument.split(separator: "/")
            if splitted.count < 1 {
                return "touch: \(argument): invalid name of a file\nusage: touch [name.extension]"
            }
            
            path = getParentFolderPath(from: argument)
            newFileName = String(splitted.last!)
        default:
            path = currentPath
            newFileName = argument
        }
        
        if paths[path] == nil {
            return "touch: \(argument): no such file or directory"
        }
        
        if newFileName.isValidFileName {
            var sameFileNameFound = false
            for terminalElement in paths[path]! {
                if let file = terminalElement as? File {
                    if file.name == newFileName {
                        sameFileNameFound = true
                        break
                    }
                }
            }
            if sameFileNameFound == false {
                let file = File(permissions: "f", numberOfLinks: 1, ownerName: username, ownerGroup: "root", size: 128, timeOfLastModification: Date(), name: newFileName, content: "")
                paths[path]!.append(file)
                return nil
            } else {
                return "touch: \(newFileName): file already exists"
            }
        } else {
            return "touch: \(newFileName): invalid name of a file\nusage: touch [name.extension]"
        }
    }
    
    private func mkdir(with arguments: [String]) -> String? {
        if arguments.count != 1 {
            return "mdkir: too many arguments"
        }
        
        let argument = String(arguments[0])
        var path = ""
        var newFolderName = ""
        
        switch argument.first! {
        case ".":
            let splittedArgument = argument.split(separator: "/")
            if splittedArgument.count < 2 {
                return "mkdir: \(argument): no such file or directory"
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
                return "mkdir: \(argument): no such file or directory"
            }
            
            for index in 1..<splittedArgument.count-1 {
                path += "/\(splittedArgument[index])"
            }
            
            newFolderName = String(splittedArgument.last!)
            
        // touch /text.txt
        case "/":
            let splitted = argument.split(separator: "/")
            if splitted.count < 1 {
                return "mkdir: \(argument): invalid name of a directory"
            }
            path = getParentFolderPath(from: argument)
            newFolderName = String(splitted.last!)
            
        // command argument
        default:
            path = currentPath
            newFolderName = argument
        }
        
        if paths[path] == nil {
            return "mdkir: \(argument): no such file or directory"
        }
        
        if newFolderName.isValidFolderName {
            var sameFolderNameFound = false
            for terminalElement in paths[path]! {
                if let folder = terminalElement as? Folder {
                    if folder.name == newFolderName {
                        sameFolderNameFound = true
                        break
                    }
                }
            }
            if sameFolderNameFound == false {
                let folder = Folder(permissions: "d", numberOfLinks: 1, ownerName: username, ownerGroup: "root", size: 256, timeOfLastModification: Date(), name: newFolderName)
                paths[path]!.append(folder)
                paths[path + "/" + newFolderName] = [TerminalElement]()
                return nil
            } else {
                 return "mkdir: \(newFolderName): directory already exists"
            }
        } else {
            // TODO: print in the terminal
            return "mkdir: \(newFolderName): invalid name of a directory\nusage: mkdir [name]"
        }
        
    }
    
    private func rm(with arguments: [String]) -> String? {
        switch arguments.count {
        case 1:
            let argument = String(arguments[0])
            var fileName = ""
            var path = ""
            
            switch argument.first! {
                
            case ".":
                let splittedArgument = argument.split(separator: "/")
                
                if splittedArgument.count < 2 {
                    return "rm: \(argument): no such file or directory"
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
                    return "rm: \(argument): no such file or directory"
                }
                
            case "/":
                let splitted = argument.split(separator: "/")
                if splitted.count < 1 {
                    return "rm: illegal usage\nusage: rm [-rf] [directory/file]"
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
                        return "rm: \(argument): is a directory"
                    } else {
                        return "rm: \(argument): no such file or directory"
                    }
                } else {
                    paths[path]!.remove(at: fileFoundIndex!)
                    return nil
                }
            } else {
                return "rm: \(argument): no such file or directory"
            }
        
        case 2:
            if String(arguments[0]) != "-rf" {
                return "rm: illegal usage\nusage: rm [-rf] [directory/file]"
            }
            
            let argument = String(arguments[1])
            
            var folderName = ""
            var path = ""
            
            switch argument.first! {
                
            case ".":
                let splittedArgument = argument.split(separator: "/")
                
                if splittedArgument.count < 2 {
                    return "rm -rf: \(argument): no such file or directory"
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
                    return "rm -rf: \(argument): no such file or directory"
                }
                
            case "/":
                let splitted = argument.split(separator: "/")
                if splitted.count < 1 {
                    return "rm -rf: illegal usage\nusage: rm [-rf] [directory/file]"
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
                        return "rm -rf: \(argument): is a file"
                    } else {
                        return "rm -rf: \(argument): no such file or directory"
                    }
                } else {
                    paths[path]!.remove(at: folderFoundIndex!)
                    return nil
                }
            } else {
                return "rm -rf: \(argument): no such file or directory"
            }
            
        default:
            return "rm: illegal usage\nusage: rm [-rf] [directory/file]"
        }
    }
    
    private func cat(with arguments: [String]) -> String? {
        // TODO: rewrite the string
        if arguments.count != 1 {
            return "cat: invalid usage"
        }
        
        let argument = String(arguments[0])
        var fileName = ""
        var path = ""
        
        switch argument.first! {
            
        case ".":
            let splittedArgument = argument.split(separator: "/")
            
            if splittedArgument.count < 2 {
                return "cat: \(argument): no such file or directory"
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
                return "cat: \(argument): no such file or directory"
            }
            
        case "/":
            let splitted = argument.split(separator: "/")
            if splitted.count < 1 {
                return "cat: \(argument): invalid name of a file"
            }
            
            path = getParentFolderPath(from: argument)
            fileName = String(splitted.last!)
            
        default:
            fileName = argument
            path = currentPath
        }
        
        if let directory = paths[path] {

            for terminalElement in directory {
                if let file = terminalElement as? File {
                    if file.name == fileName {
                        return file.content
                    }
                }
            }
            
            return "cat: \(argument): no such file or directory"
            
        } else {
            return "cat: \(argument): no such file or directory"
        }
        
    }
    
    private func swift(with arguments: [String]) -> String? {
        if arguments.count != 1 {
            return "swift: too many arguments"
        }
        
        let argument = String(arguments[0])
        var fileName = ""
        var path = ""
        
        switch argument.first! {
            
        case ".":
            let splittedArgument = argument.split(separator: "/")
            
            if splittedArgument.count < 2 {
                return "swift: \(argument): no such file or directory"
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
                return "swift: \(argument): no such file or directory"
            }
            
        case "/":
            let splitted = argument.split(separator: "/")
            if splitted.count < 1 {
                return "swift: \(argument): invalid name of a file"
            }
            
            path = getParentFolderPath(from: argument)
            fileName = String(splitted.last!)
            
        default:
            fileName = argument
            path = currentPath
        }
        
        if path == "/Users/Tuan", fileName == "helloWorld.swift" {
            return "Hello, world!"
        } else {
            return "swift: \(argument): could not build"
        }
        
    }
    
    // TODO
    private func man(with arguments: [String]) -> String {
        return ""
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
