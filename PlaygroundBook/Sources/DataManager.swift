//
//  DataManager.swift
//  Book_Sources
//
//  Created by Tuan Tu Do on 21/03/2019.
//

import Foundation

public class DataManager {
    public static func saveTerminalSettings(of settings: TerminalSettings) {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(settings) {
            UserDefaults.standard.setValue(data, forKey: "terminalSettings")
        }
    }
    
    public static func loadTerminalSettings() -> TerminalSettings? {
        let decoder = JSONDecoder()
        
        guard let data = UserDefaults.standard.object(forKey: "terminalSettings") as? Data else {
            return nil
        }

        guard let terminalSettings = try? decoder.decode(TerminalSettings.self, from: data) else {
            return nil
        }
    
        return terminalSettings
    }
    
    
}
