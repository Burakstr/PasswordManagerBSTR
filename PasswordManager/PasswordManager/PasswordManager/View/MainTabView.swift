import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            NavigationStack {
                ContentView()
                    .navigationTitle("Home")
                    .navigationBarTitleDisplayMode(.inline)
                    .onAppear {
                        setupNavigationBarAppearance()
                    }
            }
            .tabItem {
                Image(systemName: "house")
                Text("Home")
            }

            NavigationStack {
                PasswordGenerator()
            }
            .tabItem {
                Image(systemName: "key.horizontal.fill")
                Text("Generator")
            }
        }
        .accentColor(.white)
        .onAppear {
            UITabBar.appearance().unselectedItemTintColor = UIColor.gray
        }
    }
    
    private func setupNavigationBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(Color(hexs: "#0C1E34"))
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}

#Preview {
    MainTabView()
}
