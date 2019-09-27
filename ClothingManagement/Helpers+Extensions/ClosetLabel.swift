//
//  closetLabel.swift
//  ClothingManagement
//
//  Created by Julia Rodriguez on 9/26/19.
//  Copyright © 2019 Julia Rodriguez. All rights reserved.
//

import UIKit

class ClosetLabel: UILabel {
    
    override func awakeFromNib() {
         super.awakeFromNib()
         setUpUI()
     }
     
     func setUpUI() {
         
         self.layer.masksToBounds = true
         self.textColor = UIColor.darkText
         overrideFont(with: "Trebuchet MS")
         //updateFont(with: FontNames.trebuchetMS)
         //overrideFont(with: "Avenir-Book")
    
     
     }
     
     
     func overrideFont(with fontName: String) {
         guard let size = self.font?.pointSize else { return }
         self.font = UIFont(name: fontName, size: size)!
     }
    
    func updateFont(with fontName: String) {
       // Trebuchet MS
           self.font = UIFont(name: fontName, size: 16)
       }
    
}
