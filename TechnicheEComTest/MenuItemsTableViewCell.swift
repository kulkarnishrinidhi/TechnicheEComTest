//
//  MenuItemsTableViewCell.swift
//  TechnicheEComTest
//
//  Created by Kulkarni on 13/08/17.
//  Copyright © 2017 Shrilakshmi Kulkarni. All rights reserved.
//

import UIKit

let segueToCheckoutVC = Notification.Name.init("segueToCheckoutVC")

class MenuItemsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var itemCost: UILabel!
    @IBOutlet weak var itemQuantity: UILabel!
    
    var item: FoodCategoryItem?
    
    func render(item: FoodCategoryItem) {
        self.item = item
        self.itemTitle.text = ""
        self.itemCost.text = ""
        self.itemQuantity.text = ""
        
        itemTitle.text = item.name
        if let price = item.prices.first?.priceOfEach {
            itemCost.text = String(describing: price)
        } else {
            itemCost.text = "Not given"
        }
        itemQuantity.text = "100 gm"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    static func cellIdentifier() -> String {
        return "MenuItemsTableViewCell"
    }
    
    
    static func nib() -> UINib {
        return UINib(nibName: "MenuItemsTableViewCell", bundle: nil)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.containerView.layer.cornerRadius = 2.0
        self.containerView.layer.borderColor = UIColor.gray.cgColor
        self.containerView.layer.borderWidth = 1.0
    }
    
    @IBAction func addItemAction(_ sender: RoundButton) {
        NotificationCenter.default.post(name: segueToCheckoutVC, object: item, userInfo: nil)
    }
    
}
