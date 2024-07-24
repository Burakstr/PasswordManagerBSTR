import SwiftUI
import Combine
import CoreData

class AddMobilBankAccountViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var appIcons = [
        "Ziraat Bankası", "İş Bankası", "YapıKredi", "Garanti Bankası", "Akbank", "Vakıfbank","CepteTEB","Odebank","INGBank","Denizbank","Halkbank","Sekerbank"
    ]
    @Published var accountName: String = ""
    @Published var accountEmail: String = ""
    @Published var accountPassword: String = ""
    @Published var selectedCategory: String = "Mobile Banking"

    private var cancellables = Set<AnyCancellable>()
    private let coreDataManager = CoreDataManager.shared

    var filteredAppIcons: [String] {
        if searchText.isEmpty {
            return appIcons
        } else {
            return appIcons.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }

    func saveAccount(iconName: String) {
        coreDataManager.saveAccount(
            name: accountName,
            email: accountEmail,
            password: accountPassword,
            imageName: iconName,
            category: selectedCategory
        )
    }
}
