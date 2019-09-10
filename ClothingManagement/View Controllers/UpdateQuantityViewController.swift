//
//  UpdateQuantityViewController.swift
//  ClothingManagement
//
//  Created by Julia Rodriguez on 9/9/19.
//  Copyright © 2019 Julia Rodriguez. All rights reserved.
//

import UIKit

// step 1 create protocol
protocol SaveButtonDelegate: class {
    func saveButtonTapped(_ sender: UpdateQuantityViewController)
}

class UpdateQuantityViewController: UIViewController {

    var category: Category?
    
    @IBOutlet weak var quantityTextField: UITextField!
    
    @IBOutlet weak var categoryNameLabel: UILabel!
    // step 2 create delegate variable
    weak var delegate: SaveButtonDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let category = category else { return }
        quantityTextField.text = "\(category.quantity)"
        categoryNameLabel.text = "Update Quantity of \(category.name)"

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        // call delegate function
        delegate?.saveButtonTapped(self)
        
        dismiss(animated: true)
    }
    
    @IBAction func tapGestureRecognizer(_ sender: UITapGestureRecognizer) {
        quantityTextField.resignFirstResponder()
        dismiss(animated: true)
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
