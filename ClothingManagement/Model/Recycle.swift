//
//  Donate.swift
//  ClothingManagement
//
//  Created by Julia Rodriguez on 9/18/19.
//  Copyright © 2019 Julia Rodriguez. All rights reserved.
//

import Foundation

class Recycle {
    var storeName: String
    var initiative: String?
    var webURL: String
    var category: RecycleType
    
    init(storeName: String, initiative: String, webURL: String, category: RecycleType) {
        self.storeName = storeName
        self.initiative = initiative
        self.webURL = webURL
        self.category = category
    }
}

enum RecycleType: String {
    case denim
    case clothes
    case shoes
    case clothesAndShoes
    case bras
    
}
