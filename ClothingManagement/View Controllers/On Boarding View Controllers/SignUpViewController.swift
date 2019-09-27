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
    

    @IBOutlet weak var signUpLabel: ClosetLabel!
    
    @IBOutlet weak var descriptionLabel: ClosetLabel!
    
    @IBOutlet weak var nameTextField: ClosetTextField!
    
    @IBOutlet weak var closetNameTextField: ClosetTextField!
    
    @IBOutlet weak var genderSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var skipLabel: ClosetLabel!
    
    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    
    var isMale: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Font: Trebuchet MS
        nameTextField.delegate = self
        closetNameTextField.delegate = self
        signUpLabel.text = "Sign up!"
        descriptionLabel.text = "Store closet inventory, clothing photos, track donated & recyled clothing contributions to the greater world"
        skipLabel.text = "Browse the app, without creating an account, \n or saving information"
        skipLabel.alpha = 0
        updateFont(with: "Trebuchet MS")
        updateColorUI()
        
        
        
        // Do any additional setup after loading the view.
    }
    func updateFont(with fontName: String) {
       
        descriptionLabel.font = UIFont(name: fontName, size: 16)
        nameTextField.font = UIFont(name: fontName, size: 16)
        closetNameTextField.font = UIFont(name: fontName, size: 16)
        skipLabel.font = UIFont(name: fontName, size: 20)
        createAccountButton.titleLabel?.font = UIFont(name: fontName, size: 18)
        skipButton.titleLabel?.font = UIFont(name: fontName, size: 16)
        let segmentedFont = UIFont(name: fontName, size: 14)
        genderSegmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: segmentedFont!], for: .normal)
    }
    
    func updateColorUI() {
        self.view.backgroundColor = UIColor.neutralPrimary
        //skipLabel.backgroundColor = UIColor.neutralSecondary
        createAccountButton.backgroundColor = UIColor.neutralAccent
        createAccountButton.setTitleColor(.lightText, for: .normal)
        skipButton.backgroundColor = UIColor.neutralPrimary
        skipButton.setTitleColor(.black, for: .normal)
        skipLabel.tintColor = .lightText
        //skipLabel.backgroundColor = .lightGray
        nameTextField.backgroundColor = UIColor.neutralPrimary
        closetNameTextField.backgroundColor = UIColor.neutralPrimary
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
        // call no icloud account
        checkforiCloudUserPresence()
        guard let userName = nameTextField.text, !userName.isEmpty,
            let closetName = closetNameTextField.text, !closetName.isEmpty,
            let isMale = isMale
            else {
                // Add alert sheet to show something is missing 
                self.presentCreateAccountInfoMissing()
                return
                
        }
        
        UserController.shared.createUserWith(userName: userName, closetName: closetName, isMale: isMale) { (user) in
            if user != nil {
                DispatchQueue.main.async {
                    self.presentWelcomeView()
                }
            }
        }
    }
    
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        nameTextField.resignFirstResponder()
        closetNameTextField.resignFirstResponder()
    }
    
    func presentCreateAccountInfoMissing() {
        let attributedString = NSAttributedString(string: "Information Missing", attributes: [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17), //your font here
            NSAttributedString.Key.foregroundColor : UIColor.red,
        ])
        
        let alertController = UIAlertController(title: "", message: "Please enter all fields, \n to continue to create an account.", preferredStyle: .alert)
        alertController.setValue(attributedString, forKey: "attributedTitle")
        
        let okAction = UIAlertAction(title: "Ok", style: .default)
        okAction.setValue(UIColor.blue, forKey: "titleTextColor")
        alertController.addAction(okAction)
        self.present(alertController, animated: true)
    }
    @IBAction func skipButtonTapped(_ sender: UIButton) {
        // send to main closet
        skipLabel.alpha = 1
        
        UIView.animate(withDuration: 0, delay: 3, options: .curveEaseIn, animations: {
            self.skipLabel.alpha = 0
        }) { (completion) in
            if completion {
                self.showMainNavController()
            }
        }

    }
    
    func showMainNavController() {
            let storyBoard = UIStoryboard(name: "TabMain", bundle: .main)
            let mainNavController = storyBoard.instantiateViewController(withIdentifier: "mainTabController")
               // TODO: set closet object
               
            self.present(mainNavController, animated: true)
       }
    
    func presentWelcomeView() {
            let storyBoard = UIStoryboard(name: "Main", bundle: .main)
            guard let viewController = storyBoard.instantiateViewController(withIdentifier: "WelcomeViewController") as? WelcomeViewController else { return }
            viewController.user = UserController.shared.currentUser
            self.present(viewController, animated: true)
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
