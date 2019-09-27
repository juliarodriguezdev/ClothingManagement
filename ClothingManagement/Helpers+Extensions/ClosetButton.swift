//
//  ClosetButton.swift
//  ClothingManagement
//
//  Created by Julia Rodriguez on 9/27/19.
//  Copyright © 2019 Julia Rodriguez. All rights reserved.
//

import UIKit

class ClosetButton: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        setUPUI()
    }
    
    func updateFont(to fontName: String) {
        guard let size = self.titleLabel?.font.pointSize else { return }
        self.titleLabel?.font = UIFont(name: fontName, size: size)!
    }
    
    func setUPUI() {
        updateFont(to: FontNames.trebuchetMS)
        self.setTitleColor(.white, for: .normal)
        self.addCornerRadius(20)
    }
}
