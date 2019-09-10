//
//  Category.swift
//  ClothingManagement
//
//  Created by Julia Rodriguez on 9/9/19.
//  Copyright © 2019 Julia Rodriguez. All rights reserved.
//

import Foundation

class Category {
    
    var name: String
    var quantity: Int
    var photos: [String]?
    
    init(name: String, quantity: Int, photos: [String]?) {
        
        self.name = name
        self.quantity = quantity
        self.photos = photos
    }
}
