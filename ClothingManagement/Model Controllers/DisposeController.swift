//
//  DisposeController.swift
//  ClothingManagement
//
//  Created by Julia Rodriguez on 9/22/19.
//  Copyright © 2019 Julia Rodriguez. All rights reserved.
//

import Foundation

class DisposeController {
    
    static let shared = DisposeController()
    
    var totalDisposed: Int = 0
    
    // delete
    func subtractDisposeQuantity(disposeValue: Int, category: Category) {
       
        let oldValue = category.quantity
        let newValue = oldValue - disposeValue
        category.quantity = newValue
        
        CategoryController.shared.updateCategory(category: category) { (success) in
            print("\(category.name) was updated successfully with new quantity of: \(category.quantity)")
        }
        
    }
    // update
    func updateTotalItemsDisposed(disposeNum: Int) {
        totalDisposed += disposeNum
        print(totalDisposed)
    }
    
    
}
