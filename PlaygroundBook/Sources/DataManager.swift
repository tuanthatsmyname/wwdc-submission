//
//  DataManager.swift
//  Book_Sources
//
//  Created by Tuan Tu Do on 21/03/2019.
//

import Foundation
import PlaygroundSupport

public class DataManager {
    public static func saveTerminalSettings(of settings: TerminalSettings) {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(settings) {
            PlaygroundKeyValueStore.current["terminalSettings"] = .data(data)
        }
        
    }
    
    public static func loadTerminalSettings() -> TerminalSettings? {
        let decoder = JSONDecoder()
    
        var settings: TerminalSettings? = nil
        if let value = PlaygroundKeyValueStore.current["terminalSettings"], case .data(let data) = value {
            guard let terminalSettings = try? decoder.decode(TerminalSettings.self, from: data) else {
                return nil
            }
            settings = terminalSettings
        }
    
        return settings
    }
    
    public static func saveTerminalHistory(from history: NSMutableAttributedString) {
        PlaygroundKeyValueStore.current["terminalHistory"] = .data(try! NSKeyedArchiver.archivedData(withRootObject: history, requiringSecureCoding: true))
    }
    
    public static func loadTerminalHistory() -> NSMutableAttributedString? {
        var terminalHistory: NSMutableAttributedString? = nil
        if let value = PlaygroundKeyValueStore.current["terminalHistory"], case .data(let data) = value {
            guard let history = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? NSMutableAttributedString else {
                return nil
            }
            terminalHistory = history
        }
        return terminalHistory
    }
    
    public static func loadHierarchy(with username: String) -> [String : [TerminalElement]] {
        let systemFolder = Folder(permissions: "d", numberOfLinks: 1, ownerName: "root", ownerGroup: "root", size: 256, timeOfLastModification: Date(), name: "System")
        let usersFolder = Folder(permissions: "d", numberOfLinks: 1, ownerName: "root", ownerGroup: "root", size: 256, timeOfLastModification: Date(), name: "Users")
        let volumesFolder = Folder(permissions: "d", numberOfLinks: 1, ownerName: "root", ownerGroup: "root", size: 256, timeOfLastModification: Date(), name: "Volumes")
        let macintoshFolder = Folder(permissions: "d", numberOfLinks: 1, ownerName: "root", ownerGroup: "root", size: 2048, timeOfLastModification: Date(), name: "MacintoshHD")
        let tuanFolder = Folder(permissions: "d", numberOfLinks: 1, ownerName: "root", ownerGroup: "root", size: 256, timeOfLastModification: Date(), name: username)
        let guestFolder = Folder(permissions: "d", numberOfLinks: 1, ownerName: "root", ownerGroup: "root", size: 256, timeOfLastModification: Date(), name: "Guest")
        let libraryFolder = Folder(permissions: "d", numberOfLinks: 1, ownerName: "root", ownerGroup: "root", size: 256, timeOfLastModification: Date(), name: "Library")
        let fontsFolder = Folder(permissions: "d", numberOfLinks: 1, ownerName: "root", ownerGroup: "root", size: 512, timeOfLastModification: Date(), name: "Fonts")
        let screenSaversFolder = Folder(permissions: "d", numberOfLinks: 1, ownerName: "root", ownerGroup: "root", size: 1024, timeOfLastModification: Date(), name: "ScreenSavers")
        let desktop = Folder(permissions: "d", numberOfLinks: 1, ownerName: "root", ownerGroup: "root", size: 256, timeOfLastModification: Date(), name: "Desktop")
        let documents = Folder(permissions: "d", numberOfLinks: 1, ownerName: "root", ownerGroup: "root", size: 256, timeOfLastModification: Date(), name: "Documents")
        let developer = Folder(permissions: "d", numberOfLinks: 1, ownerName: "root", ownerGroup: "root", size: 256, timeOfLastModification: Date(), name: "Developer")
        let wwdcRoadmap = File(permissions: "f", numberOfLinks: 1, ownerName: username, ownerGroup: "staff", size: 256, timeOfLastModification: Date(), name: "wwdcRoadmap.txt", content: "1. Learn to code in swift\n2. Have a good idea\n3. Code\n4. Survive one sleepless week\n5. Become a 2019 WWDC Scholar")
        let welcomeFile = File(permissions: "f", numberOfLinks: 1, ownerName: username, ownerGroup: "staff", size: 256, timeOfLastModification: Date(), name: "welcome.txt", content: "Welcome to my WWDC Playground!")
        let wwdcFolder = Folder(permissions: "d", numberOfLinks: 1, ownerName: username, ownerGroup: "staff", size: 256, timeOfLastModification: Date(), name: "wwdc")
        let sharedFolder = Folder(permissions: "d", numberOfLinks: 1, ownerName: "root", ownerGroup: "root", size: 256, timeOfLastModification: Date(), name: "shared")
        let motivatingFile = File(permissions: "f", numberOfLinks: 1, ownerName: "guest", ownerGroup: "staff", size: 8, timeOfLastModification: Date(), name: "wwdc.txt", content: "I REALLY WANT TO GO TO WWDC 2019!!!")
        let helloWorldSwiftFile = File(permissions: "f", numberOfLinks: 1, ownerName: username, ownerGroup: "staff", size: 16, timeOfLastModification: Date(), name: "helloWorld.swift", content: "import Foundation\nfunc greet() {\n\tprint(\"Hello, world!\"\n}\ngreet())")
        let screenSaver1 = File(permissions: "f", numberOfLinks: 1, ownerName: "root", ownerGroup: "root", size: 32, timeOfLastModification: Date(), name: "screenSaver1.jpg", content: "")
        let screenSaver2 = File(permissions: "f", numberOfLinks: 1, ownerName: "root", ownerGroup: "root", size: 32, timeOfLastModification: Date(), name: "screenSaver2.jpg", content: "")
        let screenSaver3 = File(permissions: "f", numberOfLinks: 1, ownerName: "root", ownerGroup: "root", size: 32, timeOfLastModification: Date(), name: "screenSaver3.jpg", content: "")
        let font1 = File(permissions: "f", numberOfLinks: 1, ownerName: "root", ownerGroup: "root", size: 64, timeOfLastModification: Date(), name: "font1.ttc", content: "")
        let font2 = File(permissions: "f", numberOfLinks: 1, ownerName: "root", ownerGroup: "root", size: 64, timeOfLastModification: Date(), name: "font2.ttc", content: "")
        let font3 = File(permissions: "f", numberOfLinks: 1, ownerName: "root", ownerGroup: "root", size: 64, timeOfLastModification: Date(), name: "font3.ttc", content: "")
        let surpriseFile = File(permissions: "f", numberOfLinks: 1, ownerName: "root", ownerGroup: "root", size: 1024, timeOfLastModification: Date(), name: "messageWithLove.txt", content: "Dear person, who is reading this file right now. I would like to wish you a very nice day. Don't worry about things that much. The most important thing is that you are still alive and breathing air given by the best planet in the Galaxy. Be nice to people and be happy.\n With love,\n\n\nTuan")
        let workFolder = Folder(permissions: "d", numberOfLinks: 1, ownerName: username, ownerGroup: "staff", size: 128, timeOfLastModification: Date(), name: "Work")
        let schoolFolder = Folder(permissions: "d", numberOfLinks: 1, ownerName: username, ownerGroup: "staff", size: 128, timeOfLastModification: Date(), name: "School")
        let swiftFile = File(permissions: "f", numberOfLinks: 1, ownerName: username, ownerGroup: "staff", size: 16, timeOfLastModification: Date(), name: "awesomeApp.swift", content: "import Foundation\nfunc greet() {\n\tprint(\"Hello, world!\"\n}\ngreet())")
        
        var paths = [String : [TerminalElement]]()
        paths["/"] = [systemFolder, usersFolder, volumesFolder]
            paths["/System"] = [libraryFolder]
                paths["/System/Library"] = [screenSaversFolder, fontsFolder]
                    paths["/System/Library/ScreenSavers"] = [screenSaver1, screenSaver2, screenSaver3]
                    paths["/System/Library/Fonts"] = [font1, font2, font3]
            paths["/Users"] = [tuanFolder, guestFolder]
                paths["/Users/\(username)"] = [desktop, developer, documents, helloWorldSwiftFile]
                    paths["/Users/\(username)/Desktop"] = [wwdcFolder, welcomeFile]
                        paths["/Users/\(username)/Desktop/wwdc"] = [wwdcRoadmap]
                    paths["/Users/\(username)/Developer"] = [swiftFile]
                    paths["/Users/\(username)/Documents"] = [workFolder, schoolFolder]
                paths["/Users/Guest"] = [sharedFolder]
                    paths["/Users/Guest/shared"] = [motivatingFile]
        paths["/Volumes"] = [macintoshFolder]
            paths["/Volumes/MacintoshHD"] = [surpriseFile]
        
        return paths
    }
    
}
