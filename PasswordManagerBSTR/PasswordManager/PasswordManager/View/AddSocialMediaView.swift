import SwiftUI

struct AddSocialMediaView: View {
    @StateObject private var viewModel = AddSocialMediaViewModel()

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        VStack {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(viewModel.filteredAppIcons, id: \.self) { iconName in
                    AppIconView(name: iconName, category: "Social Media")
                        .environmentObject(viewModel)
                }
            }
            .padding(.horizontal)
            .padding(.top, 50)
            Spacer()
        }
        .searchable(text: $viewModel.searchText, prompt: "Search...")
        .navigationTitle("Add Social Media")
    }
}

#Preview {
    AddSocialMediaView()
}
