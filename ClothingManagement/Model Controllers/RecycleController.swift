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
    
        let levis = Recycle(storeName: "Levi Strauss & Co.", initiative: "Unzipped", webURL: "https://www.levistrauss.com/2015/07/21/clothing-recycling-us-expansion/" , category: .denim)
    
        let madeWell = Recycle(storeName: "Madewell", initiative: "Blue Jeans Go Green", webURL: "https://www.madewell.com/inspo-do-well-denim-recycling-landing.html", category: .denim)
        let cotton = Recycle(storeName: "Cotton", initiative: "Blue Jeans Go Gree", webURL: "https://bluejeansgogreen.org/recycle-denim/", category: .denim)
    
        let americanEagle = Recycle(storeName: "American Eagle", initiative: "I:CO", webURL: "https://bluejeansgogreen.org/recycle-denim/", category: .clothesAndShoes)
    
        let zappos = Recycle(storeName: "Zappos", initiative: "Zappos for Good", webURL: "https://zapposforgood.org/give", category: .clothesAndShoes)
    
        let nike = Recycle(storeName: "Nike", initiative: "Nike Reuse-A-Shoe", webURL: "https://www.nike.com/us/en_us/c/better-world/reuse-a-shoe.%20", category: .shoes)
    
        let soles4Souls = Recycle(storeName: "Soles 4 Souls", initiative: "Wearing Out Poverty", webURL: "https://soles4souls.org/get-involved/give-shoes/donate/#larger-donations", category: .shoes)
    
        let dsw = Recycle(storeName: "DSW", initiative: "DSWGives + Soles 4 Souls", webURL: "https://www.dsw.com/en/us/content/give-a-pair", category: .shoes)
    
        let braRecyclers = Recycle(storeName: "The Bra Recyclers", initiative: "Bra-volution", webURL: "https://www.brarecycling.com/", category: .bras)
        let soma = Recycle(storeName: "Soma Boutique", initiative: "#BRAITFORWARD", webURL: "https://www.soma.com/store/page/soma+bra+donation/56709275/", category: .bras)
    

    
    
    func loadContent() -> [[Recycle]] {
        guard let user = user else { return [] }
        if user.isMale == true {
            return [[levis, madeWell, cotton], [hAndM, theNorthFace], [americanEagle, zappos], [nike, soles4Souls, dsw]]
        } else {
            return [[hAndM, theNorthFace, eileenFisher, zara], [levis, madeWell, cotton], [americanEagle, zappos], [nike, soles4Souls, dsw], [braRecyclers, soma]]
        }
    }
    
    var recyclePlaces: [Recycle] = []
}
