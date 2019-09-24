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
                let stringIsDonated = "donated"
                return stringIsDonated
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
        self.placeLabel.text = contribution.place
        self.typeLabel.text = "Type: " + isDonated
        self.quantityLabel.text = "\(contribution.diposedAmount) items " + isDonated
        self.receiptLabel.text = "Receipt on file: " + receeiptIncluded
        self.imageIcon.image = UIImage(named: imageName)
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
