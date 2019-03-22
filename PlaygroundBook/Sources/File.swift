//
//  File.swift
//  Book_Sources
//
//  Created by Tuan Tu Do on 16/03/2019.
//

import Foundation

public class File: TerminalElement {
    
    public var content: String
    
    public init(permissions: String, numberOfLinks: Int, ownerName: String, ownerGroup: String, size: Int, timeOfLastModification: Date, name: String, content: String) {
        self.content = content
        super.init(permissions: permissions, numberOfLinks: numberOfLinks, ownerName: ownerName, ownerGroup: ownerGroup, size: size, timeOfLastModification: timeOfLastModification, name: name)
    }
}
