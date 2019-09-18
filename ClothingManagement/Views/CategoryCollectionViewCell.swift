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
    
    @IBOutlet weak var iconImage: UIImageView!
    
    weak var cellDelegate: QuantityButtonDelegate?
    
    var category: Category?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        guard let category = category else { return }
//        let predicate = NSPredicate(format: "categoryReference == %@", category.recordID)
//        let compPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate])
        
//        CategoryPhotoController.shared.fetchIconPhotoForCategory(category: category, prediicate: compPredicate) { (iconPhoto) in
//            if iconPhoto != nil {
//                category.iconPhoto = iconPhoto
//
//            }
//        }
        
    }
    
    func updateViews() {
        guard let category = category else { return }
        quantityLabel.text = "\(category.quantity)"
        iconImage.image = category.iconImage
//        CategoryPhotoController.shared.saveIconPhoto(photo: iconPhoto, category: category) { (iconPhoto) in
//            if iconPhoto != nil {
//                print("Icon saved for \(category.name)")
//            }
//        }
    }
    

    @IBAction func quantityButtonTapped(_ sender: Any) {
        // call the delegate method
        cellDelegate?.quantityButtonTapped(self)
    }
    
}
