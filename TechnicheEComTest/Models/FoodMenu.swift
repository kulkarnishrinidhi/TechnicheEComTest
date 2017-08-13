//
//  FoodMenu.swift
//  TechnicheEComTest
//
//  Created by Kulkarni on 14/08/17.
//  Copyright © 2017 Shrilakshmi Kulkarni. All rights reserved.
//

import Foundation

typealias JSON = [String:Any]

enum FoodMenuType: String {
    case main = "MAIN"
    case sub = "SUB"
}

struct FoodMenu {
    
    let id: String
    let type: FoodMenuType
    let menuOrderId: Int
    let status: Bool
    let name: String
    private(set) var categories: [FoodMenuCategory] = []
    
    
    init(json: JSON) {
        self.id = json["_id"] as! String
        self.name = json["name"] as! String
        self.type = FoodMenuType(rawValue: (json["type"] as! String).uppercased())!
        self.menuOrderId = json["menuOrder"] as! Int
        self.status = json["status"] as! Bool
        if let childerns = json["childrens"] as? [[String: Any]] {
            self.categories = childerns.flatMap(FoodMenuCategory.init)
        }
    }
}
