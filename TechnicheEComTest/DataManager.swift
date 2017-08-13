//
//  DataManager.swift
//  TechnicheEComTest
//
//  Created by Kulkarni on 13/08/17.
//  Copyright © 2017 Shrilakshmi Kulkarni. All rights reserved.
//

import Foundation


enum DataManagerError: Error {
    case unknown
    case failedRequest
    case invalidResponse
    case jsonParseError
}


final class DataManager {
    
    typealias ApiDataCompletion = ([FoodMenu]?, DataManagerError?) -> ()
    
    private let apiURL = URL(string: "http://35.154.42.68/testing/productList")!
    
    func getProductList(completion: @escaping ApiDataCompletion) {
        let dataTask = URLSession.shared.dataTask(with: apiURL) { (data, response, error) in
            DispatchQueue.main.async {
                self.didFetchFoodData(data: data, response: response, error: error, completion: completion)
            }
        }
        
        dataTask.resume()
    }
    
    
    func didFetchFoodData(data: Data?, response: URLResponse?, error: Error?, completion: ApiDataCompletion) {
        
        if let _ = error {
            completion(nil, .failedRequest)
        } else if let data = data, let _ = response as? HTTPURLResponse {
            do {
                guard let jsonArray = try JSONSerialization.jsonObject(with: data, options: .init(rawValue: 0)) as? [[String: Any]] else {
                   return completion(nil, .jsonParseError)
                }
                let mainFoodCategories = jsonArray.filter({ $0["type"] as! String == "MAIN"})
                let foodMenus = mainFoodCategories.flatMap(FoodMenu.init)
                completion(foodMenus, nil)
                
            } catch  {
                completion(nil, .jsonParseError)
            }
        } else {
            completion(nil, .unknown)
        }
    }
    
}
