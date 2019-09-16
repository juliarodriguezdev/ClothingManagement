//
//  UserController.swift
//  ClothingManagement
//
//  Created by Julia Rodriguez on 9/10/19.
//  Copyright © 2019 Julia Rodriguez. All rights reserved.
//

import Foundation
import CloudKit

class UserController {
    
    // shared instance
    static let shared = UserController()
    
    // source of truth
    var currentUser: User?

    
    // database
    let publicDB = CloudKitController.shared.publicDB
    
    // CRUD Functions
    
    // Create
    func createUserWith(userName: String, closetName: String, isMale: Bool, sumOfCloset: Int = 0, completion: @escaping (User?) -> Void) {
        
        CloudKitController.shared.fetchAppleUserReference { (reference) in
            guard let appleUserRefrence = reference else { completion(nil); return }
            let newUser = User(name: userName, closetName: closetName, isMale: isMale, appleUserReference: appleUserRefrence)
            let userRecord = CKRecord(user: newUser)
            CloudKitController.shared.save(record: userRecord, database: CloudKitController.shared.publicDB, completion: { (record) in
                guard let record = record,
                      let user = User(record: record)
                    else { completion(nil); return }
                self.currentUser = user
                completion(user)
            })
        }
    }
    
   
    func fetchUser(completion: @escaping(Bool) -> Void) {
        CloudKitController.shared.fetchAppleUserReference { (reference) in
            guard let appleUserReference = reference else { completion(false); return }
            
            let predicate = NSPredicate(format: "appleUserReference == %@", appleUserReference)
            CloudKitController.shared.fetchSingleRecord(ofType: UserConstants.typeKey, withPredicate: predicate, database: CloudKitController.shared.publicDB, completion: { (record) in
                guard let record = record,
                    let firstRecord = record.first else { completion (false); return}
                    self.currentUser = User(record: firstRecord)
                    completion(true)
            })
        }
    }
    
    // Update
    func updateUserInfo(user: User, completion: @escaping (Bool) -> Void) {
        let recordToSave = CKRecord(user: user)
        let database = self.publicDB
        
        CloudKitController.shared.update(record: recordToSave, database: database) { (success) in
            if success {
                print("User's info updated successfully ")
                completion(true)
            } else {
                print("User info failed to update")
                completion(false)
            }
        }
    }
    
    // Delete
    func deleteUser(user: User, completion: @escaping (Bool) -> Void) {
        CloudKitController.shared.delete(recordID: user.CKRecordID, database: self.publicDB) { (success) in
            self.currentUser = nil
            completion(success ? true : false)
        }
    }
}
