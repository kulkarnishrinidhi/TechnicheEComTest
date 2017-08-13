//
//  FoodICategorytem.swift
//  TechnicheEComTest
//
//  Created by Kulkarni on 14/08/17.
//  Copyright © 2017 Shrilakshmi Kulkarni. All rights reserved.
//

import Foundation


struct FoodCategoryItem {
    
    let id: String
    let category: String
    let code: Int?
    let name: String
    private(set) var prices: [FoodPriceInfo] = []
    
    init(json: JSON) {
        
        self.id = json["_id"] as! String
        self.category = json["category"] as! String
        self.code = json["code"] as? Int
        self.name = json["name"] as! String
        if let items = json["prices"] as? [[String: Any]] {
            self.prices = items.flatMap(FoodPriceInfo.init)
        }
    }
}
