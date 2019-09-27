//
//  Font.swift
//  ClothingManagement
//
//  Created by Julia Rodriguez on 9/26/19.
//  Copyright © 2019 Julia Rodriguez. All rights reserved.
//

import UIKit

class ClosetTextField: UITextField {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
    }
    
    func setUpUI() {
        self.overridePlaceHolderColor()
        self.addCornerRadius(10)
        self.layer.masksToBounds = true
        self.textColor = UIColor.darkText
        overrideFont(with: "Trebuchet MS")
        self.addBorder()
    
    }
    
    func overridePlaceHolderColor() {
        let currentPlaceHolderText = self.placeholder
        self.attributedPlaceholder = NSAttributedString(string: currentPlaceHolderText ?? "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font: UIFont(name: "Trebuchet MS", size: 16)!])
        
    }
    
    func overrideFont(with fontName: String) {
        guard let size = self.font?.pointSize else { return }
        self.font = UIFont(name: fontName, size: size)!
    }
}
