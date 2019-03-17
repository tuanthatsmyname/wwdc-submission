//
//  Terminal.swift
//  Book_Sources
//
//  Created by Tuan Tu Do on 16/03/2019.
//

import Foundation

class Terminal {
    
    var rootFolder: Folder
    var currentFolder: Folder
    var settings: TerminalSettings

    init(rootFolder: Folder, settings: TerminalSettings) {
        self.rootFolder = rootFolder
        self.currentFolder = rootFolder
        self.settings = settings
    }
    
    private func setupTerminal() {
        
    }
    
    func cd(parameter: String) {
        
    }
    
    func ls(parameter: String) {
        
    }
}

//class NetworkManager {
//
//    static let shared = NetworkManager()
//
//    let timeStamp: String
//
//    private init() {
//
//        let formatter = DateFormatter()
//        formatter.timeZone = TimeZone.current
//        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        self.timeStamp = formatter.string(from: Date())
//    }
//
//}
//
//let timestamp = NetworkManager.shared.timeStamp
