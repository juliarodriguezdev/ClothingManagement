//
//  DonateTableViewCell.swift
//  ClothingManagement
//
//  Created by Julia Rodriguez on 9/18/19.
//  Copyright © 2019 Julia Rodriguez. All rights reserved.
//

import UIKit

class RecycleTableViewCell: UITableViewCell {

    @IBOutlet weak var storeNameLabel: UILabel!
    
    @IBOutlet weak var initiativeNameLabel: UILabel!
    
    @IBOutlet weak var storeImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       // webView.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
