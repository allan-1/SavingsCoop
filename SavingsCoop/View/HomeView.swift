//
//  HomeView.swift
//  SavingsCoop
//
//  Created by Allan Maina on 16/02/2026.
//

import SwiftUI

// MARK: - Main Dashboard
struct HomeView: View {
    @StateObject private var viewModel = SavingsViewModel()
    @State private var showingAddGoal = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    
                    HStack {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 45, height: 45)
                            .foregroundColor(Color(hex: "1e3b20"))
                        VStack(alignment: .leading) {
                            Text("Hello There!")
                                .font(.title3).bold()
                            Text("It's a good day to save")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.horizontal)
                    
                    Text("My Goals")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    if viewModel.goals.isEmpty {
                        Text("No goals yet. Start saving today!")
                            .foregroundColor(.gray)
                            .padding()
                    } else {
                        ForEach(viewModel.goals) { goal in
                            NavigationLink(destination: GoalDetailView(viewModel: viewModel, goal: goal)) {
                                GoalCard(goal: goal)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.top)
            }
            .navigationBarHidden(true)
            .overlay(alignment: .bottomTrailing) {
                // Floating Action Button
                Button { showingAddGoal = true } label: {
                    Image(systemName: "plus")
                        .font(.title.bold())
                        .foregroundColor(.white)
                        .padding()
                        .background(Color(hex: "8bc34a"))
                        .clipShape(Circle())
                        .shadow(radius: 4)
                }
                .padding()
            }
            .sheet(isPresented: $showingAddGoal) {
                AddGoalView(viewModel: viewModel)
            }
        }
    }
}





// MARK: - Color Extension Helper
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
