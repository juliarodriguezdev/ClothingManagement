//
//  TabBarController.swift
//  ClothingManagement
//
//  Created by Julia Rodriguez on 10/1/19.
//  Copyright © 2019 Julia Rodriguez. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    var user = UserController.shared.currentUser

    override func viewDidLoad() {
        super.viewDidLoad()
        checkGenderForUIColor(user: user)
        
    }
    
    func checkGenderForUIColor(user: User?) {
           
           if user?.isMale == true {
             UITabBar.appearance().tintColor = UIColor.maleAccent
             self.tabBar.barTintColor = UIColor.malePrimary
           } else if user?.isMale == false {
            UITabBar.appearance().tintColor = UIColor.femaleAccent
            self.tabBar.barTintColor = UIColor.femalePrimary
           } else {
            UITabBar.appearance().tintColor = UIColor.neutralAccent
            self.tabBar.barTintColor = UIColor.neutralPrimary
                              
           }
       }

}

