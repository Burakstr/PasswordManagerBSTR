import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    @State private var showButtons = false
    @State private var showEditView = false
    @State private var selectedAccount: Account?
    @State private var showDetailView = false
    @State private var showAlert = false
    @State private var showAlertMessage = "Copied to clipboard"
    @State private var searchText = ""

    let categories = ["All", "Social Media", "Mobile Banking"]

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.accounts.isEmpty && viewModel.selectedCategory == "All" {
                    Spacer()
                    VStack {
                        Image("box")
                            .resizable()
                            .frame(width: 350, height: 150)
                    }
                    Spacer()
                } else {
                    VStack(alignment: .leading) {
                        TextField("Search...", text: $searchText)
                            .padding(10)
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                            .padding(.horizontal)


                        Text("Most Recently Used")
                            .font(.headline)
                            .padding(.leading, 15)
                            .padding(.top, 10)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(viewModel.recentAccounts, id: \.id) { account in
                                    if let uiImage = UIImage(named: account.imageName ?? "") {
                                        Button(action: {
                                            selectedAccount = account
                                            showDetailView = true
                                        }) {
                                            Image(uiImage: uiImage)
                                                .resizable()
                                                .frame(width: 45, height: 45)
                                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                                .padding(5)
                                        }
                                    } else {
                                        Button(action: {
                                            selectedAccount = account
                                            showDetailView = true
                                        }) {
                                            RoundedRectangle(cornerRadius: 8)
                                                .fill(Color.gray)
                                                .frame(width: 45, height: 45)
                                                .padding(5)
                                        }
                                    }
                                }
                            }
                            .padding(.leading, 15)
                        }

                        HStack(spacing: 15) {
                            ForEach(categories, id: \.self) { category in
                                Button(action: {
                                    viewModel.setCategory(category)
                                }) {
                                    Text(category)
                                        .font(.system(size: 15))
                                        .fontWeight(.semibold)
                                        .padding(.leading, 5)
                                        .padding(.top, 4)
                                        .foregroundColor(viewModel.selectedCategory == category ? Color.blue : Color.black)
                                }
                            }
                        }
                        .padding(.leading, 15)
                        .padding(.bottom, 10)

                        if viewModel.accounts.filter({ self.searchText.isEmpty ? true : $0.name?.contains(self.searchText) ?? false }).isEmpty {
                            Spacer()
                        } else {
                            List {
                                ForEach(viewModel.accounts.filter {
                                    self.searchText.isEmpty ? true : $0.name?.contains(self.searchText) ?? false
                                }, id: \.id) { account in
                                    HStack {
                                        if let uiImage = UIImage(named: account.imageName ?? "") {
                                            Image(uiImage: uiImage)
                                                .resizable()
                                                .frame(width: 35, height: 35)
                                                .clipShape(Circle())
                                        } else {
                                            Circle()
                                                .fill(Color.gray)
                                                .frame(width: 35, height: 35)
                                        }
                                        VStack(alignment: .leading) {
                                            Text(account.name ?? "")
                                                .font(.headline)
                                            Text(account.email ?? "")
                                                .font(.subheadline)
                                                .lineLimit(1)
                                                .truncationMode(.tail)
                                        }
                                        Spacer()
                                        Menu {
                                            Button(action: {
                                                UIPasteboard.general.string = account.email
                                                withAnimation {
                                                    showAlert = true
                                                    showAlertMessage = "Email copied to clipboard"
                                                }
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                                    withAnimation {
                                                        showAlert = false
                                                    }
                                                }
                                            }) {
                                                Label("Copy Email", systemImage: "doc.on.doc")
                                            }
                                            Button(action: {
                                                UIPasteboard.general.string = account.password
                                                withAnimation {
                                                    showAlert = true
                                                    showAlertMessage = "Password copied to clipboard"
                                                }
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                                    withAnimation {
                                                        showAlert = false
                                                    }
                                                }
                                            }) {
                                                Label("Copy Password", systemImage: "doc.on.doc")
                                            }
                                            Button(action: {
                                                selectedAccount = account
                                                showEditView = true
                                            }) {
                                                Label("Edit", systemImage: "pencil")
                                            }
                                            Button(action: {
                                                viewModel.deleteAccount(account)
                                            }) {
                                                Label {
                                                    Text("Delete")
                                                        .foregroundColor(.red)
                                                } icon: {
                                                    Image(systemName: "trash")
                                                        .foregroundColor(.red)
                                                }
                                            }
                                        } label: {
                                            Image(systemName: "ellipsis")
                                        }
                                    }
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(8)
                                    .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
                                    .padding(.horizontal)
                                    .padding(.top, 4)
                                    .padding(.bottom, 4)
                                    .onTapGesture {
                                        selectedAccount = account
                                        showDetailView = true
                                    }
                                    .listRowInsets(EdgeInsets())
                                }
                            }
                            .listStyle(PlainListStyle())
                        }
                    }
                }

                Spacer()

                HStack {
                    Spacer()
                    VStack {
                        if showButtons {
                            VStack(spacing: 16) {
                                NavigationLink(destination: AddSocialMediaView().onAppear {
                                    self.showButtons = false
                                }) {
                                    Text("Social Media")
                                        .frame(width: 200, height: 10)
                                        .padding()
                                        .background(Color.white)
                                        .cornerRadius(8)
                                        .shadow(radius: 4)
                                }
                                NavigationLink(destination: AddMobilBankAccountView().onAppear {
                                    self.showButtons = false
                                }) {
                                    Text("Mobile Bank Account")
                                        .frame(width: 200, height: 10)
                                        .padding()
                                        .background(Color.white)
                                        .cornerRadius(8)
                                        .shadow(radius: 4)
                                }
                            }
                            .padding(.horizontal, 32)
                        }

                        Spacer()
                            .frame(height: 32)

                        Button(action: {
                            withAnimation {
                                showButtons.toggle()
                            }
                        }) {
                            Image(systemName: showButtons ? "xmark" : "plus")
                                .foregroundColor(.white)
                                .frame(width: 50, height: 50)
                                .background(Color.blue)
                                .cornerRadius(25)
                                .shadow(radius: 4)
                        }
                        .padding(.bottom, 16)
                    }
                    Spacer()
                }
            }
            .navigationBarHidden(true)
            .onAppear {
                viewModel.fetchAccounts()
                viewModel.fetchRecentAccounts()
            }
            .sheet(isPresented: $showEditView) {
                if let account = selectedAccount {
                    EditAccountView(account: account)
                }
            }
            .background(
                NavigationLink(destination: AccountDetailView(account: selectedAccount ?? Account()), isActive: $showDetailView) {
                    EmptyView()
                }
            )
            .overlay(
                showAlert ? ShowAlertView(showAlert: $showAlert, message: showAlertMessage).transition(.opacity).zIndex(1) : nil
            )
            .background(Color.white.edgesIgnoringSafeArea(.all))
        }
    }
}

#Preview {
    ContentView()
}
