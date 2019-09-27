//
//  ClosetViewController.swift
//  ClothingManagement
//
//  Created by Julia Rodriguez on 9/9/19.
//  Copyright © 2019 Julia Rodriguez. All rights reserved.
//

import UIKit

class ClosetViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var closetNameLabel: ClosetLabel!
    @IBOutlet weak var quantityOfClosetLabel: ClosetLabel!
    
    // landing pad from other views 
    var user: User?
    
    var quantity: Int?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.modalPresentationStyle = .overFullScreen
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gestureRecognizer:)))
        longPressGestureRecognizer.minimumPressDuration = 1
        longPressGestureRecognizer.delaysTouchesBegan = true
        longPressGestureRecognizer.delegate = self
        self.collectionView.addGestureRecognizer(longPressGestureRecognizer)
        // call fetch function of categories
        guard let user = user else {
            self.view.backgroundColor = UIColor.neutralPrimary
            self.collectionView.allowsSelection = false
            return
            
        }
        collectionView.allowsSelection = true
        checkGenderForUIColor(user: user)
        self.quantityOfClosetLabel.text = "Loading..."
        CategoryController.shared.fetchCategories(user: user) { (category) in
            if category != nil {
                DispatchQueue.main.async {
                    self.updateViews()
                 
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        updateViews()
    }
    
    func updateViews() {
        guard let title = UserController.shared.currentUser?.closetName else { return }
        quantity = CategoryController.shared.calculateNumOfItemsInCloset(categories: CategoryController.shared.categories)
        self.navigationItem.title = "\(title) Closet"
        self.navigationItem.largeTitleDisplayMode = .always
        self.collectionView.reloadData()
        self.closetNameLabel.isHidden = true
        //quantityOfClosetLabel.text = "\(clothing.count)"
        self.quantityOfClosetLabel.text = "Contains \(self.quantity!) items in Closet"
    }
    func checkGenderForUIColor(user: User) {
        
        switch user.isMale {
        case true:
            return self.view.backgroundColor = UIColor.malePrimary
        case false:
            return self.view.backgroundColor = UIColor.femalePrimary
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let categoryCount = CategoryController.shared.categories.count
        
        return categoryCount == 0 ? 1 : categoryCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "clothingItem", for: indexPath) as? CategoryCollectionViewCell else { return UICollectionViewCell() }
        
        if CategoryController.shared.categories.count == 0 {
            cell.categoryLabel.text = "Category"
            cell.quantityLabel.text = "0"
            cell.iconImage.image = UIImage(named: "hangerDefault")
            cell.backgroundColor = UIColor.neutralPrimary
            return cell
            
        } else {
            if user?.isMale == true {
                cell.backgroundColor = UIColor.malePrimary
            } else if user?.isMale == false {
                cell.backgroundColor = UIColor.femalePrimary
            }
            // identify which index path the user selected
            let category = CategoryController.shared.categories[indexPath.item]
            
            cell.categoryLabel.text = category.name
            cell.quantityLabel.text = "\(category.quantity)"
            // set object at landing pad
            cell.category = category
            // call update views section at CustomCell
            cell.updateViews()
            
            // assign the custom cell as the delegate to execut protocol
            cell.cellDelegate = self
            return cell
        }
    }
    
    @IBAction func addCategoryTapped(_ sender: UIBarButtonItem) {
        if user != nil {
           presentAddCategory(title: "Category", message: "Add Category to Closet")
        } else {
            showSignUpViewController()
        }
        
    }
    
    func showSignUpViewController() {
           // present sign up View Controller
           let storyBoard = UIStoryboard(name: "Main", bundle: .main)
           guard let signUpViewController = storyBoard.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController else { return }
           self.present(signUpViewController, animated: true)
       }
    
    func presentAddCategory(title: String, message: String) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertController.addTextField { (textfield) in
            textfield.placeholder = "Add Category Name..."
            textfield.returnKeyType = .continue
            textfield.autocapitalizationType = .words
            
        }
        alertController.addTextField { (quantityTextField) in
            quantityTextField.placeholder = "Add Quantity of Clothes..."
            quantityTextField.keyboardType = .numberPad
            quantityTextField.returnKeyType = .done
            
            
        }
        let categoryAction = UIAlertAction(title: "Add", style: .default) { (_) in
            guard let categoryText = alertController.textFields?[0].text,
                !categoryText.isEmpty,
                let user = UserController.shared.currentUser else { return }
            
            if let stringQuantity = alertController.textFields?[1].text, !stringQuantity.isEmpty {
                self.quantity = Int(stringQuantity)
            } else {
                self.quantity = 0
            }
            
            guard let quantity = self.quantity
                else { return }
            // TODO: let iconImage = UIImage(name: "defaultHanger"), to assign default image, then pass into create category func 
            
            CategoryController.shared.createCategory(withName: categoryText, quantity: quantity, user: user, completion: { (categoryFromCompletion) in
                if categoryFromCompletion != nil {
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                        self.updateViews()
                        
                    }
                }
            })
        }
        // add cancel action
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        // add all actions to alert controller
        alertController.addAction(categoryAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true)
    }
    
    @IBAction func deleteOptionTapped(_ sender: UIBarButtonItem) {
        presentUIHelperAlert(title: "Delete Clothing Category", message: "Press and hold individual category")
    }
    
    @IBAction func infoTapped(_ sender: UIBarButtonItem) {
        presentUIHelperAlert(title: "Edit Category", message: "Select a category \nto add photos & modify inventory")
    }
    
    //MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toDetailVC" {
            // identify indexpath user selected
            if let destinationVC = segue.destination as? DetailCategoryViewController {
                // identify cell user selected
                if let cell = sender as? CategoryCollectionViewCell {
                    if let indexPath = collectionView.indexPath(for: cell) {
                        let category = CategoryController.shared.categories[indexPath.item]
                        destinationVC.category = category
                        destinationVC.user = user
                        
                    }
                }
            }
        }
    }
}

extension ClosetViewController: QuantityButtonDelegate {
    
    func quantityButtonTapped(_ sender: CategoryCollectionViewCell) {
        print("Update quantity button tapped")
        // object to send
        let category = sender.category
    
        // which story board will be used
        let storyBoard = UIStoryboard(name: "TabMain", bundle: .main)
        // instatiate the destination VC, that will appear
        guard let updateQuantityViewController = storyBoard.instantiateViewController(withIdentifier: "UpdateQuantityViewController") as? UpdateQuantityViewController else { return }
        
        
        // give object to destination view controller
        updateQuantityViewController.category = category
        updateQuantityViewController.user = user
        // display
        navigationController?.pushViewController(updateQuantityViewController, animated: true)
    }
    
}

extension ClosetViewController: UIGestureRecognizerDelegate {
    @objc func handleLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state != UIGestureRecognizer.State.ended {
            return
        }
        
        
        let point = gestureRecognizer.location(in: self.collectionView)
        let indexPath = self.collectionView.indexPathForItem(at: point)
        if let index = indexPath {
            
            let category = CategoryController.shared.categories[index.item]
            
            presentDeleteCellConfirmation(title: "Delete Confirmation", message: "Are you sure you want to permanently delete the \(category.name)'s category from your closet?", indexPath: indexPath)
        }
        
    }
    
    func presentDeleteCellConfirmation(title: String, message: String, indexPath: IndexPath?) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        // No action
        let noAction = UIAlertAction(title: "No, Keep.", style: .cancel, handler: nil)
        // Delete action
        let deleteAction = UIAlertAction(title: "Yes, Delete.", style: .destructive) { (_) in
            if let index = indexPath {
                let cell = self.collectionView.cellForItem(at: index)
                //cell?.tintColor = UIColor.red
                cell?.backgroundColor = UIColor.red
                //print(cell)
                let category = CategoryController.shared.categories[index.item]
                CategoryController.shared.deleteCategory(category: category) { (success) in
                    if success {
                        DispatchQueue.main.async {
                            self.collectionView.deleteItems(at: [index])
                        }
                    }
                }
            } else {
                print("Couldn't find index path")
            }
        }
        
        // add all actions to alert controller
        alertController.addAction(noAction)
        alertController.addAction(deleteAction)
        self.present(alertController, animated: true)
    }
    
    func presentUIHelperAlert(title: String, message: String) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okayAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
        
        alertController.addAction(okayAction)
        self.present(alertController, animated: true)
    }
    
}
