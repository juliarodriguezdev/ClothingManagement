//
//  DetailCategoryViewController.swift
//  ClothingManagement
//
//  Created by Julia Rodriguez on 9/10/19.
//  Copyright © 2019 Julia Rodriguez. All rights reserved.
//

import UIKit
import CloudKit
import AVFoundation


class DetailCategoryViewController: UIViewController, UITextFieldDelegate {
    
    var user: User?
    
    var category: Category?
    @IBOutlet weak var categoryLabel: ClosetLabel!
    
    @IBOutlet weak var quantityOfCategoryLabel: ClosetLabel!
    
    @IBOutlet weak var updateQuantityButton: ClosetButton!
    
    @IBOutlet weak var photoGalleryLabel: UILabel!
    
    @IBOutlet weak var photosCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photosCollectionView.dataSource = self
        photosCollectionView.delegate = self
        photoGalleryLabel.text = "Photo Gallery is loading..."
        
        guard let category = category else { return }
        updateViews()
        let predicate = NSPredicate(format: "categoryReference == %@", category.recordID)
        let compPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate])
        
        CategoryPhotoController.shared.fetchCategoryPhotos(category: category, predicate: compPredicate) { (photos) in
            if let photos = photos {
                category.categoryPhotos = photos
                DispatchQueue.main.async {
                    // TODO: reload tableview
                    self.photosCollectionView.reloadData()
                    self.photoGalleryLabel.text = "Photo Gallery..."
                }
            } else {
                print("Failed to retrieve photos")
            }
        }
        let doubleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(gestureRecognizer:)))
        doubleTapGestureRecognizer.numberOfTapsRequired = 2
        doubleTapGestureRecognizer.delaysTouchesBegan = true
        doubleTapGestureRecognizer.delegate = self
        self.photosCollectionView.addGestureRecognizer(doubleTapGestureRecognizer)
        checkGenderForUIColor(user: user)

    }
    
    @IBAction func updateQuantityButtonTapped(_ sender: UIButton) {
        // perform segue
        performSegue(withIdentifier: "toUpdateQuantityVC", sender: self)
    }
    
    @IBAction func addPhotoButtonTapped(_ sender: UIBarButtonItem) {
        // TODO: add alert controller action sheet
        presentImagePickerActionSheet()
    }
    
    @IBAction func infoBarItemTapped(_ sender: UIBarButtonItem) {
        presentUIHelperAlert(title: "Information", message: "Camera: upload & take photos of clothes \nPencil: update inventory \nEdit: edit category name, Double Tap: on a photo to set it as the icon image.")
    }
    
    @IBAction func editBarItemTapped(_ sender: UIBarButtonItem) {
        // TODO: Test with a user 
        editCategoryTitleAlert()
    }
    
    
    func presentUIHelperAlert(title: String, message: String) {
            
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            let okayAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
            
            alertController.addAction(okayAction)
            self.present(alertController, animated: true)
        }
    
    
    func updateViews() {
        guard let category = category else { return }
        if category.quantity == 1 {
            quantityOfCategoryLabel.text = "Contains: \(category.quantity) \(category.name)"

        } else {
            quantityOfCategoryLabel.text = "Contains: \(category.quantity) \(category.name)'s"
        }
      
    }
    func checkGenderForUIColor(user: User?) {
        
        if user?.isMale == true {
    
            updateQuantityButton.backgroundColor = UIColor.maleSecondary
            updateQuantityButton.setTitleColor(.darkText, for: .normal)
            self.view.backgroundColor = UIColor.malePrimary
            photosCollectionView.backgroundColor = UIColor.malePrimary
            
        } else if user?.isMale == false {
            updateQuantityButton.backgroundColor = UIColor.femaleSecondary
            updateQuantityButton.setTitleColor(.lightText, for: .normal)
            self.view.backgroundColor = UIColor.femalePrimary
            photosCollectionView.backgroundColor = UIColor.femalePrimary
           
        } else {
            self.view.backgroundColor = UIColor.neutralPrimary
            photosCollectionView.backgroundColor = UIColor.neutralPrimary
           
        }
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
    
    func editCategoryTitleAlert() {
        guard let category = category else { return }
        let alertController = UIAlertController(title: "Edit Category Title", message: "Modify title, or enter a new title", preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "Edit Category Title here..."
            textField.autocorrectionType = .yes
            textField.autocapitalizationType = .sentences
            // TODO: Test current category name
            textField.text = category.name
            textField.keyboardAppearance = .alert
            textField.returnKeyType = .done
            textField.delegate = self

        }
        
        let addAction = UIAlertAction(title: "Update", style: .default) { (_) in
            guard let editedTitle = alertController.textFields?.first?.text else { return }
            if editedTitle != category.name {
                category.name = editedTitle
                CategoryController.shared.updateCategory(category: category) { (success) in
                    if success {
                        print("Category edited and updated")
                        DispatchQueue.main.async {
                            self.categoryLabel.reloadInputViews()
                        }
                    }
                }
                
            } else {
                // TODO: Show Alert : edited text is the same as previous text
            }
        
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true)
    }
}

extension DetailCategoryViewController: SaveButtonDelegate {
    func saveButtonTapped(_ sender: UpdateQuantityViewController) {
        updateViews()
    }
}

extension DetailCategoryViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func presentImagePickerActionSheet() {
        
        let imagePickerController = UIImagePickerController()
        
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "Select/Capture a photo", message: "", preferredStyle: .actionSheet)
        
        
        // check if the photolibrary is available as a source
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (_) in
                
                
                imagePickerController.sourceType = .photoLibrary
                imagePickerController.allowsEditing = true
                self.present(imagePickerController, animated: true, completion: nil)
            }))
        }
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (_) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePickerController.sourceType = .camera
                imagePickerController.allowsEditing = true
                imagePickerController.showsCameraControls = true
                self.present(imagePickerController, animated: true, completion: nil)
            } else {
                print("Users Camera not available")
                let alertController = UIAlertController(title: "Camera access not allowe", message: "In order to use your camera to upload photos to the closet, please go to your phone's settings and allow camera access", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .default)
                alertController.addAction(okAction)
                self.present(alertController, animated: true)
            }
            
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(actionSheet, animated: true)
    }

    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.photoGalleryLabel.text = "Photo Gallery is loading..."
        
        if let photo = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            guard let category = category else { return }
            
            CategoryPhotoController.shared.createCategoryPhoto(photo: photo, category: category) { (photo) in
                if let photo = photo {
                    print("Category photo saved successfully")
                    DispatchQueue.main.async {
                        category.categoryPhotos.append(photo)
                        self.photosCollectionView.reloadData()
                        self.photoGalleryLabel.text = "Photo Gallery..."
                    }
                }
            }
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true, completion: nil)
        }

}

extension DetailCategoryViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       // guard let category = category else { return 0}
        return category?.categoryPhotos.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as? DetailCategoryCollectionViewCell else { return UICollectionViewCell()}
        
        let photo = category?.categoryPhotos[indexPath.item].categoryPhoto
        cell.photoImageView.image = photo
        cell.photoImageView.contentMode = .scaleAspectFit
    
        return cell
    }
    
}

extension DetailCategoryViewController: UIGestureRecognizerDelegate {
    @objc func handleDoubleTap(gestureRecognizer: UITapGestureRecognizer) {
        if gestureRecognizer.state != UIGestureRecognizer.State.ended {
            return
        }
        // TODO: update indexpath.item cell background image to tell which image was selected
        // TODO: move image to indexpath[0] - first item in array 
        guard let category = category else { print("Failed to get category"); return }
        let point = gestureRecognizer.location(in: self.photosCollectionView)
        let indexPath = self.photosCollectionView.indexPathForItem(at: point)

        if let index = indexPath {
            let cell = photosCollectionView.cellForItem(at: index)
            cell?.backgroundColor = .magenta
        
            // call and create a CRUD function to to this
            let iconPhoto = category.categoryPhotos[index.item].categoryPhoto
            category.iconImage = iconPhoto
            
            CategoryController.shared.updateCategory(category: category) { (success) in
                if success {
                    print("category: \(category.name) saved at Double Tap Gesture")
                    DispatchQueue.main.async {
                        cell?.backgroundColor = .clear
                    }
                    // TODO: show feedback label set alpha to 0 in viewDidLoad, set alpha to 1 here, animate for 5 sec. "Saved"
                }
            }
        }else {
                print("Failed to get indexPath at point")
            }
            
    }
}
