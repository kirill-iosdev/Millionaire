//
//  RecordsCaretaker.swift
//  Millionaire
//
//  Created by Kirill on 21.08.2022.
//

import Foundation

class RecordsCaretaker {
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    private let key = "records"
    
    func save(records: [GameSession]) {
        do {
            let data = try encoder.encode(records)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print(error)
        }
    }
    
    func getSavedRecords() -> [GameSession] {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return []
        }
        
        do {
            return try decoder.decode([GameSession].self, from: data)
        } catch {
            print(error)
            return []
        }
    }
    
}
