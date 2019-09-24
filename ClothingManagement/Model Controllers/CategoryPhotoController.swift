//
//  CategoryPhotoController.swift
//  ClothingManagement
//
//  Created by Julia Rodriguez on 9/16/19.
//  Copyright © 2019 Julia Rodriguez. All rights reserved.
//

import UIKit
import CloudKit

class CategoryPhotoController {
    
    static let shared = CategoryPhotoController()
        
    let publicDB = CloudKitController.shared.publicDB
    
    // CRUD Funcs
    
    // Create
    
    func createCategoryPhoto(photo: UIImage, category: Category, completion: @escaping (CategoryPhoto?) -> Void) {
        
        let categoryPhoto = CategoryPhoto(categoryPhoto: photo, category: category)
        let record = CKRecord(categoryPhoto: categoryPhoto)
        let database = self.publicDB
        
        CloudKitController.shared.save(record: record, database: database) { (record) in
            if let record = record {
                // save a CKRecord
                guard let savedPhoto = CategoryPhoto(record: record, category: category) else { completion(nil) ; return }
                //category.categoryPhotos.append(savedPhoto)
                completion(savedPhoto)
            } else {
                completion(nil)
                return
            }
        }
    }
    
    
    // Read
    
    func fetchCategoryPhotos(category: Category, predicate: NSCompoundPredicate, completion: @escaping ([CategoryPhoto]?) -> Void) {
        CloudKitController.shared.fetchRecords(ofType: CategoryPhotoConstants.typeKey, withPredicate: predicate, database: self.publicDB) { (foundRecords) in
            guard let foundRecords = foundRecords else { completion(nil) ; return }
            let fetchedPhotos = foundRecords.compactMap({ CategoryPhoto(record: $0, category: category)})
            //category.categoryPhotos = fetchedPhotos
            completion(fetchedPhotos)
        }
    }
    // TODO: single fetch for icon
    
    
    // Delete
    
    func deleteCategoryPhoto(categoryPhoto: CategoryPhoto, category: Category, completion: @escaping (Bool) -> Void) {
        
        guard let index = category.categoryPhotos.firstIndex(of: categoryPhoto) else { completion(false); return}
        category.categoryPhotos.remove(at: index)
        
        let database = self.publicDB
        
        CloudKitController.shared.delete(recordID: categoryPhoto.recordID, database: database) { (success) in
            // if success == true, the completion (true) else completion(false) 
            completion(success ? true : false )
        }
        
    }
}
