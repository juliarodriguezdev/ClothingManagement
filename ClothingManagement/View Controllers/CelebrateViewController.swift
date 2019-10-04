//
//  CelebrateViewController.swift
//  ClothingManagement
//
//  Created by Julia Rodriguez on 9/27/19.
//  Copyright © 2019 Julia Rodriguez. All rights reserved.
//

import UIKit

class CelebrateViewController: UIViewController {
    // landing pad
    var user: User?
    
    var donationPlace: LocalDonation?
    
    var celebrateText = ""
    
    @IBOutlet weak var celebrateLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        displayLabel(user: user, donationPlace: donationPlace)
    }
    
   
    //var style: UIStatusBarStyle = .lightContent
    
    func displayLabel(user: User?, donationPlace: LocalDonation?) {
        if let user = user, let donation = donationPlace {
            celebrateText = "Thank you \(String(describing: user.name)) for donating at \(donation.name), your clothing is off to a new life!"
        } else {
            celebrateText = "Thank you for donating, your clothing is off to a new life!"
        }
        self.celebrateLabel.text = celebrateText
        self.celebrateLabel.alpha = 0.75
        UIView.animate(withDuration: 0, delay: 0, options: .curveEaseIn, animations: {
            DispatchQueue.main.async {
                self.celebrateLabel.alpha = 0
            }
            
        }) { (completion) in
            if completion {
                sleep(5)
                DispatchQueue.main.async {
                    self.dismiss(animated: true)
                }
                
            }
        }
    }
    
    func showContributionsViewController() {
             // present sign up View Controller
             let storyBoard = UIStoryboard(name: "TabMain", bundle: nil)
             guard let contributionsViewController = storyBoard.instantiateViewController(withIdentifier: "ContributionsViewController") as? ContributionsViewController else { return }
            self.show(contributionsViewController, sender: self)
             //self.present(contributionsViewController, animated: true)
         }
    // TODO: animate label, to disapear
    
    // TODO: once animated label is complete, then dismiss the view controller.
    
    // TODO: test to see where VC goes, after being dimissed
    
}
