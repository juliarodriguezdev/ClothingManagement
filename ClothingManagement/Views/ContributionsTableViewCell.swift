//
//  ContributionsTableViewCell.swift
//  ClothingManagement
//
//  Created by Julia Rodriguez on 9/23/19.
//  Copyright © 2019 Julia Rodriguez. All rights reserved.
//

import UIKit

class ContributionsTableViewCell: UITableViewCell {
    
    var contribution: Contribution?
    
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var receiptLabel: UILabel!
    @IBOutlet weak var imageIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //updateViews()
    }
    func updateViews() {
        guard let contribution = contribution else { return }
        
        var isDonated: String {
            if contribution.isDonation {
                let stringIsDonated = "Donatation"
                return stringIsDonated
            } else {
                return "Recycle"
            }
        }
        var contributionDescription: String {
            if contribution.isDonation {
                let donation = "donated"
                return donation
            } else {
                return "recycled"
            }
        }
        var receeiptIncluded: String {
            if (contribution.receiptImage != nil) {
                return "yes"
            } else {
                return "no"
            }
        }
        var imageName: String {
            if contribution.isDonation {
                return "donate"
            } else {
                return "clothesRecycle"
            }
        }
        
        var recieptCheck: String {
            if contribution.receiptImage == UIImage(named: "receiptDefault") {
                return "No"
            } else {
                return "Yes"
            }
        }
        self.placeLabel.text = contribution.place
        self.typeLabel.text = "Type: " + isDonated
        self.quantityLabel.text = "\(contribution.diposedAmount) items " + contributionDescription + " here"
        self.timestampLabel.text = contribution.timestamp.formatDate()
        self.receiptLabel.text = "Receipt on file: " + recieptCheck
        self.imageIcon.image = UIImage(named: imageName)
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
