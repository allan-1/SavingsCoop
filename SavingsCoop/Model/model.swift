//
//  model.swift
//  SavingsCoop
//
//  Created by Allan Maina on 16/02/2026.
//

import Foundation

// MARK: - Models
struct Transaction: Identifiable, Codable {
    var id = UUID()
    var amount: Double
    var date: Date
    var type: TransactionType
    
    enum TransactionType: String, Codable {
        case deposit
        case withdrawal
    }
}

struct SavingsGoal: Identifiable, Codable {
    var id = UUID()
    var name: String
    var category: String
    var targetAmount: Double
    var targetDate: Date?
    var transactions: [Transaction] = []
    
    // MARK: - Computed Properties for Logic
    var currentAmount: Double {
        transactions.reduce(0) { total, transaction in
            transaction.type == .deposit ? total + transaction.amount : total - transaction.amount
        }
    }
    
    var progress: Double {
        guard targetAmount > 0 else { return 0 }
        return min(currentAmount / targetAmount, 1.0)
    }
    
    var isCompleted: Bool {
        return currentAmount >= targetAmount
    }
}

