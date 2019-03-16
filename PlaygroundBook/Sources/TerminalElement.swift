//
//  TerminalElement.swift
//  Book_Sources
//
//  Created by Tuan Tu Do on 16/03/2019.
//

import Foundation

class TerminalElement {
    
    var permissions: String
    var numberOfLinks: Int
    var ownerName: String
    var ownerGroup: String
    var size: Int
    var timeOfLastModification: Date
    var name: String
    
    init(permissions: String, numberOfLinks: Int, ownerName: String, ownerGroup: String, size: Int, timeOfLastModification: Date, name: String) {
        self.permissions = permissions
        self.numberOfLinks = numberOfLinks
        self.ownerName = ownerName
        self.ownerGroup = ownerGroup
        self.size = size
        self.timeOfLastModification = timeOfLastModification
        self.name = name
    }
    
}
