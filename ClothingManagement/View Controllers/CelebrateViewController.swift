//
//  CelebrateViewController.swift
//  ClothingManagement
//
//  Created by Julia Rodriguez on 9/27/19.
//  Copyright © 2019 Julia Rodriguez. All rights reserved.
//

import UIKit

class CelebrateViewController: UIViewController {
    // landing pad
    var user: User?
    
    @IBOutlet weak var celebrateLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        celebrateLabel.alpha = 0
        // Do any additional setup after loading the view.
    }
    // TODO: animate label, to disapear
    
    // TODO: once animated label is complete, then dismiss the view controller.
    
    // TODO: test to see where VC goes, after being dimissed
    
}
