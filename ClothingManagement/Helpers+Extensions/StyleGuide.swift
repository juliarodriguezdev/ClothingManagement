//
//  StyleGuide.swift
//  ClothingManagement
//
//  Created by Julia Rodriguez on 9/26/19.
//  Copyright © 2019 Julia Rodriguez. All rights reserved.
//

import UIKit

extension UIView {
    func addCornerRadius(_ radius: CGFloat = 4) {
        self.layer.cornerRadius = radius
    }
    func addBorder(width: CGFloat = 1, color: UIColor = UIColor.darkGray) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
}

struct FontNames {
    static let trebuchetMS = "Trebuchet MS"
}

extension UIColor {
    static let neutralPrimary = UIColor(named: "neutralPrimary")
    static let neutralSecondary = UIColor(named: "neutralSecondary")
    static let neutralAccent = UIColor(named: "neutralAccent")
    static let malePrimary = UIColor(named: "malePrimary")
    static let maleSecondary = UIColor(named: "maleSecondary")
    static let maleAccent = UIColor(named: "maleAccent")
    static let femalePrimary = UIColor(named: "femalePrimary")
    static let femaleSecondary = UIColor(named: "femaleSeconday")
    static let femaleAccent = UIColor(named: "femaleSeconday")




}
