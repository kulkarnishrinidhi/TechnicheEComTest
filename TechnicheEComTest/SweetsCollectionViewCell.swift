
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
    
    let expandableViewIdentifier = String(describing: ExpandableHeaderView.self)
    
    var foodMenuCategories: [FoodMenuCategory] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(MenuItemsTableViewCell.nib(), forCellReuseIdentifier: MenuItemsTableViewCell.cellIdentifier())
        self.tableView.register(UINib(nibName: expandableViewIdentifier, bundle: nil), forHeaderFooterViewReuseIdentifier: expandableViewIdentifier)
        self.tableView.estimatedSectionHeaderHeight = 100
        self.tableView.sectionHeaderHeight = UITableViewAutomaticDimension
        
        NotificationCenter.default.addObserver(self, selector: #selector(SweetsCollectionViewCell.refreshView(notification:)), name: dataFetchFinishNotification, object: nil)
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: dataFetchFinishNotification, object: nil)
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
        return self.foodMenuCategories.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.foodMenuCategories[section].expanded {
            return self.foodMenuCategories[section].items.count
        } else {
            return 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.foodMenuCategories[indexPath.section].expanded {
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
        var currentFoodSection = self.foodMenuCategories[section]
        currentFoodSection.sectionId = section
        header.category = currentFoodSection
        header.delegate = self
        return header
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuItemsTableViewCell.cellIdentifier()) as! MenuItemsTableViewCell
        let item = self.foodMenuCategories[indexPath.section].items[indexPath.row]
        cell.render(item: item)
        return cell
    }
    
    
    func toggleSection(header: ExpandableHeaderView, forSection section: FoodMenuCategory) {
        let id = section.sectionId
        self.foodMenuCategories[id].expanded = !self.foodMenuCategories[id].expanded
        self.tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("section = \(indexPath.section),, row = \(indexPath.row)")
    }
    
    
    func refreshView(notification: Notification) {
        guard let foodMenuObject = notification.object as? [FoodMenuCategory] else { return }
        self.foodMenuCategories = foodMenuObject
        //self.tableView.reloadData()
    }
    
}













