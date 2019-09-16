//
//  CloudKitController.swift
//  ClothingManagement
//
//  Created by Julia Rodriguez on 9/11/19.
//  Copyright © 2019 Julia Rodriguez. All rights reserved.
//

import Foundation
import CloudKit

class CloudKitController {
    
    static let shared = CloudKitController()
    
    let publicDB = CKContainer.default().publicCloudDatabase
    
    // MARK: CRUD
    
    // Save record
    func save(record: CKRecord, database: CKDatabase, completion: @escaping (CKRecord?) -> Void) {
        database.save(record) { (record, error) in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) /n---/n \(error)")
                completion(nil)
            }
            print(#function)
            completion(record)
        }
    }
    
    // Read
    
    func fetchAppleUserReference(completion: @escaping (CKRecord.Reference?) -> Void) {
        CKContainer.default().fetchUserRecordID { (appleUserReferenceID, error) in
            if let error = error {
                print("There was an error \(#function) : \(error.localizedDescription) /n---/n \(error)")
                completion(nil)
                return
            }
            guard let referenceID = appleUserReferenceID else { completion(nil); return }
            let appleUserReference = CKRecord.Reference(recordID: referenceID, action: .deleteSelf)
            completion(appleUserReference)
        }
    }
    
    func fetchSingleRecord(ofType type: String, withPredicate predicate: NSPredicate, database: CKDatabase, completion: @escaping ([CKRecord]?) -> Void) {
        
        let query = CKQuery(recordType: type, predicate: predicate)
        database.perform(query, inZoneWith: nil) { (record, error) in
            if let error = error {
                print("There was an error in \(#function) : \(error.localizedDescription) /n---/n \(error)")
                completion(nil)
            }
            guard let record = record else { completion(nil); return}
            completion(record)
        }
    }
    
    
    // Update
    func update(record: CKRecord, database: CKDatabase, completion: @escaping (Bool) -> Void) {
        let operation = CKModifyRecordsOperation()
        operation.recordsToSave = [record]
        operation.savePolicy = .changedKeys
        operation.qualityOfService = .userInteractive
        operation.queuePriority = .high
        operation.completionBlock = {
            completion(true)
        }
        database.add(operation)
    }
    
    // Delete
    func delete(recordID: CKRecord.ID, database: CKDatabase, completion: @escaping (Bool) -> Void) {
        database.delete(withRecordID: recordID) { (_, error) in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) /n---/n \(error)")
                completion(false)
            }
            completion(true)
        }
    }
}
