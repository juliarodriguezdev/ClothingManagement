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

        if let donationPlace = donationPlace {
            placeLabel.text = "Donate to " + donationPlace.name
            disposeButton.setTitle("Donate Here", for: .normal)
        } else if let recyclePlace = recyclePlace {
            placeLabel.text = "Recycle to " + recyclePlace.storeName
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CategoryController.shared.categories.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           // "disposeCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "disposeCell", for: indexPath) as? DisposeClothesTableViewCell else { return UITableViewCell() }
        let singleCategory = CategoryController.shared.categories[indexPath.row]
        cell.category = singleCategory
        cell.updateViews()
        
        //cell.confirmDisposeButtonTapped(for: self)
        
        return cell
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
        guard let user = UserController.shared.currentUser else { return }
        
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
    
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
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

