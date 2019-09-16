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
        setUpViews()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func beginButtonTapped(_ sender: UIButton) {
        showMainNavigationController()
    }
    
    func setUpViews() {
        guard let user = UserController.shared.currentUser else { return }
        welcomeLabel.text = """
        Welcome \(user.name) let's start
        managing \(user.closetName) Closet
        """
    }
    
    func showMainNavigationController() {
        DispatchQueue.main.async {
            let storyBoard = UIStoryboard(name: "TabMain", bundle: .main)
            let mainNavigationController = storyBoard.instantiateViewController(withIdentifier: "mainNavController")
            self.present(mainNavigationController, animated: true, completion: nil)
        }
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
