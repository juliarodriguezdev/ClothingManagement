//
//  DonateViewController.swift
//  ClothingManagement
//
//  Created by Julia Rodriguez on 9/10/19.
//  Copyright © 2019 Julia Rodriguez. All rights reserved.
//

import UIKit
import CoreLocation

class LocalDonationViewController: UIViewController {
    
    let user = UserController.shared.currentUser
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    let locationManager = CoreLocationController.shared.locationManager
    var currentLocation: CLLocationManager {
        return CoreLocationController.shared.locationManager
    }
    
    // source of truth
    var donationResults: [LocalDonation] = []
    var imageURL: String?
    var hasFetchedLocation = false
   
    override func viewDidLoad() {
        super.viewDidLoad()
        checkGenderForColorUI(user: user)
        self.indicator.startAnimating()
        navigationItem.title = "Donate Clothing Nearby"
        navigationItem.largeTitleDisplayMode = .always
        locationManager.delegate = self
        CoreLocationController.shared.activateLocationServices()
        tableView.delegate = self
        tableView.dataSource = self
        //self.localDonationPlacesFromCurrentLocation()
        let doubleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(doubleTap(gestureRecognizer:)))
        doubleTapGestureRecognizer.numberOfTapsRequired = 2
        doubleTapGestureRecognizer.delaysTouchesBegan = true
        doubleTapGestureRecognizer.delegate = self
        self.tableView.addGestureRecognizer(doubleTapGestureRecognizer)
        
        
    }
    func checkGenderForColorUI(user: User?) {
        if user?.isMale == true {
            self.view.backgroundColor = UIColor.malePrimary
        } else if user?.isMale == false {
            self.view.backgroundColor = UIColor.femalePrimary
        } else {
            self.view.backgroundColor = UIColor.neutralPrimary
        }
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.hasFetchedLocation = false
        tableView.backgroundColor = UIColor.neutralPrimary
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        locationManager.stopUpdatingLocation()
    }
    // TODO: Add no internet message! Alert
    
    @IBAction func infoBarItemTapped(_ sender: Any) {
        presentUIHelperAlert(title: "Information", message: "Single Tap: Navigates to Maps. \nDouble Tap: Enter amount of donated items. \nPhone Number: prompts to call. \nTap Yelp: Navigates to Yelp")
        
    }
    
    func presentUIHelperAlert(title: String, message: String) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okayAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
        
        alertController.addAction(okayAction)
        self.present(alertController, animated: true)
    }
    
    // MARK: - Navigation

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let donationPlace = donationResults[indexPath.row]
        
        LocalDonationController.shared.fetchDonationMapsURL(donationPlace: donationPlace) { (url) in
            if url != nil {
                print("Sent to apple maps, from indexPath: \(indexPath.row)")
            }
        }
    }

    
    func localDonationPlacesFromCurrentLocation() {
        guard let location = CoreLocationController.shared.locationManager.location?.coordinate else { return }
        //indicator.stopAnimating()
        let latitude = location.latitude
        let longitude = location.longitude
        
        // call api fetch
        LocalDonationController.shared.fetchLocalDonationPlaces(search: "Donate Clothes", latitude: latitude, longitude: longitude) { (donationPlaces) in
            if let donationPlaces = donationPlaces {
                self.donationResults = donationPlaces
                self.hasFetchedLocation = true
                DispatchQueue.main.async {
                    self.indicator.stopAnimating()
                    self.tableView.reloadData()
                }
            }
        }
    }

}
extension LocalDonationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 240
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return donationResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "donateCell", for: indexPath) as? LocalDonationTableViewCell else { return UITableViewCell()}
        if user?.isMale == true {
                    cell.backgroundColor = UIColor.malePrimary
                cell.nameLabel.textColor = UIColor.maleSecondary
                cell.phoneButton.backgroundColor = UIColor.clear
                cell.phoneButton.setTitleColor(UIColor.maleAccent, for: .normal)
                       } else if user?.isMale == false {
                           cell.backgroundColor = UIColor.femalePrimary
                           cell.nameLabel.textColor = UIColor.femaleSecondary
                cell.phoneButton.backgroundColor = UIColor.clear
                cell.phoneButton.setTitleColor(UIColor.femaleAccent, for: .normal)
                       } else {
                           cell.backgroundColor = UIColor.neutralPrimary
                           cell.nameLabel.textColor = UIColor.neutralSecondary
                cell.phoneButton.backgroundColor = UIColor.clear
                cell.phoneButton.setTitleColor(UIColor.neutralAccent, for: .normal)
                       }
        
            let donationPlace = donationResults[indexPath.row]
            cell.localDonation = donationPlace
            cell.delegate = self
            cell.updateViews()
            return cell
    }
    
    
}

extension LocalDonationViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            CoreLocationController.shared.activateLocationServices()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first,
            !hasFetchedLocation {
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            print("Latitude: \(latitude) and Longitude: \(longitude)")
            self.localDonationPlacesFromCurrentLocation()
        }
    }
}

extension LocalDonationViewController: UIGestureRecognizerDelegate {
    @objc func doubleTap(gestureRecognizer: UITapGestureRecognizer) {
        if gestureRecognizer.state != UIGestureRecognizer.State.ended {
            return
        }
    
        let point = gestureRecognizer.location(in: self.tableView)
        let indexPath = self.tableView.indexPathForRow(at: point)
        if let index = indexPath {
            // get the index path of the array (object to send)
            let donationPlace = donationResults[index.row]
            let storyBoard = UIStoryboard(name: "TabMain", bundle: .main)
                guard let disposeClothesViewController = storyBoard.instantiateViewController(withIdentifier: "DisposeClothesViewController") as? DisposeClothesViewController else { return }
                // object to set
                disposeClothesViewController.donationPlace = donationPlace
                disposeClothesViewController.user = user
            
            // present modally
            navigationController?.present(disposeClothesViewController, animated: true)

        }
    }
}

extension LocalDonationViewController: LocalDonationDelegate {
    func navigateToYelp(for cell: LocalDonationTableViewCell) {
        // get indexpath
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        // get url
        let localDonation = donationResults[indexPath.row]
        // navigate to applications url
        guard let yelpURLString = localDonation.url else { return }
        if let yelpURL = URL(string: yelpURLString) {
            UIApplication.shared.canOpenURL(yelpURL)
            UIApplication.shared.open(yelpURL) { (success) in
                if success {
                    print("sent to yelp!")
                }
            }
        }
    }
    
    
}
