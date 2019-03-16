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
}
