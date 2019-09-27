//
//  CategoryCollectionViewCell.swift
//  ClothingManagement
//
//  Created by Julia Rodriguez on 9/9/19.
//  Copyright © 2019 Julia Rodriguez. All rights reserved.
//

import UIKit

// func to run
protocol QuantityButtonDelegate: class {
    func quantityButtonTapped(_ sender: CategoryCollectionViewCell)
}

class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryLabel: ClosetLabel!
    
    @IBOutlet weak var quantityLabel: ClosetLabel!
    
    @IBOutlet weak var quantityButton: ClosetButton!
    
    @IBOutlet weak var iconImage: UIImageView!
    
    weak var cellDelegate: QuantityButtonDelegate?
    
    var category: Category?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateViews()
    }
    
    func updateViews() {
        guard let category = category else { return }
        quantityLabel.text = "\(category.quantity)"
        iconImage.image = category.iconImage
    }
    

    @IBAction func quantityButtonTapped(_ sender: Any) {
        // call the delegate method
        cellDelegate?.quantityButtonTapped(self)
    }
    
}
