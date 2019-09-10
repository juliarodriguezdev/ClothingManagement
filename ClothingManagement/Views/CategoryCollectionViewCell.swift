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
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var quantityLabel: UILabel!
    
    @IBOutlet weak var quantityButton: UIButton!
    
    weak var cellDelegate: QuantityButtonDelegate?
    
    var category: Category?
    
    func updateViews() {
        guard let category = category else { return }
        quantityLabel.text = "\(category.quantity)"
    }
    

    @IBAction func quantityButtonTapped(_ sender: Any) {
        // call the delegate method
        cellDelegate?.quantityButtonTapped(self)
    }
    
}
