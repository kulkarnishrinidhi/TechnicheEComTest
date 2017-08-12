//
//  TabCollectionViewCell.swift
//  TechnicheEComTest
//
//  Created by Kulkarni on 11/08/17.
//  Copyright © 2017 Shrilakshmi Kulkarni. All rights reserved.
//

import UIKit

class TabCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var tabTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    static func cellIdentifier() -> String {
        return "TabCollectionViewCell"
    }

    static func nib() -> UINib {
        return UINib(nibName: "TabCollectionViewCell", bundle: nil)
    }
}
