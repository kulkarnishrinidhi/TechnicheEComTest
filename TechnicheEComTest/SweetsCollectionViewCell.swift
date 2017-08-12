//
//  SweetsCollectionViewCell.swift
//  TechnicheEComTest
//
//  Created by Kulkarni on 11/08/17.
//  Copyright © 2017 Shrilakshmi Kulkarni. All rights reserved.
//

import UIKit

class SweetsCollectionViewCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    static func cellIdentifier() -> String {
        return "SweetsCollectionViewCell"
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "SweetsCollectionViewCell", bundle: nil)
    }
}
