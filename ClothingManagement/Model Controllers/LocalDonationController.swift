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
        print(finalURL)
        print(request)
        
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
}
