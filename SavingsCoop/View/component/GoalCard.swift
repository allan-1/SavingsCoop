//
//  GoalCard.swift
//  SavingsCoop
//
//  Created by Allan Maina on 16/02/2026.
//

import SwiftUI

struct GoalCard: View {
    let goal: SavingsGoal
    
    var body: some View {
        ZStack {
            // Background Gradient matching Screenshot 3
            LinearGradient(colors: [Color(hex: "345e37"), Color(hex: "1e3b20")], startPoint: .topLeading, endPoint: .bottomTrailing)
            
            VStack(alignment: .leading, spacing: 15) {
                HStack {
                    VStack(alignment: .leading) {
                        Text(goal.name)
                            .font(.headline)
                            .foregroundColor(.white.opacity(0.8))
                        
                        Text("\(goal.currentAmount, format: .currency(code: "KES"))")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.white)
                    }
                    Spacer()
                    // Menu dots or Icon
                    Image(systemName: "ellipsis.circle.fill")
                        .foregroundColor(.white)
                }
                
                // Progress Bar
                VStack(alignment: .trailing, spacing: 5) {
                    GeometryReader { geo in
                        ZStack(alignment: .leading) {
                            Capsule().fill(Color.white.opacity(0.3))
                                .frame(height: 8)
                            Capsule().fill(Color(hex: "8bc34a")) // Bright green accent
                                .frame(width: geo.size.width * goal.progress, height: 8)
                        }
                    }
                    .frame(height: 8)
                    
                    Text("\(Int(goal.progress * 100))%")
                        .font(.caption)
                        .foregroundColor(Color(hex: "8bc34a"))
                }
                
                HStack {
                    Text("Target: \(goal.targetAmount, format: .currency(code: "KES"))")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.7))
                    Spacer()
                }
            }
            .padding(20)
        }
        .cornerRadius(20)
        .shadow(radius: 5)
    }
}
