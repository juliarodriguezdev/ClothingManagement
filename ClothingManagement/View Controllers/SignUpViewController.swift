//
//  SignUpViewController.swift
//  ClothingManagement
//
//  Created by Julia Rodriguez on 9/10/19.
//  Copyright © 2019 Julia Rodriguez. All rights reserved.
//

import UIKit
import CloudKit

class SignUpViewController: UIViewController {
    

    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var closetNameTextField: UITextField!
    
    @IBOutlet weak var genderSegmentedControl: UISegmentedControl!
    
    var isMale: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.modalPresentationStyle = .overCurrentContext
        nameTextField.delegate = self
        closetNameTextField.delegate = self

        // Do any additional setup after loading the view.
    }
    
    @IBAction func genderSegmentedControl(_ sender: UISegmentedControl) {
        
        switch genderSegmentedControl.selectedSegmentIndex {
        case 0:
            return isMale = true
        case 1:
            return isMale = false
        default:
            print("Not able to grab a gender")
            break
        }
    }
    
    @IBAction func createAccountButtonTapped(_ sender: UIButton) {
        guard let userName = nameTextField.text, !userName.isEmpty,
            let closetName = closetNameTextField.text, !closetName.isEmpty,
            let isMale = isMale
            else { return }
        
        UserController.shared.createUserWith(userName: userName, closetName: closetName, isMale: isMale) { (user) in
            if user != nil {
                self.presentWelcomeView()
            }
        }
    }
    
    func presentWelcomeView() {
        DispatchQueue.main.async {
            let storyBoard = UIStoryboard(name: "Main", bundle: .main)
            let viewController = storyBoard.instantiateViewController(withIdentifier: "WelcomeViewController")
            self.present(viewController, animated: true)
        }
    }
    
    
    func showMainNavigationController() {
        DispatchQueue.main.async {
            let storyBoard = UIStoryboard(name: "TabMain", bundle: .main)
            let mainNavigationController = storyBoard.instantiateViewController(withIdentifier: "mainTabController")
            self.present(mainNavigationController, animated: true, completion: nil)
        }
    }
    
    func checkforiCloudUserPresence() {
        CKContainer.default().accountStatus { (status, error) in
            if let error = error {
                print("error fetching iCloud account: \(error.localizedDescription)")
            } else {
                switch status{
                case .available:
                    print("iCloud account is available")
                case .restricted:
                    print("iCloud account is restricted")
                case .noAccount:
                    // present no iCloud VC
                    self.presentNoiCloudAccountViewController()
                case .couldNotDetermine:
                    print("iCloud account could not be determined")
                default:
                    print("icloud Error ")
                }
            }
        }
    }
    
    func presentNoiCloudAccountViewController() {
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let noiCloudViewController = storyboard.instantiateViewController(withIdentifier: "noiCloudAccountViewController") as? noiCloudAccountViewController else { return }
            self.present(noiCloudViewController, animated: true)
        }
    }
    
}

extension SignUpViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
