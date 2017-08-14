//
//  ExpandableHeaderView.swift
//  TableViewDropDown
//
//  Created by BriefOS on 5/3/17.
//  Copyright © 2017 BriefOS. All rights reserved.
//

import UIKit


protocol ExpandableHeaderViewDelegate {
    func toggleSection(header: ExpandableHeaderView, forSection section: FoodMenuCategory)
}


class ExpandableHeaderView: UITableViewHeaderFooterView {
    
    @IBOutlet weak var dropDownButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak private var containerView: UIView!
    
    var delegate: ExpandableHeaderViewDelegate?
    var category: FoodMenuCategory? {
        didSet {
            self.update(section: category!)
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.commonInit()
    }
    
    
    private func commonInit() {
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectHeaderAction)))
        self.layer.cornerRadius = 1.0
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.gray.cgColor
    }
    
    
    @IBAction func dropDownAction(_ sender: Any) {
        delegate?.toggleSection(header: self, forSection: self.category!)
    }
    
    
    func selectHeaderAction(gestureRecognizer: UITapGestureRecognizer) {
        delegate?.toggleSection(header: self, forSection: self.category!)
    }
    
    
    func update(section: FoodMenuCategory) {
        self.titleLabel?.text = category?.name
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }


}
