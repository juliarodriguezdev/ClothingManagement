//
//  LocalDonation.swift
//  ClothingManagement
//
//  Created by Julia Rodriguez on 9/19/19.
//  Copyright © 2019 Julia Rodriguez. All rights reserved.
//

struct TopLevelJSON: Codable {
    let businesses: [LocalDonation]
}

struct LocalDonation: Codable {
    
    let name: String
    let imageURL: String?
    let isOpen: Bool?
    let reviewCount: Int
    let rating: Float
    let coordinates: Coordinates
    let location: Location
    let phoneNumber: String?
    let distance: Float?
    
    enum CodingKeys: String, CodingKey {
        case name
        case imageURL = "image_url"
        case isOpen = "is_closed"
        case reviewCount = "review_count"
        case rating
        case coordinates
        case location
        case phoneNumber = "phone"
        case distance
        
    }
    
}

struct Coordinates: Codable {
    let latitude: Double?
    let longitude: Double?
    
    enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
    }
}

struct Location: Codable {
    let address: String?
    let city: String
    let zipcode: String?
    let state: String
    
    enum CodingKeys: String, CodingKey {
        case address = "address1"
        case city
        case zipcode = "zip_code"
        case state
    }
}
