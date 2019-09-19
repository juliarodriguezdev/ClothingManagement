//
//  DetailCategoryViewController.swift
//  ClothingManagement
//
//  Created by Julia Rodriguez on 9/10/19.
//  Copyright © 2019 Julia Rodriguez. All rights reserved.
//

import UIKit
import CloudKit


class DetailCategoryViewController: UIViewController {
    
    let user = UserController.shared.currentUser
    
    var category: Category?
    
    @IBOutlet weak var quantityOfCategoryLabel: UILabel!
    
    @IBOutlet weak var updateQuantityButton: UIButton!
    
    @IBOutlet weak var photosCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photosCollectionView.dataSource = self
        photosCollectionView.delegate = self
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

    }
    
    @IBAction func updateQuantityButtonTapped(_ sender: UIButton) {
        // perform segue
        performSegue(withIdentifier: "toUpdateQuantityVC", sender: self)
    }
    
    @IBAction func addPhotoButtonTapped(_ sender: UIBarButtonItem) {
        // TODO: add alert controller action sheet
        presentImagePickerActionSheet()
    }
    
    func updateViews() {
        guard let category = category else { return }
        quantityOfCategoryLabel.text = "Contains: \(category.quantity) items"
        updateQuantityButton.setTitle("Update Quantity", for: .normal)
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

extension DetailCategoryViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func presentImagePickerActionSheet() {
        
        let imagePickerController = UIImagePickerController()
        
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "Select a photo to add to this category", message: "Choose to your liking...", preferredStyle: .actionSheet)
        
        // check if the photolibrary is available as a source
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            actionSheet.addAction(UIAlertAction(title: "Photos", style: .default, handler: { (_) in
                imagePickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
                self.present(imagePickerController, animated: true, completion: nil)
            }))
        }
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (_) in
                imagePickerController.sourceType = UIImagePickerController.SourceType.camera
                self.present(imagePickerController, animated: true, completion: nil)
            }))
        }
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(actionSheet, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let photo = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            guard let category = category else { return }
            
            CategoryPhotoController.shared.createCategoryPhoto(photo: photo, category: category) { (photo) in
                if let photo = photo {
                    print("Category photo saved successfully")
                    DispatchQueue.main.async {
                        category.categoryPhotos.append(photo)
                        self.photosCollectionView.reloadData()
                        // TODO: reload collection view
                    }
                }
            }
        }
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true, completion: nil)
        }
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
            // call and create a CRUD function to to this
            let iconPhoto = category.categoryPhotos[index.item].categoryPhoto
            category.iconImage = iconPhoto
            
            CategoryController.shared.updateCategory(category: category) { (success) in
                if success {
                    print("category: \(category.name) saved at Double Tap Gesture")
                }
            }
        }else {
                print("Failed to get indexPath at point")
            }
            
    }
}
