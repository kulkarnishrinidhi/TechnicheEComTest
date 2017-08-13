//
//  ExpandableHeaderView.swift
//  TableViewDropDown
//
//  Created by BriefOS on 5/3/17.
//  Copyright © 2017 BriefOS. All rights reserved.
//

import UIKit


protocol ExpandableHeaderViewDelegate {
    func toggleSection(header: ExpandableHeaderView, forSection section: Section)
}


class ExpandableHeaderView: UITableViewHeaderFooterView {
    
    @IBOutlet weak var dropDownButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak private var containerView: UIView!
    
    var delegate: ExpandableHeaderViewDelegate?
    var section: Section? {
        didSet {
            self.update(section: section!)
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
        delegate?.toggleSection(header: self, forSection: self.section!)
    }
    
    
    func selectHeaderAction(gestureRecognizer: UITapGestureRecognizer) {
        delegate?.toggleSection(header: self, forSection: self.section!)
    }
    
    func update(section: Section) {
        self.titleLabel?.text = section.genre
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }


}
