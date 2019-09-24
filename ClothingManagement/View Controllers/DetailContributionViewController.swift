//
//  DetailContributionViewController.swift
//  ClothingManagement
//
//  Created by Julia Rodriguez on 9/24/19.
//  Copyright © 2019 Julia Rodriguez. All rights reserved.
//

import UIKit

class DetailContributionViewController: UIViewController {
    
    var contribution: Contribution?
        
    @IBOutlet weak var placeLabel: UILabel!
    
    @IBOutlet weak var editButton: UIButton!
    
    @IBOutlet weak var receiptImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.modalPresentationStyle = .overCurrentContext
        updateViews()
       // loadViewIfNeeded()
        // Do any additional setup after loading the view.
    }
    

    
    func updateViews() {
        
        guard let contribution = contribution else { return }
        placeLabel.text = "For: " + contribution.place
        receiptImageView.image = contribution.receiptImage
    }
    
    @IBAction func editButtonTapped(_ sender: UIButton) {
        // show photo libray / camera to import receipt
        presentImagePickerActionSheet()
    }
    
    
    @IBAction func saveReceiptButtonTapped(_ sender: UIButton) {
        
        guard let contribution = contribution else { return }
        let newImage = receiptImageView.image
        contribution.receiptImage = newImage
        
        ContributionController.shared.updateContribution(contribution: contribution) { (success) in
                       if success {
                           print("Receipt saved!")
                        // TODO: show a pop up that it was saved successfully, alpha = 1, then alpha = 0
                        //self.dismiss(animated: true)
                       }
                   }
        
       dismiss(animated: true)
    }
    @IBAction func skipButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    

}

extension DetailContributionViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func presentImagePickerActionSheet() {
        
        let imagePickerController = UIImagePickerController()
        
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "Select a Receipt", message: "Choose from your photo libary, or camera", preferredStyle: .actionSheet)
        
        
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
                let alertController = UIAlertController(title: "Camera access not allowe", message: "In order to use your camera to upload a receipt, please go to your phone's settings and allow camera access", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .default)
                alertController.addAction(okAction)
                self.present(alertController, animated: true)
            }
            
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(actionSheet, animated: true)
    }

    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.receiptImageView.image = image
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true, completion: nil)
        }
    
}
