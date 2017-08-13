//
//  FoodPriceInfo.swift
//  TechnicheEComTest
//
//  Created by Kulkarni on 14/08/17.
//  Copyright © 2017 Shrilakshmi Kulkarni. All rights reserved.
//

import Foundation

struct FoodPriceInfo {
    
    let priceOfEach: Double
    let region: String
    let tax: Double
    
    init(json: JSON) {
        

        self.priceOfEach = json["amount"] as! Double
        self.region = json["region"] as! String
        self.tax = json["tax"] as! Double
        
    }
}
