//
//  EditAccountViewModel.swift
//  PasswordManager
//
//  Created by Burak Satır on 24.07.2024.
//

import SwiftUI
import CoreData

class EditAccountViewModel: ObservableObject {
    @Published var email: String
    @Published var password: String
    @Published var isPasswordVisible = false
    
    private let coreDataManager = CoreDataManager.shared
    private var account: Account
    
    init(account: Account) {
        self.account = account
        self.email = account.email ?? ""
        self.password = account.password ?? ""
    }
    
    func saveChanges() {
        account.email = email
        account.password = password
        coreDataManager.saveContext()
    }
}
