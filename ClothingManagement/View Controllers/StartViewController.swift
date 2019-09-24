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
                guard let fetchedUser = UserController.shared.currentUser else { return }
                DispatchQueue.main.async {
                    self.showMainNavController()
                    self.indicator.stopAnimating()
                }
            } else {
                DispatchQueue.main.async {
                    self.showSignUpViewController()
                    self.indicator.stopAnimating()
                }
            }
        }
    }
    func showMainNavController() {
            let storyBoard = UIStoryboard(name: "TabMain", bundle: .main)
            let mainNavController = storyBoard.instantiateViewController(withIdentifier: "mainTabController")
            // TODO: set closet object
            //self.navigationController?.pushViewController(mainClosetController, animated: true)
            self.present(mainNavController, animated: true)
    }
    
    func showWelcomeController() {
        // which story board will be used
        let storyBoard = UIStoryboard(name: "Main", bundle: .main)
        // instatiate the destination VC, that will appear
        guard let welcomeViewController = storyBoard.instantiateViewController(withIdentifier: "WelcomeViewController") as? WelcomeViewController else { return }
        
        // give object to destination view controller
        // display
        self.present(welcomeViewController, animated: true)
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
