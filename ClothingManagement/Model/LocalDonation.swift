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
    let isClosed: Bool?
    let reviewCount: Int
    let rating: Float
    let coordinates: Coordinates
    let location: Location
    let phoneNumber: String?
    let displayPhone: String?
    let distance: Float?
    let url: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case imageURL = "image_url"
        case isClosed = "is_closed"
        case reviewCount = "review_count"
        case rating
        case coordinates
        case location
        case phoneNumber = "phone"
        case displayPhone = "display_phone"
        case distance
        case url 
        
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
    let state: String
    let zipcode: String?
    let displayAddress: [String]?
    
    enum CodingKeys: String, CodingKey {
        case address = "address1"
        case city
        case state
        case zipcode = "zip_code"
        case displayAddress = "display_address"
    }
}
