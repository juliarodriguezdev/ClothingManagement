//
//  ContributionController.swift
//  ClothingManagement
//
//  Created by Julia Rodriguez on 9/23/19.
//  Copyright © 2019 Julia Rodriguez. All rights reserved.
//

import UIKit
import CloudKit

class ContributionController {
    
    static let shared = ContributionController()
    
    var contributions: [Contribution] = []
    
    let publicDB = CKContainer.default().publicCloudDatabase
    
    // CRUD
    
    // Create
    
    func createContribution(withName place: String, isDonated: Bool, disposedAmount: Int, user: User, completion: @escaping (Contribution?) -> Void ) {
        // create an object from class properties
        let contribution = Contribution(place: place, isDonation: isDonated, disposedAmount: disposedAmount, user: user)
        // create a CKRecord from class object
        let record = CKRecord(contribution: contribution)
        
        CloudKitController.shared.publicDB.save(record) { (record, error) in
            if let error = error {
                print("Error in \(#function): \(error.localizedDescription) /n---/n \(error)")
                // TODO: check if we need a completion
//                completion(nil)
//                return
            }
            guard let record = record,
                // create a record/category from the cloud (CKDatabase)
                let contribution = Contribution(record: record, user: user) else {
                    completion(nil); return }
            print("\(#function) contribution saved!")
            self.contributions.append(contribution)
            completion(contribution)
        }
    }
    
    // Read
    func fetchContributions(user: User, completion: @escaping ([Contribution]?) -> Void) {
       // reference the user
        let userReference = user.CKRecordID
        let userReferencePredicate = NSPredicate(format: "%K == %@", ContributionConstants.userReferenceKey, userReference)
        let contributionIDs = user.contributions.compactMap( {$0.recordID})
        let avoidDuplicatePredicate = NSPredicate(format: "Not(recordID in %@)", contributionIDs)
        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [userReferencePredicate, avoidDuplicatePredicate])
        let query = CKQuery(recordType: ContributionConstants.typeKey, predicate: compoundPredicate)
        CloudKitController.shared.publicDB.perform(query, inZoneWith: nil) { (record, error) in
            if let error = error {
                print("Error in \(#function): \(error.localizedDescription) /n---/n \(error)")
                completion(nil)
                return
            }
            guard let record = record else { completion(nil); return }
            let contributions = record.compactMap{ Contribution(record: $0, user: user)}
            self.contributions = contributions
            completion(contributions)
        }
        
    }
    
    // Update
    func updateContribution(contribution: Contribution, completion: @escaping (Bool) -> Void) {
        let recordToSave = CKRecord(contribution: contribution)
        let database = self.publicDB
        
        CloudKitController.shared.update(record: recordToSave, database: database) { (success) in
            if success {
                print("Contribution updated successfully")
                completion(true)
            } else {
                print("Category failed to update")
                completion(false)
                return
            }
        }
    }
    
    // Delete
    func deleteContribution(contribution: Contribution, completion: @escaping (Bool) -> Void) {
        guard let index = contributions.firstIndex(of: contribution) else { return }
            contributions.remove(at: index)
        CloudKitController.shared.delete(recordID: contribution.recordID, database: CloudKitController.shared.publicDB) { (success) in
            completion(success ? true: false)
        }
    }
}
