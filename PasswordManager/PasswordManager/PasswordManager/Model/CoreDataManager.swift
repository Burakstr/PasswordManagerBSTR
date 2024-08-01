import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()

    let persistentContainer: NSPersistentContainer

    private init() {
        persistentContainer = NSPersistentContainer(name: "PasswordManagerModel")
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
    }

    func saveAccount(name: String, email: String, password: String, imageName: String, category: String) {
        let context = persistentContainer.viewContext
        let account = Account(context: context)
        account.id = UUID()
        account.name = name
        account.email = email
        account.password = password
        account.imageName = imageName
        account.category = category
        account.created = Date()
        account.lastModified = Date()

        do {
            try context.save()
        } catch {
            print("Failed to save account: \(error)")
        }
    }

    func fetchAccounts() -> [Account] {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Account> = Account.fetchRequest()

        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Failed to fetch accounts: \(error)")
            return []
        }
    }

    func fetchAccounts(by category: String) -> [Account] {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Account> = Account.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "category == %@", category)

        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Failed to fetch accounts: \(error)")
            return []
        }
    }

    func deleteAccount(_ account: Account) {
        let context = persistentContainer.viewContext
        context.delete(account)
        saveContext()  // Değişiklikleri kaydedin
    }

    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Failed to save context: \(error)")
            }
        }
    }
}
