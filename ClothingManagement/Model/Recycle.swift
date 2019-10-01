//
//  Donate.swift
//  ClothingManagement
//
//  Created by Julia Rodriguez on 9/18/19.
//  Copyright © 2019 Julia Rodriguez. All rights reserved.
//

import UIKit

class Recycle {
    var storeName: String
    var initiative: String?
    var logoImage: UIImage
    var webURL: String
    var category: RecycleType
    
    init(storeName: String, initiative: String, logoImage: UIImage, webURL: String, category: RecycleType) {
        self.storeName = storeName
        self.initiative = initiative
        self.logoImage = logoImage
        self.webURL = webURL
        self.category = category
    }
}
// initialize an enum
enum RecycleType: String {
    case denim
    case clothes
    case shoes
    case clothesAndShoes
    case bras
    case career
    case wedding
    case prom 
    
    // falliable init
}
