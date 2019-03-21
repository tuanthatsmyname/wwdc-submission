//
//  TerminalSettings.swift
//  Book_Sources
//
//  Created by Tuan Tu Do on 17/03/2019.
//

import Foundation
import UIKit

public enum Fonts: String {
    case menlo = "Menlo"
    case courier = "Courier"
}

public struct Color: Codable {
    public var red: CGFloat = 0.0
    public var green: CGFloat = 0.0
    public var blue: CGFloat = 0.0
    public var alpha: CGFloat = 0.0
    public var uiColor: UIColor {
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    public func show() {
        print(red)
        print(green)
        print(blue)
        print(alpha)
    }
    
    public init(uiColor: UIColor) {
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
    }
}

public struct TerminalSettings {
    public var textColor: UIColor
    public var textSize: Int
    public var backgroundColor: UIColor
    public var username: String
    public var fontName: String
    
    public init(textColor: UIColor, textSize: Int, backgroundColor: UIColor, username: String, fontName: String) {
        self.textColor = textColor
        self.textSize = textSize
        self.backgroundColor = backgroundColor
        self.username = username
        self.fontName = fontName
    }
    
}

extension TerminalSettings: Codable {
    
    enum CodingKeys: String, CodingKey {
        case textColor
        case textSize
        case backgroundColor
        case username
        case fontName
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        textColor = try container.decode(Color.self, forKey: .textColor).uiColor
        textSize = try container.decode(Int.self, forKey: .textSize)
        backgroundColor = try container.decode(Color.self, forKey: .backgroundColor).uiColor
        username = try container.decode(String.self, forKey: .username)
        fontName = try container.decode(String.self, forKey: .fontName)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(Color(uiColor: textColor), forKey: .textColor)
        try container.encode(textSize, forKey: .textSize)
        try container.encode(Color(uiColor: backgroundColor), forKey: .backgroundColor)
        try container.encode(username, forKey: .username)
        try container.encode(fontName, forKey: .fontName)
    }
    
}

