//
//  LocalDonationTableViewCell.swift
//  ClothingManagement
//
//  Created by Julia Rodriguez on 9/20/19.
//  Copyright © 2019 Julia Rodriguez. All rights reserved.
//

import UIKit

class LocalDonationTableViewCell: UITableViewCell {
    
    //var localDonation: LocalDonation?
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var isOpenLabel: UILabel!
    
    @IBOutlet weak var reviewCountLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var distanceLabel: UILabel!
    
    @IBOutlet weak var phoneButton: UIButton!
    
    @IBOutlet weak var donationImage: UIImageView!
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
