//
//  User.swift
//  ClothingManagement
//
//  Created by Julia Rodriguez on 9/11/19.
//  Copyright © 2019 Julia Rodriguez. All rights reserved.
//

import Foundation
import CloudKit

class User {
    // Class properties
    var name: String?
    var closetName: String?
    var isMale: Bool?
    var closet: [Category]
    
    // CloudKit Properties
    var CKRecordID: CKRecord.ID
    var appleUserReference: CKRecord.Reference
    
    // Designated Initializer
    init(name: String, closetName: String, isMale: Bool, closet: [Category] = [], CKRecordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString), appleUserReference: CKRecord.Reference) {
        self.name = name
        self.closetName = closetName
        self.isMale = isMale
        self.closet = closet
        self.CKRecordID = CKRecordID
        self.appleUserReference = appleUserReference
    }
    
    // Initialize the user from the CKRecord
    convenience init?(record: CKRecord) {
        // cast as the original data types
        guard let name = record[UserConstants.nameKey] as? String,
            let closetName = record[UserConstants.closetNameKey] as? String,
            let isMale = record[UserConstants.isMaleKey] as? Bool,
            let appleUserReference = record[UserConstants.appleUserReferencyKey] as? CKRecord.Reference
        else { return nil }
        self.init(name: name, closetName: closetName, isMale: isMale, CKRecordID: record.recordID, appleUserReference: appleUserReference)
    }
}

// Initialize a CKRecord from an existing User 
extension CKRecord {
    
    convenience init(user: User) {
        self.init(recordType: UserConstants.typeKey, recordID: user.CKRecordID)
        self.setValue(user.name, forKey: UserConstants.nameKey)
        self.setValue(user.closetName, forKey: UserConstants.closetNameKey)
        self.setValue(user.isMale, forKey: UserConstants.isMaleKey)
        self.setValue(user.appleUserReference, forKey: UserConstants.appleUserReferencyKey)
    }
}

extension User: Equatable {
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.CKRecordID == rhs.CKRecordID
    }
}

struct UserConstants {
    static let typeKey = "User"
    fileprivate static let nameKey = "name"
    fileprivate static let closetNameKey = "closetName"
    fileprivate static let isMaleKey = "isMale"
    fileprivate static let appleUserReferencyKey = "appleUserReference"
    fileprivate static let sumOfClosetKey = "sumOfCloset"
}
