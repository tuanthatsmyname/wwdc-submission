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
    
    public init(uiColor: UIColor) {
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
    }
}

public struct TerminalSettings {
    public var textColor: UIColor
    public var textSize: CGFloat
    public var backgroundColor: UIColor
    public var username: String
    public var textFont: String
    public var currentPath: String
    
    public var boldAttributes: [NSAttributedString.Key : Any] {
        let lineSpacing = NSMutableParagraphStyle()
        lineSpacing.lineSpacing = 5
        return [.font : UIFont(name: "\(textFont)-Bold", size: textSize)!, .foregroundColor : textColor, .paragraphStyle : lineSpacing]
    }
    
    public var normalAttributes: [NSAttributedString.Key : Any] {
        let lineSpacing = NSMutableParagraphStyle()
        lineSpacing.lineSpacing = 5
        return [.font : UIFont(name: "\(textFont)", size: textSize)!, .foregroundColor : textColor, .paragraphStyle : lineSpacing]
    }
    
    public var prompt: NSMutableAttributedString {
        return NSMutableAttributedString(string: "\(username)-mac: \(currentPath) $ ", attributes: boldAttributes)
    }
    
    public init(textColor: UIColor, textSize: CGFloat, backgroundColor: UIColor, username: String, textFont: Fonts) {
        self.textColor = textColor
        self.textSize = textSize
        self.backgroundColor = backgroundColor
        self.username = username
        self.textFont = textFont.rawValue
        self.currentPath = "/Users/\(username)"
    }
    
    public init() {
        self.textColor = UIColor(displayP3Red: 40/255, green: 254/255, blue: 20/255, alpha: 1.0)
        self.textSize = 16.0
        self.backgroundColor = .black
        self.username = "tuan"
        self.textFont = Fonts.menlo.rawValue
        self.currentPath = "/Users/tuan"
    }
    
}

extension TerminalSettings: Codable {
    
    enum CodingKeys: String, CodingKey {
        case textColor
        case textSize
        case backgroundColor
        case username
        case textFont
        case currentPath
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        textColor = try container.decode(Color.self, forKey: .textColor).uiColor
        textSize = try container.decode(CGFloat.self, forKey: .textSize)
        backgroundColor = try container.decode(Color.self, forKey: .backgroundColor).uiColor
        username = try container.decode(String.self, forKey: .username)
        textFont = try container.decode(String.self, forKey: .textFont)
        currentPath = try container.decode(String.self, forKey: .currentPath)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(Color(uiColor: textColor), forKey: .textColor)
        try container.encode(textSize, forKey: .textSize)
        try container.encode(Color(uiColor: backgroundColor), forKey: .backgroundColor)
        try container.encode(username, forKey: .username)
        try container.encode(textFont, forKey: .textFont)
        try container.encode(currentPath, forKey: .currentPath)
    }
    
}

