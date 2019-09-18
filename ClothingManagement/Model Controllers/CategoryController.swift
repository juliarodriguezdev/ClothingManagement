//
//  CategoryController.swift
//  ClothingManagement
//
//  Created by Julia Rodriguez on 9/10/19.
//  Copyright © 2019 Julia Rodriguez. All rights reserved.
//

import UIKit
import CloudKit

class CategoryController {
    
    static let shared = CategoryController()
    
    var categories: [Category] = []
    
    var sumOfCloset: Int?
    
    let publicDB = CKContainer.default().publicCloudDatabase
    
    // CRUD
    
    // Create
    func createCategory(withName name: String, quantity: Int, user: User, completion: @escaping (Category?) -> Void) {
        
        // create object from class properties
        let category = Category(name: name, quantity: quantity, user: user)
        // create a CKrecord from class object
        let record = CKRecord(category: category)
        CloudKitController.shared.publicDB.save(record) { (record, error) in
            if let error = error {
                print("Error in \(#function): \(error.localizedDescription) /n---/n \(error)")
                completion(nil)
                return
            }
            guard let record = record,
                // create a record/category from the cloud (CKDatabase)
                let category = Category(record: record, user: user) else { completion(nil); return }
            self.categories.append(category)
            completion(category)
        }
    }
    
    // Read
    func fetchCategories(user: User, completion: @escaping ([Category]?) -> Void) {
        let userReference = user.CKRecordID
        let userReferencePredicate = NSPredicate(format: "%K == %@", CategoryConstants.userReferenceKey, userReference)
        // return non nil values
        let categoryIDs = user.closet.compactMap({$0.recordID})
        let avoidDuplicatePredicate = NSPredicate(format: "Not(recordID in %@)", categoryIDs)
        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [userReferencePredicate, avoidDuplicatePredicate])
        let query = CKQuery(recordType: CategoryConstants.categoryTypeKey, predicate: compoundPredicate)
        CloudKitController.shared.publicDB.perform(query, inZoneWith: nil) { (record, error) in
            if let error = error {
                print("Error in \(#function): \(error.localizedDescription) /n---/n \(error)")
                completion(nil)
                return
            }
            guard let record = record else { completion(nil); return }
            let categories = record.compactMap{Category(record: $0, user: user)}
            self.categories = categories
            completion(categories)
        }
    }
    
    // update
    
    func updateCategory(category: Category, completion: @escaping (Bool) -> Void) {
        let recordToSave = CKRecord(category: category)
        let database = self.publicDB
        
        CloudKitController.shared.update(record: recordToSave, database: database) { (success) in
            if success {
                print("Category updated successfully")
                completion(true)
            } else {
                print("Category failed to update)")
                completion(false)
                return 
            }
        }
    }
    
    
    // delete
    func deleteCategory(category: Category, completion: @escaping (Bool) -> Void) {
        
        guard let index = categories.firstIndex(of: category) else { return }
        categories.remove(at: index)
        CloudKitController.shared.delete(recordID: category.recordID, database: CloudKitController.shared.publicDB) { (success) in
            completion(success ? true : false )
        }

    }
    
    func calculateNumOfItemsInCloset(categories: [Category]) -> Int {
        
        let total = categories.map { $0.quantity }
        let sum = total.reduce(0, +)
        print(total)
        print(sum)
        return sum
        
    }
}
