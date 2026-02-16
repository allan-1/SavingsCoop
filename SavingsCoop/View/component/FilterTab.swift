struct FilterTab: View {
    let text: String
    let selected: Bool
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            Text(text)
                .font(.subheadline)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(selected ? Color.appGreen.opacity(0.1) : Color.clear)
                .foregroundColor(selected ? .darkHeader : .gray)
                .cornerRadius(8)
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(selected ? Color.clear : Color.gray.opacity(0.3)))
        }