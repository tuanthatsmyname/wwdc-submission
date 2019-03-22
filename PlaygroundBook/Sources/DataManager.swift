//
//  DataManager.swift
//  Book_Sources
//
//  Created by Tuan Tu Do on 21/03/2019.
//

import Foundation
import PlaygroundSupport

public class DataManager {
    public static func saveTerminalSettings(of settings: TerminalSettings) {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(settings) {
            PlaygroundKeyValueStore.current["terminalSettings"] = .data(data)
        }
        
    }
    
    public static func loadTerminalSettings() -> TerminalSettings? {
        let decoder = JSONDecoder()
    
        var settings: TerminalSettings? = nil
        if let value = PlaygroundKeyValueStore.current["terminalSettings"], case .data(let data) = value {
            guard let terminalSettings = try? decoder.decode(TerminalSettings.self, from: data) else {
                return nil
            }
            settings = terminalSettings
        }
    
        return settings
    }
    
    public static func saveTerminalHistory(from history: NSMutableAttributedString) {
        PlaygroundKeyValueStore.current["terminalHistory"] = .data(try! NSKeyedArchiver.archivedData(withRootObject: history, requiringSecureCoding: true))
    }
    
    public static func loadTerminalHistory() -> NSMutableAttributedString? {
        var terminalHistory: NSMutableAttributedString? = nil
        if let value = PlaygroundKeyValueStore.current["terminalHistory"], case .data(let data) = value {
            guard let history = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? NSMutableAttributedString else {
                return nil
            }
            terminalHistory = history
        }
        return terminalHistory
    }
    
}
