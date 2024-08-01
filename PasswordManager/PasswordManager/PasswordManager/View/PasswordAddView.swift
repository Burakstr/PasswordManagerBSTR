import SwiftUI

struct PasswordAddView: View {
    var selectedImage: String
    var category: String
    @State private var email = ""
    @State private var password = ""
    @State private var isPasswordVisible = false
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack {
            Color(hexs: "#0C1E34")
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                if let uiImage = UIImage(named: selectedImage) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                        .background(Color.white) // Arka plan ekleyerek kontrastı artırın
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                        .padding(.top, 50)
                } else {
                    Circle()
                        .fill(Color.gray)
                        .frame(width: 100, height: 100)
                        .overlay(Text("No Image").foregroundColor(.white))
                        .padding(.top, 50)
                }

                VStack(spacing: 16) {
                    HStack {
                        Image(systemName: "envelope")
                            .foregroundColor(.gray)
                        TextField("Email or username", text: $email)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .foregroundColor(.white)  // Metin rengini beyaz yap
                            .placeholder(when: email.isEmpty) {
                                Text("Email or username")
                                    .foregroundColor(.gray)
                            }
                    }
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .shadow(radius: 2)
                    
                    ZStack(alignment: .trailing) {
                        if isPasswordVisible {
                            TextField("Password", text: $password)
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                                .foregroundColor(.white)  // Metin rengini beyaz yap
                                .placeholder(when: password.isEmpty) {
                                    Text("Password")
                                        .foregroundColor(.gray)
                                }
                                .padding()
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(8)
                                .shadow(radius: 2)
                        } else {
                            SecureField("Password", text: $password)
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                                .foregroundColor(.white)  // Metin rengini beyaz yap
                                .placeholder(when: password.isEmpty) {
                                    Text("Password")
                                        .foregroundColor(.gray)
                                }
                                .padding()
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(8)
                                .shadow(radius: 2)
                        }

                        Button(action: {
                            isPasswordVisible.toggle()
                        }) {
                            Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                                .padding()
                                .foregroundColor(.gray)
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
            .padding()
        }
        .navigationTitle("Add Password")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            setupNavigationBarAppearance()
        }
    }
}

#Preview {
    PasswordAddView(selectedImage: "Facebook", category: "Social Media")
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

