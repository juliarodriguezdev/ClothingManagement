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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
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
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ContributionController.shared.contributions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "contributionCell", for: indexPath) as? ContributionsTableViewCell else { return UITableViewCell() }
        
        let contribution = ContributionController.shared.contributions[indexPath.row]
        cell.contribution = contribution
        cell.updateViews()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let destinationVC = UIStoryboard(name: "TabMain", bundle: nil).instantiateViewController(withIdentifier: "DetailContributionViewController") as? DetailContributionViewController else { return }
        destinationVC.contribution = ContributionController.shared.contributions[indexPath.row]
        present(destinationVC, animated: true)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
   /* override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
     } */
    

}

    
    
    
