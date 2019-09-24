//
//  FunFactsViewController.swift
//  ClothingManagement
//
//  Created by Julia Rodriguez on 9/10/19.
//  Copyright © 2019 Julia Rodriguez. All rights reserved.
//

import UIKit

class FunFactsViewController: UIViewController {

    @IBOutlet weak var factsLabel: UILabel!
    
    @IBOutlet weak var sourceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Fun Facts"
        navigationItem.largeTitleDisplayMode = .always
        ClothingFactController.shared.loadClothingFacts()
        let facts = ClothingFactController.shared.clothingFacts
        if let oneFact = facts.randomElement() {
            self.factsLabel.text = oneFact.fact
            self.sourceLabel.text = oneFact.source
        }
        
    }
    
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        let facts = ClothingFactController.shared.clothingFacts
        if let oneFact = facts.randomElement() {
            self.factsLabel.text = oneFact.fact
            print(oneFact.fact)
            self.sourceLabel.text = oneFact.source
            print(oneFact.source)
        }
       
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
