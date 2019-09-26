//
//  StartViewController.swift
//  ClothingManagement
//
//  Created by Julia Rodriguez on 9/24/19.
//  Copyright © 2019 Julia Rodriguez. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // fetch User
        indicator.startAnimating()
        UserController.shared.fetchUser { (success) in
            if success == true {
                // send to closet view controller
                DispatchQueue.main.async {
                    self.showClosetViewController()
                    self.indicator.stopAnimating()
                }
            } else {
                // send to sign up
                DispatchQueue.main.async {
                    self.showSignUpViewController()
                    self.indicator.stopAnimating()
                }
            }
        }
    }
    func showClosetViewController() {
        let storyBoard = UIStoryboard(name: "TabMain", bundle: nil)
        guard let mainClosetViewController = storyBoard.instantiateViewController(withIdentifier: "ClosetViewController") as? ClosetViewController else { return }
            // set closet object
            mainClosetViewController.user = UserController.shared.currentUser
            self.present(mainClosetViewController, animated: true)
    }
    
  
    func showSignUpViewController() {
        // present sign up View Controller
        let storyBoard = UIStoryboard(name: "Main", bundle: .main)
        guard let signUpViewController = storyBoard.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController else { return }
        self.present(signUpViewController, animated: true)
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