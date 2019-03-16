//
//  Terminal.swift
//  Book_Sources
//
//  Created by Tuan Tu Do on 16/03/2019.
//

import Foundation

class Terminal {
    var rootFolder: Folder
//    var levelOfNesting: [Folder]
    var currentFolder: Folder

    init(rootFolder: Folder, currentFolder: Folder) {
        self.rootFolder = rootFolder
//        self.levelOfNesting = [rootFolder]
        self.currentFolder = currentFolder
    }
    
    private func setupTerminal() {
        
    }
}
