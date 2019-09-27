//
//  ContributionsViewController.swift
//  ClothingManagement
//
//  Created by Julia Rodriguez on 9/23/19.
//  Copyright © 2019 Julia Rodriguez. All rights reserved.
//

import UIKit

class ContributionsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var tableView: UITableView!
    
    let user = UserController.shared.currentUser
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        checkGenderForColorUI(user: user)
        // fetch contributions
        guard let user = user else { return }
        ContributionController.shared.fetchContributions(user: user) { (contribution) in
            if contribution != nil {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                
                }
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        // fetch contributions
               guard let user = UserController.shared.currentUser else { return }
               ContributionController.shared.fetchContributions(user: user) { (contribution) in
                   if contribution != nil {
                       DispatchQueue.main.async {
                           self.tableView.reloadData()
                       
                       }
                   }
               }
    }
    
    func checkGenderForColorUI(user: User?) {
        if user?.isMale == true {
            tableView.backgroundColor = UIColor.malePrimary
        } else if user?.isMale == false {
            tableView.backgroundColor = UIColor.femalePrimary
        } else {
            tableView.backgroundColor = UIColor.neutralPrimary
        }
    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let contributions = ContributionController.shared.contributions.count
        return contributions == 0 ? 1 : contributions
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "contributionCell", for: indexPath) as? ContributionsTableViewCell else { return UITableViewCell() }
        
        if ContributionController.shared.contributions.count == 0 {
            cell.placeLabel.text = "Store Name / Organization"
            cell.typeLabel.text = "Type: Donation"
            cell.quantityLabel.text = "0 items donated"
            cell.timestampLabel.text = "Today at 12:00pm"
            cell.receiptLabel.text = "Receipt on file: Yes"
            cell.imageIcon.image = UIImage(named: "donate")
            cell.backgroundColor = UIColor.neutralPrimary
            cell.placeLabel.textColor = UIColor.neutralSecondary
            return cell
        } else {
            
        let contribution = ContributionController.shared.contributions[indexPath.row]
        cell.contribution = contribution
            
            if user?.isMale == true {
                cell.backgroundColor = UIColor.malePrimary
                cell.placeLabel.textColor = UIColor.maleSecondary
            } else if user?.isMale == false {
                cell.backgroundColor = UIColor.femalePrimary
                cell.placeLabel.textColor = UIColor.femaleSecondary
            }
        cell.updateViews()
        
        return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let destinationVC = UIStoryboard(name: "TabMain", bundle: nil).instantiateViewController(withIdentifier: "DetailContributionViewController") as? DetailContributionViewController else { return }
        if ContributionController.shared.contributions.count == 0 {
            present(destinationVC, animated: true)
        } else {
            destinationVC.contribution = ContributionController.shared.contributions[indexPath.row]
            destinationVC.user = user
            present(destinationVC, animated: true)
        }
        
    }
    

}

    
    
    
