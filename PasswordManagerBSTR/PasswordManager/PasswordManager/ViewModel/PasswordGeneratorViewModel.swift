import SwiftUI
import Combine

class PasswordGeneratorViewModel: ObservableObject {
    @Published var password: String = ""
    @Published var length: Double = 0
    @Published var includeDigits = false
    @Published var includeLetters = false
    @Published var includeSymbols = false
    @Published var showAlert = false

    func generatePassword() {
        var characters = ""
        if includeDigits {
            characters += "0123456789"
        }
        if includeLetters {
            characters += "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        }
        if includeSymbols {
            characters += "!@#$%^&*()_+-=[]{}|;':,.<>/?"
        }

        password = String((0..<Int(length)).compactMap { _ in characters.randomElement() })
    }

    func copyToClipboard() {
        UIPasteboard.general.string = password
        withAnimation {
            showAlert = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            withAnimation {
                self?.showAlert = false
            }
        }
    }
}
