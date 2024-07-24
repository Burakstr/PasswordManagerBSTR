import SwiftUI

struct AddMobilBankAccountView: View {
    @StateObject private var viewModel = AddMobilBankAccountViewModel()

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        VStack {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(viewModel.filteredAppIcons, id: \.self) { iconName in
                    AppIconView(name: iconName, category: "Mobile Banking")
                        .environmentObject(viewModel)
                }
            }
            .padding(.horizontal)
            .padding(.top, 50)
            Spacer()
        }
        .searchable(text: $viewModel.searchText, prompt: "Search...")
        .navigationTitle("Add Mobile Bank Account")
    }
}

#Preview {
    AddMobilBankAccountView()
}
