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
            ZStack {
                Color(hexs: "#0C1E34")
                    .edgesIgnoringSafeArea(.all)

                VStack {
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                            TextField("Search...", text: $searchText)
                                .foregroundColor(.black)
                                .plaaceholder(when: searchText.isEmpty) {
                                    Text("Search...")
                                        .foregroundColor(.gray)
                                }
                        }
                        .padding(10)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                        .padding(.horizontal)

                        Text("Most Recently Used")
                            .font(.headline)
                            .foregroundColor(Color(hexs: "#8E9CA9"))
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
                                        .foregroundColor(viewModel.selectedCategory == category ? Color.blue : Color(hexs: "#8E9CA9"))
                                }
                            }
                        }
                        .padding(.leading, 15)
                        .padding(.bottom, 10)

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
                                            .foregroundColor(.white)
                                        Text(account.email ?? "")
                                            .font(.subheadline)
                                            .lineLimit(1)
                                            .truncationMode(.tail)
                                            .foregroundColor(Color(hexs: "#8E9CA9"))
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
                                            .foregroundColor(.white)
                                    }
                                }
                                .padding()
                                .background(Color.gray.opacity(0.2))  // Hesap arka plan rengi arama çubuğu gibi
                                .cornerRadius(8)
                                .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2) // Gölge efekti
                                .padding(.horizontal)
                                .padding(.top, 4)
                                .padding(.bottom, 4)
                                .onTapGesture {
                                    selectedAccount = account
                                    showDetailView = true
                                }
                                .listRowBackground(Color(hexs: "#0C1E34"))
                                .listRowInsets(EdgeInsets())
                            }
                        }
                        .listStyle(PlainListStyle())
                        .background(Color(hexs: "#0C1E34"))
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
                                            .background(Color.gray)
                                            .foregroundColor(.black)
                                            .cornerRadius(8)
                                            .shadow(radius: 4)
                                    }
                                    NavigationLink(destination: AddMobilBankAccountView().onAppear {
                                        self.showButtons = false
                                    }) {
                                        Text("Mobile Bank Account")
                                            .frame(width: 200, height: 10)
                                            .padding()
                                            .background(Color.gray)
                                            .foregroundColor(.black)
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
                                    .foregroundColor(.black)
                                    .frame(width: 50, height: 50)
                                    .background(Color.gray)
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
                .background(Color(hexs: "#0C1E34").edgesIgnoringSafeArea(.all))
            }
        }
    }
}

#Preview {
    ContentView()
}

extension View {
    func plaaceholder<Content: View>(
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
    init(hexs: String) {
        let scanner = Scanner(string: hexs)
        _ = scanner.scanString("#")
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >> 8) & 0xFF) / 255.0
        let b = Double(rgb & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b)
    }
}
