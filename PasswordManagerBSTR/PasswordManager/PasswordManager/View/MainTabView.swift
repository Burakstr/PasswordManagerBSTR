import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            NavigationStack {
                ContentView()
                    .navigationTitle("Home")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .tabItem {
                Image(systemName: "house")
            }

            NavigationStack {
                PasswordGenerator()
                    .navigationTitle("Password Generator")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .tabItem {
                Image(systemName: "key.horizontal.fill")
            }
        }
    }
}

#Preview {
    MainTabView()
}
