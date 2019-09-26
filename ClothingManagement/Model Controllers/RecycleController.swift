//
//  DonateController.swift
//  ClothingManagement
//
//  Created by Julia Rodriguez on 9/18/19.
//  Copyright © 2019 Julia Rodriguez. All rights reserved.
//

import Foundation

class RecycleController {
    
    static let shared = RecycleController()
    
    let user = UserController.shared.currentUser
    
        let hAndM = Recycle(storeName: "H&M", initiative: "Garment Collection Program", webURL: "https://www2.hm.com/en_gb/ladies/shop-by-feature/16r-garment-collecting.html", category: .clothes)
    
        let theNorthFace = Recycle(storeName: "The North Face", initiative: "Clothes The Loop", webURL: "https://www.thenorthface.com/about-us/responsibility/product/clothes-the-loop.html", category: .clothes)
    
        let eileenFisher = Recycle(storeName: "Eileen Fisher", initiative: "Renew", webURL: "https://www.eileenfisherrenew.com/our-story", category: .clothes)
    
        let zara = Recycle(storeName: "Zara", initiative: "Collecting Clothes", webURL: "https://www.zara.com/us/en/sustainability-collection-program-l1452.html", category: .clothes)
    
        let oneWarmCoat = Recycle(storeName: "One Warm Coat", initiative: "Provide a free, warm coat to any person in need", webURL: "https://www.onewarmcoat.org", category: .clothes)
    
        let levis = Recycle(storeName: "Levi Strauss & Co.", initiative: "Unzipped", webURL: "https://www.levistrauss.com/2015/07/21/clothing-recycling-us-expansion/" , category: .denim)
    
        let madeWell = Recycle(storeName: "Madewell", initiative: "Blue Jeans Go Green", webURL: "https://www.madewell.com/inspo-do-well-denim-recycling-landing.html", category: .denim)
        let cotton = Recycle(storeName: "Cotton", initiative: "Blue Jeans Go Gree", webURL: "https://bluejeansgogreen.org/recycle-denim/", category: .denim)
    
        let americanEagle = Recycle(storeName: "American Eagle", initiative: "I:CO", webURL: "https://bluejeansgogreen.org/recycle-denim/", category: .clothesAndShoes)
    
        let zappos = Recycle(storeName: "Zappos", initiative: "Zappos for Good", webURL: "https://zapposforgood.org/give", category: .clothesAndShoes)
    
        let nike = Recycle(storeName: "Nike", initiative: "Nike Reuse-A-Shoe", webURL: "https://www.nike.com/us/en_us/c/better-world/reuse-a-shoe.%20", category: .shoes)
    
        let soles4Souls = Recycle(storeName: "Soles 4 Souls", initiative: "Wearing Out Poverty", webURL: "https://soles4souls.org/get-involved/give-shoes/donate/#larger-donations", category: .shoes)
    
        let dsw = Recycle(storeName: "DSW", initiative: "DSWGives + Soles 4 Souls", webURL: "https://www.dsw.com/en/us/content/give-a-pair", category: .shoes)
    
        let dressForSuccess = Recycle(storeName: "Dress For Success", initiative: "Going Places. Going Strong", webURL: "https://dressforsuccess.org/get-involved/donation-drives/", category: .career)
    
        let careerGear = Recycle(storeName: "Career Gear", initiative: "A suit - a second chance.", webURL: "https://careergear.org/get-involved/donate-clothing/", category: .career)
    
        let acdn = Recycle(storeName: "Alliance of Career Development NonProfits", initiative: "Assist individuals to secure and maintain employemnt", webURL: "https://www.acdnonline.org/locations", category: .career)
        let jailsToJob = Recycle(storeName: "Jails to Jobs", initiative: "Free Interview Clothes", webURL: "https://jailstojobs.org/free-interview-clothes/", category: .career)
    
        let braRecyclers = Recycle(storeName: "The Bra Recyclers", initiative: "Bra-volution", webURL: "https://www.brarecycling.com/", category: .bras)
        let soma = Recycle(storeName: "Soma Boutique", initiative: "#BRAITFORWARD", webURL: "https://www.soma.com/store/page/soma+bra+donation/56709275/", category: .bras)
    
        let angelGown = Recycle(storeName: "Angel Gown", initiative: "NICU Helping Hands - provides comfort for bereaved families through the gift of a beautiful custom made gown for final photos and for burial services", webURL: "https://www.nicuhelpinghands.org/programs/angel-gown-program/", category: .wedding)
        let bridesAcrossAmmerica = Recycle(storeName: "Brides Across America", initiative: "Committed to loving one another by gifting wedding gowns to military & first responders", webURL: "https://www.bridesacrossamerica.com/giving/give-a-dress", category: .wedding)
        let beccasCloset = Recycle(storeName: "Becca's Closet", initiative: "Little Things Can Make A Big Difference", webURL: "https://www.beccascloset.org/beccas-closet-chapters/", category: .prom
)
    
    func loadContent() -> [[Recycle]] {
        guard let user = user else {
            
            // clothes, denim, clothes & shoes, shoes, career, bras, wedding gowns, prom dresses, default
            
            return [[hAndM, theNorthFace, eileenFisher, zara, oneWarmCoat], [levis, madeWell, cotton], [americanEagle, zappos], [nike, soles4Souls, dsw], [dressForSuccess, careerGear, acdn, jailsToJob], [braRecyclers, soma], [angelGown, bridesAcrossAmmerica], [beccasCloset]] }
        if user.isMale == true {
            return [[hAndM, theNorthFace], [levis, madeWell, cotton, oneWarmCoat], [americanEagle, zappos], [nike, soles4Souls, dsw], [dressForSuccess, careerGear, acdn, jailsToJob]]
        } else {
            return [[hAndM, theNorthFace, oneWarmCoat, eileenFisher, zara], [levis, madeWell, cotton], [americanEagle, zappos], [nike, soles4Souls, dsw], [dressForSuccess, careerGear, acdn], [braRecyclers, soma], [angelGown, bridesAcrossAmmerica], [beccasCloset]]
        }
    }
    
    var recyclePlaces: [Recycle] = []
}
