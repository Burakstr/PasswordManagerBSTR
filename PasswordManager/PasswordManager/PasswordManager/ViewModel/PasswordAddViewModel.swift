//
//  PasswordAddViewModel.swift
//  PasswordManager
//
//  Created by Burak Satır on 18.07.2024.
//

import SwiftUI
import Combine
import CoreData

class PasswordAddViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    var selectedImage: String
    
    private let coreDataManager = CoreDataManager.shared

    init(selectedImage: String) {
        self.selectedImage = selectedImage
    }
    
    func kaydet() {
        coreDataManager.saveAccount(
            name: "",
            email: email,
            password: password,
            imageName: selectedImage,
            category: "Other" 
        )
    }
}
