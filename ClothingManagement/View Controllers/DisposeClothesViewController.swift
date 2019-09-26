//
//  DisposeClothesViewController.swift
//  ClothingManagement
//
//  Created by Julia Rodriguez on 9/21/19.
//  Copyright © 2019 Julia Rodriguez. All rights reserved.
//

import UIKit

protocol DisposeClothesViewControllerDelegate: class {
    func confirmDisposeButtonTapped(for view: DisposeClothesViewController)
}

class DisposeClothesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var placeLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var disposeButton: UIButton!
    
    @IBOutlet weak var cancelButton: UIButton!
    
    weak var delegate: DisposeClothesViewControllerDelegate?

    // landing pad
   var recyclePlace: Recycle?
   var donationPlace: LocalDonation?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        self.modalPresentationStyle = .overCurrentContext
        cancelButton.setTitle("No, Not now. ", for: .normal)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

        if let donationPlace = donationPlace {
            placeLabel.text = "Donate at " + donationPlace.name
            disposeButton.setTitle("Donate Here", for: .normal)
        } else if let recyclePlace = recyclePlace {
            placeLabel.text = "Recycle at " + recyclePlace.storeName
            disposeButton.setTitle("Recycle Here", for: .normal)
        }
        
        // fetch the categories
        // call fetch function of categories
        guard let user = UserController.shared.currentUser else { return }
             CategoryController.shared.fetchCategories(user: user) { (category) in
                 if let fetchedCategory = category {
                     DispatchQueue.main.async {
                        self.tableView.reloadData()
    
                     }
                 }
             }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        // dismiss popup
        dismiss(animated: true)
    }
    
    func checkIfDonated() -> Bool {
        if let donatedPlace = donationPlace {
            print(donatedPlace)
            return true
        }
        else if let recyclePlace = recyclePlace {
            print(recyclePlace)
            return false
        }
        // default value 
        return true
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                // 1/4th of view
                self.view.frame.origin.y -= keyboardSize.height/2
                    //keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let categories = CategoryController.shared.categories.count
        return categories == 0 ? 1 : categories
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           // "disposeCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "disposeCell", for: indexPath) as? DisposeClothesTableViewCell else { return UITableViewCell() }
        if CategoryController.shared.categories.count == 0 {
            cell.categoryLabel.text = "Closet Category"
            cell.quantityLabel.text = "Contains: 0 items"
            return cell
        } else {
            
        let singleCategory = CategoryController.shared.categories[indexPath.row]
        cell.category = singleCategory
        cell.updateViews()
        
        //cell.confirmDisposeButtonTapped(for: self)
        
        return cell
    }
       }
    
    @IBAction func disposeButtonTapped(_ sender: Any) {
        // grab the quantities in the text field, subtract them from the current quantity, and update the category
        var totalDispose: Int = 0
        // call the contribution controller to save a donation
        for cell in self.tableView.visibleCells {
            if let customCell = cell as? DisposeClothesTableViewCell {
                customCell.confirmDisposeButtonTapped(for: self)
                //delegate?.confirmDisposeButtonTapped(for: self)
                if let clothesDisposed = customCell.disposedNumber {
                    totalDispose += clothesDisposed
                    print("total diposed is \(totalDispose)")
                }
                print(customCell)
            }
        }
        guard let user = UserController.shared.currentUser else {
            showSignUpViewController()
            return
            
        }
        
        let isDonated = self.checkIfDonated()
        
        if isDonated { // Donated
            guard let donatedPlace = donationPlace else { return }
            
            ContributionController.shared.createContribution(withName: donatedPlace.name, isDonated: true, disposedAmount: totalDispose, user: user) { (contribution) in
                
                if contribution != nil {
                    print("successfully saved \(totalDispose) items to donatation at \(donatedPlace.name)")
                } 
        }
    }
            
            else if !isDonated { // Recycled
            guard let recyclePlace = recyclePlace else { return }
            ContributionController.shared.createContribution(withName: recyclePlace.storeName, isDonated: false, disposedAmount: totalDispose, user: user) { (contribution) in
                if contribution != nil {
                    print("successfully saved \(totalDispose) items to recycle facility at \(recyclePlace.storeName)")
                }
            }
        }
        dismiss(animated: true)
    }
    
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    func showSignUpViewController() {
        // present sign up View Controller
        let storyBoard = UIStoryboard(name: "Main", bundle: .main)
        guard let signUpViewController = storyBoard.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController else { return }
        self.present(signUpViewController, animated: true)
    }

}

