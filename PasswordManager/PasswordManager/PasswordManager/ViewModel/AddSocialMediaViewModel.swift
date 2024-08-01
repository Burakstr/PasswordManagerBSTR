import SwiftUI
import Combine

class AddSocialMediaViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var appIcons = [
        "Facebook", "Instagram", "X", "Tiktok", "YouTube", "LinkedIn", "Gmail", "Outlook", "Disney+", "Amazon", "Snapchat", "Netflix", "Sahibinden"
    ]
    
    private var cancellables = Set<AnyCancellable>()
    private let coreDataManager = CoreDataManager.shared

    var filteredAppIcons: [String] {
        if searchText.isEmpty {
            return appIcons
        } else {
            return appIcons.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }

    func saveAccount(iconName: String, email: String, password: String) {
        coreDataManager.saveAccount(
            name: iconName,
            email: email,
            password: password,
            imageName: iconName,
            category: "Social Media"
        )
    }
}
