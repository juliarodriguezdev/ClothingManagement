//
//  LocalDonationTableViewCell.swift
//  ClothingManagement
//
//  Created by Julia Rodriguez on 9/20/19.
//  Copyright © 2019 Julia Rodriguez. All rights reserved.
//

import UIKit

class LocalDonationTableViewCell: UITableViewCell {
    
    var localDonation: LocalDonation? 
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var isOpenLabel: UILabel!
    
    @IBOutlet weak var reviewCountLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var distanceLabel: UILabel!
    
    @IBOutlet weak var phoneButton: UIButton!
    
    @IBOutlet weak var donationImage: UIImageView!
    
    func updateViews() {
        guard let localDonation = localDonation else { return }
        
        self.nameLabel.text = localDonation.name
        self.isOpenLabel.text = "\(localDonation.isOpen)"
        self.reviewCountLabel.text = "\(localDonation.reviewCount)"
        self.distanceLabel.text = "\(localDonation.distance)"
        self.phoneButton.setTitle(localDonation.displayPhone, for: .normal)
        
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
    
    

}
