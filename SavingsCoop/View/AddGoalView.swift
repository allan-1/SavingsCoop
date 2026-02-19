//
//  AddGoalView.swift
//  SavingsCoop
//
//  Created by Allan Maina on 16/02/2026.
//


struct AddGoalView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: SavingsViewModel
    
    @State private var name = ""
    @State private var category = "Personal"
    @State private var targetAmount = ""
    @State private var targetDate = Date()
    
    let categories = ["Personal", "Travel", "Family", "Emergency", "Business"]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Please let's have the following:")) {
                    VStack(alignment: .leading) {
                        Text("Goal Name").font(.caption).foregroundColor(.gray)
                        TextField("e.g. Dubai Trip", text: $name)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Goal Category").font(.caption).foregroundColor(.gray)
                        Picker("Category", selection: $category) {
                            ForEach(categories, id: \.self) { Text($0) }
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Target Amount (KES)").font(.caption).foregroundColor(.gray)
                        TextField("0.00", text: $targetAmount)
                            .keyboardType(.decimalPad)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Savings Target Date").font(.caption).foregroundColor(.gray)
                        DatePicker("", selection: $targetDate, displayedComponents: .date)
                            .labelsHidden()
                    }
                }
                
                Button(action: {
                    if let amount = Double(targetAmount) {
                        viewModel.createGoal(name: name, category: category, target: amount, date: targetDate)
                        dismiss()
                    }
                }) {
                    Text("Create a Goal")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(hex: "8bc34a"))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .listRowBackground(Color.clear)
                .disabled(name.isEmpty || targetAmount.isEmpty)
            }
            .navigationTitle("Create a Goal")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") { dismiss() }
                }
            }
        }
    }
}
