import SwiftUI

struct ShowAlertView: View {
    @Binding var showAlert: Bool
    var message: String

    var body: some View {
        VStack {
            Text(message)
                .font(.headline)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
        .padding()
        .shadow(radius: 10)
        .onTapGesture {
            withAnimation {
                showAlert = false
            }
        }
    }
}

#Preview {
    ShowAlertView(showAlert: .constant(true), message: "Copied to clipboard")
}
