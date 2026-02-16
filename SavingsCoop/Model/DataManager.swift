//
//  DataManager.swift
//  SavingsCoop
//
//  Created by Allan Maina on 16/02/2026.
//
import Foundation

// MARK: - Data Persistence Service
class DataManager {
    static let shared = DataManager()
    private let fileName = "savings_data.json"
    
    private var fileURL: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent(fileName)
    }
    
    func save(goals: [SavingsGoal]) {
        do {
            let data = try JSONEncoder().encode(goals)
            try data.write(to: fileURL)
        } catch {
            print("Failed to save: \(error.localizedDescription)")
        }
    }
    
    func load() -> [SavingsGoal] {
        do {
            let data = try Data(contentsOf: fileURL)
            return try JSONDecoder().decode([SavingsGoal].self, from: data)
        } catch {
            return [] // Returns empty if no file exists yet
        }
    }
}
