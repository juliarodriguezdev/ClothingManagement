//
//  Category.swift
//  ClothingManagement
//
//  Created by Julia Rodriguez on 9/11/19.
//  Copyright © 2019 Julia Rodriguez. All rights reserved.
//

import UIKit
import CloudKit

class Category {
    
    // class objects
    var name: String
    var quantity: Int
    
    // TODO: var photos: [String]?
    var recordID: CKRecord.ID
    // link this class back to the user model object class
    weak var user: User?
    
    // object refrence to the user
    var userReference: CKRecord.Reference? {
        guard let user = user else { return nil }
        return CKRecord.Reference(recordID: user.CKRecordID, action: .deleteSelf)
    }
    
    // MARK: - Designated Initializers for class
    init(name: String, quantity: Int, user: User?, recordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)) {
    
        self.name = name
        self.quantity = quantity
        self.user = user
        self.recordID = recordID
        
    }
    
    // falliable Initialize - init a category from a record (cloud -> Device)
    convenience init?(record: CKRecord, user: User) {
        guard let name = record[CategoryConstants.nameKey] as? String,
            let quantity = record[CategoryConstants.quantityKey] as? Int
        else { return nil }
        self.init(name: name, quantity: quantity, user: user, recordID: record.recordID)
    }
}
// MARK: - Initialize a record from a class object (device -> Cloud)
extension CKRecord {
    convenience init(category: Category) {
        self.init(recordType: CategoryConstants.categoryTypeKey, recordID: category.recordID)
        // set value to ckRecord (class)
        self.setValue(category.name, forKey: CategoryConstants.nameKey)
        self.setValue(category.quantity, forKey: CategoryConstants.quantityKey)
        self.setValue(category.userReference, forKey: CategoryConstants.userReferenceKey)
    }
}

extension Category: Equatable {
    static func == (lhs: Category, rhs: Category) -> Bool {
        return lhs.recordID == rhs.recordID
    }
    
    
}
// MARK: - Key Constants
struct CategoryConstants {
    
static let categoryTypeKey = "Category"
static let userReferenceKey = "userReference"
fileprivate static let nameKey = "name"
fileprivate static let quantityKey = "quantity"
fileprivate static let isMaleKey = "isMale"

}
