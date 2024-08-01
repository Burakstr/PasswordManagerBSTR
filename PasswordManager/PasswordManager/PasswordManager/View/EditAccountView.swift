import SwiftUI

struct EditAccountView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel: AccountDetailViewModel
    @State private var email = ""
    @State private var password = ""
    @State private var isPasswordVisible = false

    init(account: Account) {
        _viewModel = StateObject(wrappedValue: AccountDetailViewModel(account: account))
    }

    var body: some View {
        ZStack {
            Color(hexs: "#0C1E34")
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    if let uiImage = UIImage(named: viewModel.account.imageName ?? "") {
                        Image(uiImage: uiImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                    }
                    Text("Edit Account")
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding(.leading, 10)
                }
                .padding(.top, 50)

                VStack(spacing: 16) {
                    HStack {
                        Image(systemName: "envelope")
                            .foregroundColor(.gray)
                        TextField("Email", text: $email)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .foregroundColor(.white)
                            .placeholder(when: email.isEmpty) {
                                Text("Email")
                                    .foregroundColor(.gray)
                            }
                    }
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .shadow(radius: 2)
                    
                    ZStack(alignment: .trailing) {
                        if isPasswordVisible {
                            HStack {
                                Image(systemName: "lock")
                                    .foregroundColor(.gray)
                                TextField("Password", text: $password)
                                    .autocapitalization(.none)
                                    .disableAutocorrection(true)
                                    .foregroundColor(.white)
                                    .placeholder(when: password.isEmpty) {
                                        Text("Password")
                                            .foregroundColor(.gray)
                                    }
                            }
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                            .shadow(radius: 2)
                        } else {
                            HStack {
                                Image(systemName: "lock")
                                    .foregroundColor(.gray)
                                SecureField("Password", text: $password)
                                    .autocapitalization(.none)
                                    .disableAutocorrection(true)
                                    .foregroundColor(.white)
                                    .placeholder(when: password.isEmpty) {
                                        Text("Password")
                                            .foregroundColor(.gray)
                                    }
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
                    viewModel.saveChanges(email: email, password: password)
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Save Changes")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                        .shadow(radius: 4)
                }
                .padding(.horizontal, 32)
                .padding(.top, 30)

                Spacer()
            }
            .onAppear {
                email = viewModel.account.email ?? ""
                password = viewModel.account.password ?? ""
            }
            .padding()
        }
        .navigationTitle("Edit Account")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            setupNavigationBarAppearance()
        }
    }
}

struct EditAccountView_Previews: PreviewProvider {
    static var previews: some View {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let account = Account(context: context)
        account.name = "Sample Account"
        account.email = "sample@example.com"
        account.password = "password123"
        account.imageName = "sampleImage"
        account.category = "Sample Category"
        account.created = Date()
        account.lastModified = Date()
        
        return EditAccountView(account: account)
    }
}

extension View {
    func placeholder1<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

extension Color {
    init(hexs1: String) {
        let scanner = Scanner(string: hexs1)
        _ = scanner.scanString("#")
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >> 8) & 0xFF) / 255.0
        let b = Double(rgb & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b)
    }
}

func setupNavigationBarAppearance() {
    let appearance = UINavigationBarAppearance()
    appearance.backgroundColor = UIColor(Color(hexs1: "#0C1E34"))
    appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
    appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    
    UINavigationBar.appearance().tintColor = .white // Geri butonunu beyaz yapar
    
    UINavigationBar.appearance().standardAppearance = appearance
    UINavigationBar.appearance().compactAppearance = appearance
    UINavigationBar.appearance().scrollEdgeAppearance = appearance
}
