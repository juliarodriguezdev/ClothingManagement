//
//  NavigationViewController.swift
//  ClothingManagement
//
//  Created by Julia Rodriguez on 10/1/19.
//  Copyright © 2019 Julia Rodriguez. All rights reserved.
//

import UIKit

class NavigationViewController: UINavigationController {

    var user = UserController.shared.currentUser
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkGenderForUIColor(user: user)
        
        // Do any additional setup after loading the view.
    }
    func checkGenderForUIColor(user: User?) {
        
        if user?.isMale == true {
            
            navigationController?.navigationBar.barTintColor = UIColor.malePrimary
            UINavigationBar.appearance().tintColor = UIColor.maleAccent
            
        } else if user?.isMale == false {
            navigationController?.navigationBar.barTintColor = UIColor.femalePrimary
            UINavigationBar.appearance().tintColor = UIColor.femaleAccent
        } else {
            navigationController?.navigationBar.barTintColor = UIColor.neutralPrimary
            UINavigationBar.appearance().tintColor = UIColor.neutralAccent
        }
    }
    
}
