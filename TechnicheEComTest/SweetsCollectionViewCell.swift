//
//  SweetsCollectionViewCell.swift
//  TechnicheEComTest
//
//  Created by Kulkarni on 11/08/17.
//  Copyright © 2017 Shrilakshmi Kulkarni. All rights reserved.
//

import UIKit


class SweetsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var tableView: UITableView!
    
    var sections = [
        Section(genre: "Assorted",
                movies: ["The Lion King", "The Incredibles"],
                expanded: false),
        Section(genre: "Bengali Sweets",
                movies: ["Guardians of the Galaxy", "The Flash", "The Avengers", "The Dark Knight"],
                expanded: false),
        Section(genre: "Apple Rasagulla",
                movies: ["The Walking Dead", "Insidious", "Conjuring"],
                expanded: false)
    ]
    
    let expandableViewIdentifier = String(describing: ExpandableHeaderView.self)
    
    let foodMenuCategories: [FoodMenuCategory] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(MenuItemsTableViewCell.nib(), forCellReuseIdentifier: MenuItemsTableViewCell.cellIdentifier())
        self.tableView.register(UINib(nibName: expandableViewIdentifier, bundle: nil), forHeaderFooterViewReuseIdentifier: expandableViewIdentifier)
        //self.tableView.estimatedRowHeight = self.tableView.rowHeight
        //self.tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    static func cellIdentifier() -> String {
        return "SweetsCollectionViewCell"
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "SweetsCollectionViewCell", bundle: nil)
    }
}


extension SweetsCollectionViewCell: UITableViewDataSource, UITableViewDelegate, ExpandableHeaderViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if sections[section].expanded {
            return sections[section].movies.count
        } else {
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (sections[indexPath.section].expanded) {
            return 80
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 4
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView(frame: .zero)
        return view
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: expandableViewIdentifier) as! ExpandableHeaderView
        var currentSection = self.sections[section]
        currentSection.sectionId = section
        header.section = currentSection
        header.delegate = self
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuItemsTableViewCell.cellIdentifier()) as! MenuItemsTableViewCell
        //cell.itemLabel.text = sections[indexPath.section].movies[indexPath.row]
        return cell
    }
    
    
    func toggleSection(header: ExpandableHeaderView, forSection section: Section) {
        let id = section.sectionId
        sections[id].expanded = !sections[id].expanded
        self.tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("section = \(indexPath.section),, row = \(indexPath.row)")
    }
    
    
    
}













