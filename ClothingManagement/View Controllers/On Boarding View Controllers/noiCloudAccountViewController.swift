//
//  noiCloudAccountViewController.swift
//  ClothingManagement
//
//  Created by Julia Rodriguez on 9/24/19.
//  Copyright © 2019 Julia Rodriguez. All rights reserved.
//

import UIKit
import CloudKit

class noiCloudAccountViewController: UIViewController {

    @IBOutlet weak var icloudFeedbackLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.modalPresentationStyle = .overCurrentContext
        icloudFeedbackLabel.alpha = 0

        // Do any additional setup after loading the view.
    }
    
    @IBAction func refresh(_ sender: UIButton) {
        refreshForiCloudUser()
    }
    
    func refreshForiCloudUser() {
        CKContainer.default().accountStatus { (status, error) in
            if let error = error {
                print("\(error.localizedDescription)")
            } else {
                switch status {
                case .available:
                    // present sign up vc again
                    self.dismiss(animated: true, completion: nil)
                case .restricted:
                    print("restricted")
                case .noAccount:
                    DispatchQueue.main.async {
                        self.animateFeedbacklabel()
                    }
                case .couldNotDetermine:
                    print("Couldn't determine iCloud account")
                default:
                    print("iCloud Error")
                }
            }
        }
    }
    func animateFeedbacklabel() {
        icloudFeedbackLabel.alpha = 1
        UIView.animate(withDuration: 5) {
            self.icloudFeedbackLabel.alpha = 0
        }
    }

}
