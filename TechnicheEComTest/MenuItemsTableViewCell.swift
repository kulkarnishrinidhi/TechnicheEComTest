//
//  MenuItemsTableViewCell.swift
//  TechnicheEComTest
//
//  Created by Kulkarni on 13/08/17.
//  Copyright © 2017 Shrilakshmi Kulkarni. All rights reserved.
//

import UIKit

class MenuItemsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var containerView: UIView!
    
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
    
    
}
