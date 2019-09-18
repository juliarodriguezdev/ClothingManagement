//
//  CategoryPhoto.swift
//  ClothingManagement
//
//  Created by Julia Rodriguez on 9/16/19.
//  Copyright © 2019 Julia Rodriguez. All rights reserved.
//

import UIKit
import CloudKit

class CategoryPhoto {
    var categoryPhotoData: Data?
    // create a constant variable for only this object
    var categoryPhoto: UIImage? {
        get {
            guard let categoryPhotoData = categoryPhotoData else { return nil }
            return UIImage(data: categoryPhotoData)
        } set {
            categoryPhotoData = newValue?.jpegData(compressionQuality: 0.5)
        }
    }
    
    var categoryPhotoAsset: CKAsset? {
        get {
            let tempDictionary = NSTemporaryDirectory()
            let tempDictionaryURl = URL(fileURLWithPath: tempDictionary)
            let fileURL = tempDictionaryURl.appendingPathComponent(UUID().uuidString).appendingPathExtension("jpg")
            
            do {
                try categoryPhotoData?.write(to: fileURL)
            } catch {
                print("Error writing to temporary url \(error.localizedDescription)")
            }
            return CKAsset(fileURL: fileURL)
        }
    }
    weak var category: Category?
    
    var recordID: CKRecord.ID
    var categoryReference: CKRecord.Reference? {
        guard let category = category else { return nil }
        return CKRecord.Reference(recordID: category.recordID, action: .deleteSelf)
    }
    
    init(categoryPhoto: UIImage, category: Category?, recordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)) {
        self.category = category
        self.recordID = recordID
        self.categoryPhoto = categoryPhoto
    }
    
}

extension CategoryPhoto {
    convenience init?(record: CKRecord, category: Category) {
        guard let categoryPhotoAsset = record[CategoryPhotoConstants.categoryPhotoKey] as? CKAsset else { return nil }
        
        guard let categoryPhotoData = try? Data(contentsOf: categoryPhotoAsset.fileURL!),
            // create a UIImage from data object above
            let photo = UIImage(data: categoryPhotoData) else { return nil }
        self.init(categoryPhoto: photo, category: category, recordID: record.recordID)
    }
}

extension CategoryPhoto: Equatable {
    static func == (lhs: CategoryPhoto, rhs: CategoryPhoto) -> Bool {
        return lhs.recordID == rhs.recordID
    }
    
}

extension CKRecord {
    convenience init(categoryPhoto: CategoryPhoto) {
        self.init(recordType: CategoryPhotoConstants.typeKey, recordID: categoryPhoto.recordID)
        self.setValue(categoryPhoto.categoryPhotoAsset, forKey: CategoryPhotoConstants.categoryPhotoKey)
        self.setValue(categoryPhoto.categoryReference, forKey: CategoryPhotoConstants.categoryReferenceKey)
    }
}

struct CategoryPhotoConstants {
    static let typeKey = "CategoryPhoto"
    fileprivate static let categoryPhotoKey = "categoryPhoto"
    fileprivate static let categoryReferenceKey = "categoryReference"
}
