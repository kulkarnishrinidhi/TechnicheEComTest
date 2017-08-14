//
//  FoodMenuCategories.swift
//  TechnicheEComTest
//
//  Created by Kulkarni on 14/08/17.
//  Copyright © 2017 Shrilakshmi Kulkarni. All rights reserved.
//

import Foundation


struct FoodMenuCategory {
    
    let id: String
    let name: String
    let type: FoodMenuType
    let status: Bool
    private(set) var items: [FoodCategoryItem] = []
    
    var sectionId: Int = -1
    var expanded: Bool = false
    
    init(json: [String: Any]) {
        self.id = json["_id"] as! String
        self.type = FoodMenuType(rawValue: (json["type"] as! String).uppercased())!
        self.status = json["status"] as! Bool
        self.name = json["name"] as! String
        if let items = json["products"] as? [[String: Any]] {
            self.items = items.flatMap(FoodCategoryItem.init)
        }
    }
}
