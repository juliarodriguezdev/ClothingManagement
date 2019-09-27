//
//  WelcomeViewController.swift
//  ClothingManagement
//
//  Created by Julia Rodriguez on 9/10/19.
//  Copyright © 2019 Julia Rodriguez. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    var user: User?

    @IBOutlet weak var welcomeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.modalPresentationStyle = .fullScreen
        welcomeLabel.alpha = 0
        updateFont(with: FontNames.trebuchetMS)
        setUpViews()
        showClosetViewController()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func beginButtonTapped(_ sender: UIButton) {
        showClosetViewController()
    }
    
    func setUpViews() {
        guard let user = user else { return }
        if user.isMale == true {
            self.view.backgroundColor = UIColor.malePrimary
        } else {
            self.view.backgroundColor = UIColor.femalePrimary
        }
        self.welcomeLabel.alpha = 1
        UIView.animate(withDuration: 10) {
            self.welcomeLabel.text = "Welcome \(user.name),\nlet's start managing \(user.closetName)) Closet"
        }
    }
    
    func showMainNavController() {
            let storyBoard = UIStoryboard(name: "TabMain", bundle: .main)
            let mainNavController = storyBoard.instantiateViewController(withIdentifier: "mainTabController")
            // Tset closet object
            self.present(mainNavController, animated: true)
    }
    
    func showClosetViewController() {
        let storyBoard = UIStoryboard(name: "TabMain", bundle: nil)
        guard let mainClosetViewController = storyBoard.instantiateViewController(withIdentifier: "ClosetViewController") as? ClosetViewController else { return }
            // set closet object
            mainClosetViewController.user = UserController.shared.currentUser
            self.present(mainClosetViewController, animated: true)
    }
    
    func updateFont(with fontName: String) {
    // Trebuchet MS
        welcomeLabel.font = UIFont(name: fontName, size: 16)
    }
    
}
