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
                    .padding(.leading, 10)
            }
            .padding(.top, 50)

            VStack(spacing: 16) {
                TextField("Email", text: $email)
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
        .background(Color(.systemGray5))
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
