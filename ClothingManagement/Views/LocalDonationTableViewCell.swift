//
//  LocalDonationTableViewCell.swift
//  ClothingManagement
//
//  Created by Julia Rodriguez on 9/20/19.
//  Copyright © 2019 Julia Rodriguez. All rights reserved.
//

import UIKit

protocol LocalDonationDelegate: class {
    func navigateToYelp(for cell: LocalDonationTableViewCell)
}

class LocalDonationTableViewCell: UITableViewCell {
    
    var localDonation: LocalDonation?
    weak var delegate: LocalDonationDelegate?
    
    @IBOutlet weak var nameLabel: ClosetLabel!
    
    @IBOutlet weak var isOpenLabel: ClosetLabel!
    
    @IBOutlet weak var reviewCountLabel: ClosetLabel!
    
    @IBOutlet weak var ratingImage: UIImageView!
    
    @IBOutlet weak var locationLabel: ClosetLabel!
    
    @IBOutlet weak var location2Label: ClosetLabel!
    
    @IBOutlet weak var distanceLabel: ClosetLabel!
    
    @IBOutlet weak var phoneButton: ClosetButton!
    
    @IBOutlet weak var donationImage: UIImageView!
    
    func updateViews() {
        guard let localDonation = localDonation else { return }
        
        var isClosed : String {
            if let isClosed = localDonation.isClosed {
                if isClosed == true {
                    let stringClosed = "Closed"
                    return stringClosed
                } else if isClosed == false {
                    let stringOpen = "Open now"
                    return stringOpen
                }
            }
            return "--"
        }
        isOpenLabel.text = isClosed
        isOpenLabel.textColor = isClosed == "Closed" ? .systemRed : UIColor(named: "customGreen")
        
        var distanceFrom: String {
            if let distance = localDonation.distance {
                let distanceInMiles = distance/1609.344
                let formattedDistance = String(format: "%.2f", distanceInMiles)
                return formattedDistance
            } else {
                return "--"
            }
        }
            
        var address1: String {
                if let displayAddress = localDonation.location.displayAddress {
                    let part1 = displayAddress[0]
                    let stringaddress1 = part1
                    print(stringaddress1)
                    return stringaddress1
                } else {
                    return "--"
                }
            }
        
        var address2: String {
            if let displayAddress = localDonation.location.displayAddress {
                let part2 = displayAddress[1]
                let stringaddress2 = part2
                print(stringaddress2)
                return stringaddress2
                
            } else {
                return "--"
            }
        }
        
        var phoneNumber: String {
            if let displayPhone = localDonation.displayPhone, !displayPhone.isEmpty {
                let phone = displayPhone
                return phone
            } else {
                self.phoneButton.alpha = 0
                self.phoneButton.isHidden = true 
                return "No phone number"
            }
        }
        
        var ratingImage: UIImage? {
            switch localDonation.rating {
            case 0:
                return UIImage(named: "regular_0")
            case 1:
                return UIImage(named: "regular_1")
            case 1.5:
                return UIImage(named: "regular_1_half")
            case 2.0:
                return UIImage(named: "regular_2")
            case 2.5:
                return UIImage(named: "regular_2_half")
            case 3.0:
                return UIImage(named: "regular_3")
            case 3.5:
                return UIImage(named: "regular_3_half")
            case 4.0:
                return UIImage(named: "regular_4")
            case 4.5:
                return UIImage(named: "regular_4_half")
            case 5.0:
                return UIImage(named: "regular_5")
            default:
                return UIImage(named: "regular_0")
            }
        }
        
        self.nameLabel.text = localDonation.name
        self.reviewCountLabel.text = "\(localDonation.reviewCount) Reviews"
        self.ratingImage.image = ratingImage
        self.locationLabel.text = address1
        self.location2Label.text = address2
        self.distanceLabel.text = distanceFrom + " miles away"
        self.phoneButton.setTitle(phoneNumber, for: .normal)
        
        
        LocalDonationController.shared.fetchDonationPlacesImage(imageURL: localDonation.imageURL) { (image) in
            DispatchQueue.main.async {
                self.donationImage.image = image
            }
        }

    }
    @IBAction func phoneNumberTapped(_ sender: UIButton) {
        guard let localDonation = localDonation else { return }
        
        
        if let phoneURL = URL(string: "tel:\(localDonation.phoneNumber!)") {
            UIApplication.shared.canOpenURL(phoneURL)
            UIApplication.shared.open(phoneURL) { (success) in
                if success {
                    print("sent to phone ")
                }
            }
        }
    }
    
    @IBAction func yelpButtonTapped(_ sender: Any) {
        delegate?.navigateToYelp(for: self)
    }
    

}
