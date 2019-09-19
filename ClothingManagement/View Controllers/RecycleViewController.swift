//
//  RecycleViewController.swift
//  ClothingManagement
//
//  Created by Julia Rodriguez on 9/10/19.
//  Copyright © 2019 Julia Rodriguez. All rights reserved.
//

import UIKit

class RecycleViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var recycleIntroLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self 
        recycleIntroLabel.text = """
        Textile Recycling:
        is the method of reusing or reprocessing used clothes, fibrous material and clothing scraps from the manufacturing process.
        """
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return RecycleController.shared.loadContent().count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return RecycleController.shared.loadContent()[section].count
        
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerlabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 20))
        headerlabel.backgroundColor = .magenta
        headerlabel.textColor = .black
        headerlabel.textAlignment = .center
        
        switch section {
        case 0:
           headerlabel.text = "Clothes"
        case 1:
        headerlabel.text = "Denim"
        case 2:
            headerlabel.text = "Clothes and Shoes"
        case 3:
            headerlabel.text = "Shoes"
        case 4:
            headerlabel.text = "Bras"
        default:
            headerlabel.text = "default section"
            return nil
        }
        return headerlabel
    }
    
//    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
//        view.backgroundColor = .cyan
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recycleCell", for: indexPath) as? RecycleTableViewCell
        
        let recyclePlace = RecycleController.shared.loadContent()[indexPath.section][indexPath.row]
        cell?.storeImage.image = UIImage(named: "hangerDefault")
        cell?.storeNameLabel.text = recyclePlace.storeName
        cell?.initiativeNameLabel.text = "Initiative: \(recyclePlace.initiative!)"
        return cell ?? UITableViewCell()
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toWebView" {
            guard let index = tableView.indexPathForSelectedRow else { return }
            let destinationVC = segue.destination as? RecycleWebViewController
            let recyclePlace = RecycleController.shared.loadContent()[index.section][index.row]
            destinationVC?.recyclePlace = recyclePlace
        }
    }


}
