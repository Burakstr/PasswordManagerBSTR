import Foundation
import Combine
import UIKit

class PasswordGeneratorViewModel: ObservableObject {
    @Published var password: String = ""
    @Published var length: Double = 18
    @Published var includeLowercase: Bool = true
    @Published var includeUppercase: Bool = true
    @Published var includeNumbers: Bool = true
    @Published var includeSymbols: Bool = false

    private var cancellables = Set<AnyCancellable>()

    init() {
        $length
            .sink { [weak self] _ in
                self?.generatePassword()
            }
            .store(in: &cancellables)
        
        $includeLowercase
            .sink { [weak self] _ in
                self?.generatePassword()
            }
            .store(in: &cancellables)
        
        $includeUppercase
            .sink { [weak self] _ in
                self?.generatePassword()
            }
            .store(in: &cancellables)
        
        $includeNumbers
            .sink { [weak self] _ in
                self?.generatePassword()
            }
            .store(in: &cancellables)
        
        $includeSymbols
            .sink { [weak self] _ in
                self?.generatePassword()
            }
            .store(in: &cancellables)

        generatePassword()
    }

    func generatePassword() {
        var characters = ""
        if includeLowercase {
            characters += "abcdefghijklmnopqrstuvwxyz"
        }
        if includeUppercase {
            characters += "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        }
        if includeNumbers {
            characters += "0123456789"
        }
        if includeSymbols {
            characters += "!@#$%^&*()_+-=[]{}|;:'\",.<>?/`~"
        }

        password = String((0..<Int(length)).compactMap { _ in characters.randomElement() })
    }

    func copyToClipboard() {
        UIPasteboard.general.string = password
    }

    func sharePassword() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootViewController = windowScene.windows.first?.rootViewController else {
            return
        }

        let activityViewController = UIActivityViewController(activityItems: [password], applicationActivities: nil)
        rootViewController.present(activityViewController, animated: true, completion: nil)
    }
}
