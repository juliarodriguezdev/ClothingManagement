//
//  Contribution.swift
//  ClothingManagement
//
//  Created by Julia Rodriguez on 9/22/19.
//  Copyright © 2019 Julia Rodriguez. All rights reserved.
//

import UIKit
import CloudKit

class Contribution {
    
    var place: String
    var isDonation: Bool
    var diposedAmount: Int
    var timestamp: Date
    
    var recordID: CKRecord.ID
    // link this class back to the user model object class
    weak var user: User?
    var receiptImageData: Data?
    var receiptImage: UIImage? {
        get {
            guard let receiptImageData = receiptImageData else { return nil }
            return UIImage(data: receiptImageData)
        } set {
            receiptImageData = newValue?.jpegData(compressionQuality: 0.5)
        }
    }
    var receiptImageAsset: CKAsset? {
        get {
            let tempDictionary = NSTemporaryDirectory()
            let tempDictionaryURL = URL(fileURLWithPath: tempDictionary)
            let fileURL = tempDictionaryURL.appendingPathComponent(UUID().uuidString).appendingPathExtension("jpg")
            do {
                var data: Data?
                if let imageData = receiptImageData {
                    data = imageData
                } else {
                    data = (UIImage(named: "receiptDefault")?.jpegData(compressionQuality: 0.1))!
                }
                try data?.write(to: fileURL)
            } catch {
                print("Error writing to temporay url \(error.localizedDescription)")
                return nil
            }
            return CKAsset(fileURL: fileURL)
        }
    }
    // object reference to the user, computed property
    var userReference: CKRecord.Reference? {
        guard let user = user else { return nil }
        // after return what gets assigned to the computed property
        return CKRecord.Reference(recordID: user.CKRecordID, action: .deleteSelf)
    }
    // MARK: - Designated Initializers for class
    init(place: String, isDonation: Bool, disposedAmount: Int, timestamp: Date = Date(), user: User?, recordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)) {
        self.place = place
        self.isDonation = isDonation
        self.diposedAmount = disposedAmount
        self.timestamp = timestamp
        self.user = user
        self.recordID = recordID
    }
    
    // falliable intializers (cloud -> device)
        
    init?(record: CKRecord, user: User) {
        guard let place = record[ContributionConstants.placeKey] as? String,
            let isDonation = record[ContributionConstants.isDonationKey] as? Bool,
            let disposedAmount = record[ContributionConstants.disposedAmountKey] as? Int,
        let timestamp = record[ContributionConstants.timestampKey] as? Date
            else { return nil }
        
        self.place = place
        self.isDonation = isDonation
        self.diposedAmount = disposedAmount
        self.timestamp = timestamp
        self.user = user
        self.recordID = record.recordID
        
        if let receiptImageAsset = record[ContributionConstants.receiptImageKey] as? CKAsset,
            let receiptImageData = try? Data(contentsOf: receiptImageAsset.fileURL!) {
            
            let image = UIImage(data: receiptImageData)
            self.receiptImage = image
        }
    }
}
extension CKRecord {
    convenience init(contribution: Contribution) {
        self.init(recordType: ContributionConstants.typeKey, recordID: contribution.recordID)
        self.setValue(contribution.place, forKey: ContributionConstants.placeKey)
        self.setValue(contribution.isDonation, forKey: ContributionConstants.isDonationKey)
        self.setValue(contribution.diposedAmount, forKey: ContributionConstants.disposedAmountKey)
        self.setValue(contribution.timestamp, forKey: ContributionConstants.timestampKey)
        self.setValue(contribution.userReference, forKey: ContributionConstants.userReferenceKey)
        if let receiptImageAsset = contribution.receiptImageAsset {
            self.setValue(receiptImageAsset, forKey: ContributionConstants.receiptImageKey)
        }
    }
}


extension Contribution: Equatable {
    static func == (lhs: Contribution, rhs: Contribution) -> Bool {
        return lhs.recordID == rhs.recordID
    }
    
    
}

struct ContributionConstants {
    static let typeKey = "Contribution"
    static let userReferenceKey = "userReference"
    fileprivate static let placeKey = "place"
    fileprivate static let isDonationKey = "isDonation"
    fileprivate static let disposedAmountKey = "disposedAmount"
    fileprivate static let timestampKey = "timestamp"
    fileprivate static let receiptImageKey = "receiptImage"
}
