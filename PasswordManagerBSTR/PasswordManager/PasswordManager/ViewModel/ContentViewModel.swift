import SwiftUI
import Combine
import CoreData

class ContentViewModel: ObservableObject {
    @Published var accounts: [Account] = []
    @Published var recentAccounts: [Account] = []
    @Published var selectedCategory: String = "All"
    
    private var cancellables = Set<AnyCancellable>()
    private let coreDataManager = CoreDataManager.shared

    func fetchAccounts() {
        if selectedCategory == "All" {
            accounts = coreDataManager.fetchAccounts()
        } else {
            accounts = coreDataManager.fetchAccounts(by: selectedCategory)
        }
    }

    func fetchRecentAccounts() {
        // Logic to fetch recent accounts, this might require additional Core Data functionality
    }

    func deleteAccount(_ account: Account) {
        coreDataManager.deleteAccount(account)
        fetchAccounts()
    }

    func setCategory(_ category: String) {
        selectedCategory = category
        fetchAccounts()
    }
}
