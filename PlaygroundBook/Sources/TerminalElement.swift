//
//  TerminalElement.swift
//  Book_Sources
//
//  Created by Tuan Tu Do on 16/03/2019.
//

import Foundation

public class TerminalElement {
    
    public var permissions: String
    public var numberOfLinks: Int
    public var ownerName: String
    public var ownerGroup: String
    public var size: Int
    public var timeOfLastModification: Date
    public var name: String
    
    public init(permissions: String, numberOfLinks: Int, ownerName: String, ownerGroup: String, size: Int, timeOfLastModification: Date, name: String) {
        self.permissions = permissions
        self.numberOfLinks = numberOfLinks
        self.ownerName = ownerName
        self.ownerGroup = ownerGroup
        self.size = size
        self.timeOfLastModification = timeOfLastModification
        self.name = name
    }
    
    public func print() -> String {
        return "\(permissions) \(numberOfLinks) \(ownerName) \(ownerGroup) \(size) \(timeOfLastModification) \(name)"
    }
    
}
