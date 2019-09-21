//
//  LocalDonationController.swift
//  ClothingManagement
//
//  Created by Julia Rodriguez on 9/19/19.
//  Copyright © 2019 Julia Rodriguez. All rights reserved.
//

import UIKit

private let api_Key = "Vp6qgfKIZXW-GxfSmyl2JxSdvzG3t1R6JAOSvp1A0Rx1R4Ll1hXw7cEo2aZCMSZ-AscFtPWzQRHS1sGy3bCkl_ti2GhiF5wgtkCzE9KaTqKIUM9gcQJeNbJDD86DXXYx"

class LocalDonationController {
    
    
    let results: [LocalDonation] = []
    
    // base URL
    let baseURL = URL(string: "https://api.yelp.com/v3/businesses/search")
    
    static let shared = LocalDonationController()

    
    func fetchLocalDonationPlaces(search searchQuery: String, latitude: Double, longitude: Double, completion: @escaping ([LocalDonation]?) -> Void) {
        
        guard let url = baseURL else { completion(nil); return }
        
        // add components to url
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        // term
        let termQuery = URLQueryItem(name: "term", value: searchQuery)
        
        // latitude
        let latitudeQuery = URLQueryItem(name: "latitude", value: "\(latitude)")
        // longitude
        let longitudeQuery = URLQueryItem(name: "longitude", value: "\(longitude)")
        
        components?.queryItems = [termQuery, latitudeQuery, longitudeQuery]
        
        guard let finalURL = components?.url else { completion(nil); return }
        
        var request = URLRequest(url: finalURL)
        // add header
        request.addValue("Bearer \(api_Key)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        //print(request)
        print(finalURL)
        
        // URLSession
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) /n---/n \(error)")
                completion(nil)
                return
            }
            guard let data = data else { completion(nil); return }
            do {
                let jsonDecoder = JSONDecoder()
                let topLevelJSON = try jsonDecoder.decode(TopLevelJSON.self, from: data)
                completion(topLevelJSON.businesses)
            } catch {
                print("failed to decode the data")
                completion(nil)
                return
            }
        }.resume()
    }
    
    func fetchDonationPlacesImage(imageURL: String?, completion: @escaping (UIImage?) -> Void) {
        // unwrap image from model
        guard let imageURL = imageURL else { return }
        guard let urlForString = URL(string: imageURL) else { return }
        
        URLSession.shared.dataTask(with: urlForString) { (data, _, error) in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) /n---/n \(error)")
                completion(nil)
                return
            }
            guard let data = data else {
                print("Couldn't fetch imageURL data")
                completion(nil)
                return
            }
            let image = UIImage(data: data)
            completion(image)
        }.resume()
    }
    
    func fetchDonationMapsURL(donationPlace: LocalDonation, completion: @escaping (URL?) -> Void) {
        
        let mapsBaseURL = URL(string: "http://maps.apple.com/")
        
        guard let url = mapsBaseURL else { return }
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        // add appended query items
        
        var address: String {
            let city = donationPlace.location.city
            let state = donationPlace.location.state
            let cityAndState = donationPlace.location.city + "," + donationPlace.location.state
            guard let address = donationPlace.location.address,
                let zipcode = donationPlace.location.zipcode else { return cityAndState }
            let fullAddress = address + "," + city + "," + state + " " + zipcode
            print("full address: \(fullAddress)")
            return fullAddress
        }
        
        print(address)
        let destination = URLQueryItem(name: "daddr", value: "\(address)")
        print(donationPlace)
        
        var searchAddress: String {
            let city = donationPlace.location.city
            let state = donationPlace.location.state
            let place = donationPlace.name
            
            guard let address = donationPlace.location.address,
                let zipcode = donationPlace.location.zipcode else { return city + state}
            
            // name address city state zipcode
            let searchQuery = place + " " + address + " " + city + " " + state + " " + zipcode
            print(searchQuery)
            return searchQuery
        }
        let searchDestination = URLQueryItem(name: "q", value: searchAddress)
        
        components?.queryItems = [searchDestination]
        
        guard let finalDestinationURL = components?.url else { return }
        print(finalDestinationURL)
        
        UIApplication.shared.canOpenURL(finalDestinationURL)
        UIApplication.shared.open(finalDestinationURL) { (success) in
            if success {
                print("sent to apple maps!")
                completion(finalDestinationURL)
            } else {
                print("address not able to sent to apple maps")
                completion(nil)
            }
        }
    }
}
