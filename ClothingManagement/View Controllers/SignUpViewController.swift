//
//  SignUpViewController.swift
//  ClothingManagement
//
//  Created by Julia Rodriguez on 9/10/19.
//  Copyright © 2019 Julia Rodriguez. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    var userNew: User?

    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var closetNameTextField: UITextField!
    
    @IBOutlet weak var genderSegmentedControl: UISegmentedControl!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        closetNameTextField.delegate = self 

        // Do any additional setup after loading the view.
    }
    @IBAction func genderSegmentedControl(_ sender: UISegmentedControl) {
    }
    
    @IBAction func createAccountButtonTapped(_ sender: UIButton) {
        guard let user = nameTextField.text,
            let closetName = closetNameTextField.text
            else { return }
        userNew = User(name: user, closetName: closetName)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toWelcomeVC" {
            guard let userNew = userNew,
            
            let destinationVC = segue.destination as? WelcomeViewController
            else { return }
            
            destinationVC.user = userNew
            
        }
    }
}

extension SignUpViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
