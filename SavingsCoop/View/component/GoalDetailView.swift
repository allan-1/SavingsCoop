//
//  GoalDetailView.swift
//  SavingsCoop
//
//  Created by Allan Maina on 16/02/2026.
//
import SwiftUI

struct GoalDetailView: View {
    @ObservedObject var viewModel: SavingsViewModel
    let goal: SavingsGoal
    @State private var showingDeposit = false
    @State private var showingWithdraw = false // Added to match Screenshot 3
    @State private var amountString = ""
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                GoalCard(goal: goal)
                    .padding()
                
                // Action Buttons (Deposit / Withdraw)
                HStack(spacing: 20) {
                    Button(action: { showingDeposit = true }) {
                        Label("Deposit", systemImage: "arrow.up")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(hex: "8bc34a"))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    
                    Button(action: { showingWithdraw = true }) {
                        Label("Withdraw", systemImage: "arrow.down")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.gray.opacity(0.1)) // Dark theme background
                            .foregroundColor(.primary)
                            .cornerRadius(10)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.white, lineWidth: 1))
                    }
                }
                .padding(.horizontal)
                
                // Transaction History List (Screenshot 3 bottom)
                VStack(alignment: .leading) {
                    Text("Transaction History")
                        .font(.headline)
                        .padding(.bottom, 5)
                    
                    ForEach(goal.transactions.reversed()) { transaction in
                        HStack {
                            Circle()
                                .fill(transaction.type == .deposit ? Color.green.opacity(0.2) : Color.red.opacity(0.2))
                                .frame(width: 40, height: 40)
                                .overlay(
                                    Image(systemName: transaction.type == .deposit ? "plus" : "minus")
                                        .foregroundColor(transaction.type == .deposit ? .green : .red)
                                )
                            
                            VStack(alignment: .leading) {
                                Text(transaction.type == .deposit ? "Deposit" : "Withdrawal")
                                    .font(.subheadline).bold()
                                Text(transaction.date, style: .date)
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            
                            Spacer()
                            
                            Text("\(transaction.type == .deposit ? "+" : "-") \(transaction.amount, format: .currency(code: "KES"))")
                                .bold()
                                .foregroundColor(transaction.type == .deposit ? .primary : .red)
                        }
                        .padding(.vertical, 8)
                        Divider()
                    }
                }
                .padding()
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(20)
                .padding(.horizontal)
            }
        }
        .navigationTitle(goal.name)
        // Alert for Deposit
        .alert("Add Deposit", isPresented: $showingDeposit) {
            TextField("Amount", text: $amountString).keyboardType(.decimalPad)
            Button("Cancel", role: .cancel) { amountString = "" }
            Button("Confirm") {
                if let amount = Double(amountString) {
                    viewModel.addTransaction(goalID: goal.id, amount: amount, type: .deposit)
                    amountString = ""
                }
            }
        } message: {
            Text("Enter amount to save.")
        }
        // Success Alert Logic
        .alert("Goal Reached! 🎉", isPresented: .constant(goal.isCompleted && !goal.transactions.isEmpty)) {
            Button("Awesome!") {}
        }
    }
}
