import SwiftUI

struct AddMobilBankAccountView: View {
    @StateObject private var viewModel = AddMobilBankAccountViewModel()

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        ZStack {
            Color(hexs: "#0C1E34")
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    TextField("Search...", text: $viewModel.searchText)
                        .foregroundColor(.white)
                        .placeholder(when: viewModel.searchText.isEmpty) {
                            Text("Search...")
                                .foregroundColor(.gray)
                        }
                }
                .padding(10)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .padding(.horizontal)

                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(viewModel.filteredAppIcons, id: \.self) { iconName in
                        AppIconView(name: iconName, category: "Mobile Banking")
                            .environmentObject(viewModel)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 20)
                Spacer()
            }
            .navigationTitle("Add Mobile Bank Account")
            .onAppear {
                setupNavigationBarAppearance()
            }
        }
    }
}

#Preview {
    AddMobilBankAccountView()
}
