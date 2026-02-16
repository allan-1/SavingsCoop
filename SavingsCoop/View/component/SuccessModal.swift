struct SuccessModal: View {
    let title: String
    let subtitle: String
    let amount: Double?
    let onDismiss: () -> Void
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.5).ignoresSafeArea()
            
            VStack(spacing: 20) {
                // 3D Tick Icon Placeholder
                Circle()
                    .fill(Color.appGreen)
                    .frame(width: 80, height: 80)
                    .overlay(Image(systemName: "checkmark").font(.largeTitle).foregroundColor(.white))
                    .shadow(radius: 5)
                    .padding(.top, 20)
                
                Text(title)
                    .font(.title2).bold().foregroundColor(.appGreen)
                
                Text(subtitle)
                    .font(.headline).foregroundColor(.gray)
                
                if amount == nil {
                    Text("You are one step closer to\nreaching your target")
                        .multilineTextAlignment(.center)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.horizontal)
                }
                
                Button(action: onDismiss) {
                    Text("Go to My Goals")
                        .bold()
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.appGreen)
                        .cornerRadius(8)
                }
                .padding()
            }
            .background(Color.white)
            .cornerRadius(12)
            .padding(30)
        }
    }
}