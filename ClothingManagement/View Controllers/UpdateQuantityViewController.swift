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
    var user: User?
    
    @IBOutlet weak var quantityTextField: ClosetTextField!
    
    @IBOutlet weak var categoryNameLabel: ClosetLabel!
    
    @IBOutlet weak var addButton: ClosetButton!
    
    @IBOutlet weak var subtractButton: ClosetButton!
    
    
        
    // step 2 create delegate variable
    weak var delegate: SaveButtonDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let category = category,
            let user = user else { return }
        checkGenderForUIColor(user: user)
        quantityTextField.text = "\(category.quantity)"
        categoryNameLabel.text = "Update Quantity of \(category.name)"
        

        // Do any additional setup after loading the view.
    }
    func checkGenderForUIColor(user: User) {
        
        switch user.isMale {
        case true:
            quantityTextField.backgroundColor = UIColor.malePrimary
            addButton.backgroundColor = UIColor.maleSecondary
            subtractButton.backgroundColor = UIColor.maleSecondary
            self.view.backgroundColor = UIColor.malePrimary
        case false:
            quantityTextField.backgroundColor = UIColor.femalePrimary
            addButton.backgroundColor = UIColor.femaleSecondary
            subtractButton.backgroundColor = UIColor.femaleSecondary
            self.view.backgroundColor = UIColor.femalePrimary
        }
    }
    
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let category = category,
        let changedValue = quantityTextField.text,
        let changedIntValue = Int(changedValue)
            else { return }
        
        if changedIntValue >= 0 {
             category.quantity = changedIntValue
            CategoryController.shared.updateCategory(category: category) { (success) in
                if success {
                    // TODO: Add Saving Wheel Indicator
                    print("Quantity in category saved successfully")
                    DispatchQueue.main.async {
                        self.dismiss(animated: true)
                    }
                }
            }
            
        } else if changedIntValue < 0 {
            
            DispatchQueue.main.async {
                // alert action to show it is zero
                          let alertController = UIAlertController(title: "Cannot Update!", message: "Quantity entered is less than zero, re-enter a quantity greater than or equal to zero", preferredStyle: .alert)
                          let okAction = UIAlertAction(title: "Ok", style: .default)
                          alertController.addAction(okAction)
                          self.present(alertController, animated: true)
            }
          
        }
        
        
       

        
        // call delegate function
        delegate?.saveButtonTapped(self)
        //dismiss(animated: true)
        
    }

    @IBAction func addButtonTapped(_ sender: Any) {
        guard let stringQuantity = quantityTextField.text,
            var quantity = Int(stringQuantity) else { return }
        quantity += 1
        quantityTextField.text = String(quantity)
        

    }
    @IBAction func subtractButtonTapped(_ sender: Any) {
        
        guard let stringQuantity = quantityTextField.text,
         var quantity = Int(stringQuantity) else { return }
        quantity -= 1
        quantityTextField.text = String(quantity)
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
