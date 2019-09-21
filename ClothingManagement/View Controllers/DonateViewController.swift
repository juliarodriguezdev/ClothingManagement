//
//  DonateViewController.swift
//  ClothingManagement
//
//  Created by Julia Rodriguez on 9/10/19.
//  Copyright © 2019 Julia Rodriguez. All rights reserved.
//

import UIKit
import CoreLocation

class DonateViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    let locationManager = CoreLocationController.shared.locationManager
    var currentLocation: CLLocationManager {
        return CoreLocationController.shared.locationManager
    }
    
    // source of truth
    var donationResults: [LocalDonation] = []
    var imageURL: String?
    var hasFetchedLocation = false
    //var latitude: Double?
    //var longitude: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Donate Clothing"
        navigationItem.largeTitleDisplayMode = .always
        locationManager.delegate = self
        CoreLocationController.shared.activateLocationServices()
        tableView.delegate = self
        tableView.dataSource = self
        //self.localDonationPlacesFromCurrentLocation()
        
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.hasFetchedLocation = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        locationManager.stopUpdatingLocation()
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    }
 */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let donationPlace = donationResults[indexPath.row]
        
        LocalDonationController.shared.fetchDonationMapsURL(donationPlace: donationPlace)
        
    }

    
    func localDonationPlacesFromCurrentLocation() {
        guard let location = CoreLocationController.shared.locationManager.location?.coordinate else { return }
        let latitude = location.latitude
        let longitude = location.longitude
        
        // call api fetch
        LocalDonationController.shared.fetchLocalDonationPlaces(search: "donate clothes", latitude: latitude, longitude: longitude) { (donationPlaces) in
            if let donationPlaces = donationPlaces {
                self.donationResults = donationPlaces
                self.hasFetchedLocation = true
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }

}
extension DonateViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180 
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return donationResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "donateCell", for: indexPath) as? LocalDonationTableViewCell else { return UITableViewCell()}
        
        let donationPlace = donationResults[indexPath.row]
        
        cell.localDonation = donationPlace
        cell.updateViews()
        
        return cell
    }
    
    
}

extension DonateViewController: CLLocationManagerDelegate {
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

