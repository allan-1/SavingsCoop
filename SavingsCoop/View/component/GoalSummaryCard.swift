struct GoalSummaryCard: View {
    let goal: SavingsGoal
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(goal.name).font(.headline).foregroundColor(.black)
            HStack {
                Text("\(goal.currentAmount, format: .currency(code: "KES"))").bold().foregroundColor(.appGreen)
                Spacer()
                Text("\(Int(goal.progress * 100))%").font(.caption).foregroundColor(.gray)
            }
            ProgressView(value: goal.progress).accentColor(.appGreen)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.05), radius: 3, x: 0, y: 3)
    }
}