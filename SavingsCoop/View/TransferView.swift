//
//  TransferView.swift
//  SavingsCoop
//
//  Created by Allan Maina on 16/02/2026.
//


struct TransferView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: SavingsViewModel
    let goal: SavingsGoal
    let mode: TransactionType
    
    @State private var paymentMethod: PaymentMethod = .coop
    @State private var amount = ""
    @State private var creditAccount = "Salary Account"
    @State private var phoneNumber = ""
    @State private var showSuccess = false
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                // Header
                HStack {
                    Button(action: { dismiss() }) { Image(systemName: "arrow.left").foregroundColor(.white) }
                    Spacer()
                    Text(mode == .deposit ? "Deposit" : "Withdraw").foregroundColor(.white).font(.headline)
                    Spacer()
                    Button(action: { dismiss() }) { Image(systemName: "xmark").foregroundColor(.white) }
                }
                .padding()
                .background(Color.darkHeader)
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 25) {
                        
                        CustomFieldContainer(label: "Goal Name") {
                            Text(goal.name).foregroundColor(.black)
                            Spacer()
                            Image(systemName: "chevron.down").foregroundColor(.gray)
                        }
                        
                        Text("Available balance: \(goal.currentAmount, format: .currency(code: "KES"))")
                            .font(.subheadline)
                            .foregroundColor(.appGreen)
                        
                        // Radio Buttons
                        VStack(alignment: .leading, spacing: 10) {
                            Text(mode == .deposit ? "Fund from:" : "Withdraw to:")
                                .font(.caption).foregroundColor(.gray)
                            HStack(spacing: 30) {
                                RadioButton(title: "Coop Account", isSelected: paymentMethod == .coop) { paymentMethod = .coop }
                                RadioButton(title: "M-PESA", isSelected: paymentMethod == .mpesa) { paymentMethod = .mpesa }
                            }
                        }
                        
                        // Dynamic Fields based on selection
                        if paymentMethod == .coop {
                            CustomFieldContainer(label: mode == .deposit ? "Credit Account" : "Debit Account") {
                                HStack {
                                    Image(systemName: "creditcard")
                                    VStack(alignment: .leading) {
                                        Text("Salary Account").font(.subheadline)
                                        Text("011090145246202").font(.caption).foregroundColor(.gray)
                                    }
                                    Spacer()
                                    Image(systemName: "chevron.down")
                                }
                            }
                            Text("Available balance: 87,000.00 KES").font(.caption).foregroundColor(.appGreen)
                        } else {
                            CustomFieldContainer(label: "Phone Number") {
                                TextField("0712345678", text: $phoneNumber)
                                    .keyboardType(.phonePad)
                            }
                        }
                        
                        CustomFieldContainer(label: mode == .deposit ? "Amount to deposit" : "Amount to withdraw") {
                            HStack {
                                Text("KES").foregroundColor(.gray)
                                Divider()
                                TextField("100.00", text: $amount).keyboardType(.decimalPad)
                            }
                        }
                        
                        Spacer(minLength: 30)
                        
                        Button(action: {
                            if let val = Double(amount) {
                                let ref = paymentMethod == .coop ? "Salary Account" : (phoneNumber.isEmpty ? "M-PESA" : phoneNumber)
                                viewModel.processTransaction(goalID: goal.id, amount: val, type: mode, method: paymentMethod, reference: ref)
                                showSuccess = true
                            }
                        }) {
                            Text(mode == .deposit ? "Deposit" : "Withdraw")
                                .font(.headline).foregroundColor(.white)
                                .frame(maxWidth: .infinity).padding()
                                .background(Color.appGreen).cornerRadius(8)
                        }
                    }
                    .padding()
                }
            }
            
            if showSuccess {
                SuccessModal(title: "\(amount) KES", subtitle: "\(mode == .deposit ? "Deposit" : "Withdrawal") Successful", amount: nil) {
                    dismiss()
                }
            }
        }
    }
}