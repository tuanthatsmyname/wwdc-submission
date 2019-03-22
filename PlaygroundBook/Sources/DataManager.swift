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
    
}
