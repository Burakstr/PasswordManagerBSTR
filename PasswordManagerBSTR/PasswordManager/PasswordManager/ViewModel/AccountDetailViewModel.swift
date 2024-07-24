import SwiftUI
import Combine
import CoreData

class AccountDetailViewModel: ObservableObject {
    @Published var account: Account
    @Published var showPassword = false
    @Published var showAlert = false
    @Published var showAlertMessage = "Copied to clipboard"

    private var cancellables = Set<AnyCancellable>()
    private let coreDataManager = CoreDataManager.shared

    init(account: Account) {
        self.account = account
    }

    func copyToClipboard(_ text: String, isPassword: Bool) {
        UIPasteboard.general.string = text
        showAlertMessage = isPassword ? "Password copied to clipboard" : "Email copied to clipboard"
        showAlert = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.showAlert = false
        }
    }

    func saveChanges(email: String, password: String) {
        account.email = email
        account.password = password
        coreDataManager.saveContext()
    }
}
