struct RadioButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                ZStack {
                    Circle()
                        .stroke(isSelected ? Color.appGreen : Color.gray, lineWidth: 2)
                        .frame(width: 20, height: 20)
                    if isSelected {
                        Circle()
                            .fill(Color.appGreen)
                            .frame(width: 10, height: 10)
                    }
                }
                Text(title)
                    .foregroundColor(isSelected ? .appGreen : .gray)
                    .font(.body)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}