//
//  Folder.swift
//  Book_Sources
//
//  Created by Tuan Tu Do on 16/03/2019.
//

import Foundation

public class Folder: TerminalElement {
    public var parentFolderPath: String
    
    public init(permissions: String, numberOfLinks: Int, ownerName: String, ownerGroup: String, size: Int, timeOfLastModification: Date, name: String, parentFolderPath: String) {
        self.parentFolderPath = parentFolderPath
        super.init(permissions: permissions, numberOfLinks: numberOfLinks, ownerName: ownerName, ownerGroup: ownerGroup, size: size, timeOfLastModification: timeOfLastModification, name: name)
    }
}
