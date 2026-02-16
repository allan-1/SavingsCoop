struct TransactionRow: View {
    let transaction: Transaction
    var body: some View {
        HStack {
            Circle()
                .fill(transaction.type == .deposit ? Color.appGreen.opacity(0.2) : Color.red.opacity(0.1))
                .frame(width: 40, height: 40)
                .overlay(Image(systemName: transaction.type == .deposit ? "plus.square.fill.on.square.fill" : "wallet.pass.fill")
                    .foregroundColor(transaction.type == .deposit ? .appGreen : .red))
            
            VStack(alignment: .leading) {
                Text(transaction.type == .deposit ? "Deposit" : "Withdrawal")
                    .font(.body).bold()
                Text("\(transaction.method.rawValue) \(transaction.reference)")
                    .font(.caption).foregroundColor(.gray)
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text("KES \(transaction.amount, specifier: "%.2f")")
                    .bold()
                    .foregroundColor(transaction.type == .deposit ? .black : .red)
                Text(transaction.date, style: .date)
                    .font(.caption).foregroundColor(.gray)
            }
        }
        .padding()
    }
}