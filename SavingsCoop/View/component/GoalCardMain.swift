struct GoalCardMain: View {
    let goal: SavingsGoal
    let onDeposit: () -> Void
    let onWithdraw: () -> Void
    
    var body: some View {
        VStack(spacing: 15) {
            HStack {
                Text(goal.name).foregroundColor(.white).font(.headline)
                Spacer()
                Image(systemName: "ellipsis.circle").foregroundColor(.white)
            }
            
            HStack {
                Text("\(goal.currentAmount, format: .currency(code: "KES"))")
                    .font(.system(size: 30, weight: .bold)).foregroundColor(.white)
                Image(systemName: "eye.slash").foregroundColor(.white.opacity(0.7))
            }
            
            // Progress
            VStack(alignment: .trailing) {
                GeometryReader { geo in
                    ZStack(alignment: .leading) {
                        Capsule().fill(Color.white.opacity(0.3)).frame(height: 6)
                        Capsule().fill(Color.appGreen).frame(width: geo.size.width * goal.progress, height: 6)
                    }
                }
                .frame(height: 6)
                Text("\(Int(goal.progress * 100))%").font(.caption).foregroundColor(.appGreen)
            }
            
            HStack {
                Text("Target Amount (KES)").font(.caption).foregroundColor(.white)
                Text("\(goal.targetAmount, format: .currency(code: "KES"))").font(.caption).bold().foregroundColor(.white)
                Spacer()
            }
            
            HStack(spacing: 15) {
                Button(action: onDeposit) {
                    Label("Deposit", systemImage: "arrow.up")
                        .font(.headline).foregroundColor(.white)
                        .frame(maxWidth: .infinity).padding(10)
                        .background(Color.appGreen).cornerRadius(8)
                }
                
                Button(action: onWithdraw) {
                    Label("Withdraw", systemImage: "arrow.down")
                        .font(.headline).foregroundColor(.white)
                        .frame(maxWidth: .infinity).padding(10)
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.white, lineWidth: 1))
                }
            }
        }
        .padding()
        .background(
            LinearGradient(colors: [Color.darkHeader, Color(hex: "1e3b20")], startPoint: .top, endPoint: .bottom)
        )
        .cornerRadius(15)
        .padding(.horizontal)
    }
}