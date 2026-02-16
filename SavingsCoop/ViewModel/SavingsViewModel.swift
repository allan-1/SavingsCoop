//
//  SavingsViewModel.swift
//  SavingsCoop
//
//  Created by Allan Maina on 16/02/2026.
//


import SwiftUI
internal import Combine

class SavingsViewModel: ObservableObject {
    
    @Published var goals: [SavingsGoal] = []
    
    init() {
        self.goals = DataManager.shared.load()
    }
    
    // MARK: - User Intents
    func createGoal(name: String, category: String, target: Double, date: Date?) {
        let newGoal = SavingsGoal(name: name, category: category, targetAmount: target, targetDate: date)
        goals.append(newGoal)
        saveData()
    }
    
    func addTransaction(goalID: UUID, amount: Double, type: Transaction.TransactionType) {
        if let index = goals.firstIndex(where: { $0.id == goalID }) {
            let transaction = Transaction(amount: amount, date: Date(), type: type)
            goals[index].transactions.append(transaction)
            saveData()
        }
    }
    
    func deleteGoal(at offsets: IndexSet) {
        goals.remove(atOffsets: offsets)
        saveData()
    }
    
    private func saveData() {
        DataManager.shared.save(goals: goals)
    }
}
