//
//  Folder.swift
//  Book_Sources
//
//  Created by Tuan Tu Do on 16/03/2019.
//

import Foundation

class Folder: TerminalElement {
    
    var elements: [String : TerminalElement]
    unowned var parentFolder: Folder
    
    init(permissions: String, numberOfLinks: Int, ownerName: String, ownerGroup: String, size: Int, timeOfLastModification: Date, name: String, elements: [String : TerminalElement], parentFolder: Folder) {
        self.elements = elements
        self.parentFolder = parentFolder
        super.init(permissions: permissions, numberOfLinks: numberOfLinks, ownerName: ownerName, ownerGroup: ownerGroup, size: size, timeOfLastModification: timeOfLastModification, name: name)
    }
    
}
