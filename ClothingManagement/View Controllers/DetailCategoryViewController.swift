//
//  DetailCategoryViewController.swift
//  ClothingManagement
//
//  Created by Julia Rodriguez on 9/10/19.
//  Copyright © 2019 Julia Rodriguez. All rights reserved.
//

import UIKit

class DetailCategoryViewController: UIViewController {

    var category: Category?
    
    
    @IBOutlet weak var quantityOfCategoryLabel: UILabel!
    
    @IBOutlet weak var updateQuantityButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func updateQuantityButtonTapped(_ sender: UIButton) {
        // perform segue
        performSegue(withIdentifier: "toUpdateQuantityVC", sender: self)
    }
    
    @IBAction func addPhotoButtonTapped(_ sender: UIBarButtonItem) {
    }
    
    func updateViews() {
        guard let category = category else { return }
        quantityOfCategoryLabel.text = "\(category.quantity)"
        updateQuantityButton.setTitle("Update Quantity for \(category.name) ", for: .normal)
        navigationItem.title = category.name
        navigationItem.largeTitleDisplayMode = .always
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toUpdateQuantityVC" {
            guard let category = category,
                let destinationVC = segue.destination as? UpdateQuantityViewController else { return }
            destinationVC.category = category
            // access to viewcontroller where delegate is initialized/created, assign delegate to self
            destinationVC.delegate = self 
        }
    }
}

extension DetailCategoryViewController: SaveButtonDelegate {
    func saveButtonTapped(_ sender: UpdateQuantityViewController) {
        let category = sender.category
        guard let newQuantity = sender.quantityTextField.text,
            let intValue = Int(newQuantity)
            else { return }
        category?.quantity = intValue
        updateViews()
    }
    
    
}
