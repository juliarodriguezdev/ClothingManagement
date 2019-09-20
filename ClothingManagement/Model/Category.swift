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
    
    var recordID: CKRecord.ID
    
    // link this class back to the user model object class
    weak var user: User?
    var categoryPhotos: [CategoryPhoto]
    var iconImageData: Data?
    var iconImage: UIImage? {
        get {
            guard let iconImageData = iconImageData else { return nil }
            return UIImage(data: iconImageData)
        } set {
            iconImageData = newValue?.jpegData(compressionQuality: 0.5)
        }
    }
    var iconImageAsset: CKAsset? {
        get {
            let tempDictionary = NSTemporaryDirectory()
            let tempDictionaryURL = URL(fileURLWithPath: tempDictionary)
            let fileURL = tempDictionaryURL.appendingPathComponent(UUID().uuidString).appendingPathExtension("jpg")
            do {
                try iconImageData?.write(to: fileURL)
            } catch {
                print("Error writing to temporary url \(error.localizedDescription)")
            }
            return CKAsset(fileURL: fileURL)
        }
    }

    
    // object refrence to the user
    var userReference: CKRecord.Reference? {
        guard let user = user else { return nil }
        return CKRecord.Reference(recordID: user.CKRecordID, action: .deleteSelf)
    }
    
    // MARK: - Designated Initializers for class
    init(name: String, quantity: Int, user: User?, categoryPhotos: [CategoryPhoto] = [], recordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)) {
    
        self.name = name
        self.quantity = quantity
        self.user = user
        self.recordID = recordID
        self.categoryPhotos = categoryPhotos
        //self.iconImage = iconImage
        
    }
    
     //falliable Initialize - init a category from a record (cloud -> Device)
    init?(record: CKRecord, user: User) {


        guard let name = record[CategoryConstants.nameKey] as? String,
            let quantity = record[CategoryConstants.quantityKey] as? Int
            else { return nil }
        let categoryPhotos = record[CategoryConstants.categoryPhotoKey] as? [CategoryPhoto] ?? []

        self.name = name
        self.quantity = quantity
        self.user = user
        self.recordID = record.recordID
        self.categoryPhotos = categoryPhotos
        
        // computed properties get intialized after stored properties
        if let iconImageAsset = record[CategoryConstants.iconImageKey] as? CKAsset,
           let iconImageData = try? Data(contentsOf: iconImageAsset.fileURL!) {
            let photo = UIImage(data: iconImageData)
            self.iconImage = photo
        }
        else {
           self.iconImage = UIImage(named: "hangerDefault")
       }
        
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
        self.setValue(category.iconImageAsset, forKey: CategoryConstants.iconImageKey)

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
fileprivate static let categoryPhotoKey = "categoryPhotos"
fileprivate static let iconImageKey = "iconImage"
    

}
