import SwiftUI

struct PasswordAddView: View {
    var selectedImage: String
    var category: String
    @State private var email = ""
    @State private var password = ""
    @State private var isPasswordVisible = false
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            if let uiImage = UIImage(named: selectedImage) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .padding(.top, 50)
            }

            VStack(spacing: 16) {
                TextField("Email or username", text: $email)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .shadow(radius: 2)
                
                ZStack(alignment: .trailing) {
                    if isPasswordVisible {
                        TextField("Password", text: $password)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                            .shadow(radius: 2)
                    } else {
                        SecureField("Password", text: $password)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                            .shadow(radius: 2)
                    }

                    Button(action: {
                        isPasswordVisible.toggle()
                    }) {
                        Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                            .padding()
                    }
                }
            }
            .padding(.horizontal, 32)
            .padding(.top, 50)

            Button(action: {
                CoreDataManager.shared.saveAccount(name: selectedImage, email: email, password: password, imageName: selectedImage, category: category)
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Add Account")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(8)
                    .shadow(radius: 4)
            }
            .padding(.horizontal, 32)
            .padding(.top, 30)

            Spacer()
        }
        .navigationTitle("Add Password")
        .padding()
        .background(Color(.systemGray5))
    }
}

#Preview {
    PasswordAddView(selectedImage: "Facebook", category: "Social Media")
}
