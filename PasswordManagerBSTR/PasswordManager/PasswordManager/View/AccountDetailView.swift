import SwiftUI

struct AccountDetailView: View {
    @StateObject private var viewModel: AccountDetailViewModel

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

                VStack(alignment: .leading) {
                    Text(viewModel.account.name ?? "")
                        .font(.title)
                        .fontWeight(.bold)
                    Text(viewModel.account.category ?? "")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                Spacer()
            }
            .padding()

            Divider()

            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text("Email:")
                        .fontWeight(.semibold)
                    Text(viewModel.account.email ?? "")
                    Spacer()
                    Button(action: {
                        viewModel.copyToClipboard(viewModel.account.email ?? "", isPassword: false)
                    }) {
                        Image(systemName: "doc.on.doc")
                    }
                }
                HStack {
                    Text("Password:")
                        .fontWeight(.semibold)
                    if viewModel.showPassword {
                        Text(viewModel.account.password ?? "")
                    } else {
                        SecureField("", text: .constant(viewModel.account.password ?? ""))
                            .disabled(true)
                    }
                    Spacer()
                    Button(action: {
                        viewModel.showPassword.toggle()
                    }) {
                        Image(systemName: viewModel.showPassword ? "eye.slash" : "eye")
                    }
                    Button(action: {
                        viewModel.copyToClipboard(viewModel.account.password ?? "", isPassword: true)
                    }) {
                        Image(systemName: "doc.on.doc")
                    }
                }
            }
            .padding(.horizontal)

            Divider()

            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text("Last Modified:")
                        .font(.caption)
                    Spacer()
                    Text(viewModel.account.lastModified ?? Date(), style: .date)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                HStack {
                    Text("Created:")
                        .font(.caption)
                    Spacer()
                    Text(viewModel.account.created ?? Date(), style: .date)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            .padding(.horizontal)

            Spacer()
        }
        .padding()
        .navigationTitle("Account Details")
        .overlay(
            viewModel.showAlert ? ShowAlertView(showAlert: $viewModel.showAlert, message: viewModel.showAlertMessage).transition(.opacity).zIndex(1) : nil
        )
        .navigationBarItems(trailing: NavigationLink(destination: EditAccountView(account: viewModel.account)) {
            Text("Edit")
        })
    }
}

#Preview {
    AccountDetailView(account: Account())
}
