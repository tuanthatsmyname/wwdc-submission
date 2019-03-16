//
//  File.swift
//  Book_Sources
//
//  Created by Tuan Tu Do on 16/03/2019.
//

import Foundation

class File: TerminalElement {
    
    var type: String
    var content: String
    
    init(permissions: String, numberOfLinks: Int, ownerName: String, ownerGroup: String, size: Int, timeOfLastModification: Date, name: String, type: String, content: String) {
        self.type = type
        self.content = content
        super.init(permissions: permissions, numberOfLinks: numberOfLinks, ownerName: ownerName, ownerGroup: ownerGroup, size: size, timeOfLastModification: timeOfLastModification, name: name)
    }
}
