import SwiftUI

struct PasswordGenerator: View {
    @StateObject private var viewModel = PasswordGeneratorViewModel()

    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text(viewModel.password)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                    Button(action: viewModel.copyToClipboard) {
                        Image(systemName: "doc.on.doc")
                    }
                }
                .padding()
                .padding(.bottom, 50)

                Slider(value: $viewModel.length, in: 4...40, step: 1)
                    .padding()

                Text("Length: \(Int(viewModel.length))")
                    .padding()

                VStack(alignment: .leading) {
                    Toggle(isOn: $viewModel.includeDigits) {
                        Text("Digits")
                    }
                    Toggle(isOn: $viewModel.includeLetters) {
                        Text("Letters")
                    }
                    Toggle(isOn: $viewModel.includeSymbols) {
                        Text("Symbols")
                    }
                }
                .padding()

                Button(action: viewModel.generatePassword) {
                    Text("Generate")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }
            .padding()
            .navigationTitle("Password Generator")
            .navigationBarTitleDisplayMode(.inline)

            if viewModel.showAlert {
                ShowAlertView(showAlert: $viewModel.showAlert, message: "Copied to clipboard")
            }
        }
    }
}

#Preview {
    PasswordGenerator()
}
