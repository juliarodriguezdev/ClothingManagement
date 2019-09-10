//
//  ClosetViewController.swift
//  ClothingManagement
//
//  Created by Julia Rodriguez on 9/9/19.
//  Copyright © 2019 Julia Rodriguez. All rights reserved.
//

import UIKit

class ClosetViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    var clothing : [Category] = {
    
    let shirts = Category(name: "Shirts", quantity: 10, photos: nil)
    let pants = Category(name: "Pants", quantity: 5, photos: nil)
    let shorts = Category(name: "Shorts", quantity: 12, photos: nil)
    let hats = Category(name: "Hats", quantity: 66, photos: nil)
    let shoes = Category(name: "Shoes", quantity: 34, photos: nil)
    let accessories = Category(name: "Accessories", quantity: 45, photos: nil)
    let outerWear = Category(name: "Outer Wear", quantity: 34, photos: nil)
    let socks = Category(name: "Socks", quantity: 3, photos: nil)
    let swimWear = Category(name: "Swim Wear", quantity: 43, photos: nil)
    let undergarments = Category(name: "Under Garments", quantity: 45, photos: nil)
        return [shirts, pants, shorts, hats, shoes, accessories, outerWear, socks, swimWear, undergarments]
    }()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var closetNameLabel: UILabel!
    
    @IBOutlet weak var quantityOfClosetLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        updateViews()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        updateViews()
    }
    
    func updateViews() {
        closetNameLabel.text = "Closet Name"
        quantityOfClosetLabel.text = "\(clothing.count)"
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return clothing.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "clothingItem", for: indexPath) as? CategoryCollectionViewCell else { return UICollectionViewCell()}
        // identify which index path the user selected
        let category = clothing[indexPath.row]
        
        
        cell.categoryLabel.text = category.name
        cell.quantityLabel.text = "\(category.quantity)"
        // set object at landing pad
        cell.category = category
        // call update views section at CustomCell
        cell.updateViews()
        // assign the custom cell as the delegate to execut protocol
        cell.cellDelegate = self
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.row)")
    }
    
     //MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toDetailVC" {
            // identify indexpath user selected
            if let destinationVC = segue.destination as? DetailCategoryViewController {
                // identify cell user selected
                if let cell = sender as? CategoryCollectionViewCell {
                    if let indexPath = collectionView.indexPath(for: cell) {
                        let category = clothing[indexPath.row]
                        destinationVC.category = category
                        
                    }
                }
            }
        }
    }
    

}

extension ClosetViewController: QuantityButtonDelegate {
    
    func quantityButtonTapped(_ sender: CategoryCollectionViewCell) {
        print("Update quantity button tapped")
        // object to send
        let category = sender.category
        
        // which story board will be used
        let storyBoard = UIStoryboard(name: "TabMain", bundle: .main)
        // instatiate the destination VC, that will appear
        guard let updateQuantityViewController = storyBoard.instantiateViewController(withIdentifier: "UpdateQuantityViewController") as? UpdateQuantityViewController else { return }
        
        
        // give object to destination view controller
        updateQuantityViewController.category = category
        // display
        navigationController?.pushViewController(updateQuantityViewController, animated: true)
    }
    
    
}
