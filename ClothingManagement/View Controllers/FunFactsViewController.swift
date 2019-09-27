//
//  FunFactsViewController.swift
//  ClothingManagement
//
//  Created by Julia Rodriguez on 9/10/19.
//  Copyright © 2019 Julia Rodriguez. All rights reserved.
//

import UIKit

class FunFactsViewController: UIViewController {

    @IBOutlet weak var factsLabel: ClosetLabel!
    
    @IBOutlet weak var sourceLabel: ClosetLabel!
    
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
    
    @IBAction func infoButtonTapped(_ sender: UIButton) {
        presentUIHelperAlert(title: "Information", message: "Tap anywhere to generate a new textile fact.")
        
    }
    func presentUIHelperAlert(title: String, message: String) {
           
           let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
           
           let okayAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
           
           alertController.addAction(okayAction)
           self.present(alertController, animated: true)
       }
    
}
