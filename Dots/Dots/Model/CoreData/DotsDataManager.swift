//
//  DotsDataManager.swift
//  Dots
//
//  Created by 정승균 on 2023/07/17.
//

import Foundation
import CoreData

class CoreDataManager {
    static let instance = CoreDataManager() // singleton
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    init() {
        // Container 지정 = Database
        container = NSPersistentContainer(name: "DotsDataContainer")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error loading Core Data. \(error)")
            }
        }
        // context 지정 = Database 저장 관리자
        context = container.viewContext
    }
    
    func save() {
        do {
            try context.save()
            print("Saved Successfully!")
        } catch let error {
            print("Saving error. \(error.localizedDescription)")
        }
    }
}
