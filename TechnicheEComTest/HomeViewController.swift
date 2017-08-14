//
//  ViewController.swift
//  TechnicheEComTest
//
//  Created by Kulkarni on 11/08/17.
//  Copyright © 2017 Shrilakshmi Kulkarni. All rights reserved.
//

import UIKit

enum ContainerSegue: String {
    case topTabBarSegue
    case tabContentSegue
    case checkOutSegue
}

let dataFetchFinishNotification = Notification.Name.init(rawValue: "dataFetchFinishNotification")



class HomeViewController: UIViewController {
    
    var topTabBarViewController: TopTabBarViewController!
    var tabContentViewController: TabContentViewController!
    
    var checkoutItem: FoodCategoryItem?
    
    
    fileprivate var foodMenus:[FoodMenu] = [] {
        didSet {
            self.topTabBarViewController.refreshView()
            self.tabContentViewController.tabContentCollectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let dataManager = DataManager()
        dataManager.getProductList { (foodMenus, error) in
            self.foodMenus = foodMenus?.reversed() ?? []
            if self.foodMenus.count > 0 {
                self.postDataUpdateNotification(with: self.foodMenus[0].categories)
            }
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.segueToVC(notification:)), name: segueToCheckoutVC, object: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let segueIdentifier = ContainerSegue(rawValue: segue.identifier!) else {
            fatalError("set segue identifier")
        }
        
        switch segueIdentifier {
        case .tabContentSegue:
            self.tabContentViewController = segue.destination as! TabContentViewController
            self.tabContentViewController.tabContentViewDelegate = self
        case .topTabBarSegue:
            topTabBarViewController = segue.destination as! TopTabBarViewController
            topTabBarViewController.tabBarDelegate = self
        case .checkOutSegue:
            print("segue to checkout vc")
        }
    }
    
    
    func getRandomColor() -> UIColor {
        let randomRed:CGFloat = CGFloat(drand48())
        let randomGreen:CGFloat = CGFloat(drand48())
        let randomBlue:CGFloat = CGFloat(drand48())
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
}

//MARK:- Navigation Methods

extension HomeViewController {
    
    func segueToVC(notification: Notification) {
        guard let checkoutItem = notification.object as? FoodCategoryItem else { return }
        self.checkoutItem = checkoutItem
        self.performSegue(withIdentifier: ContainerSegue.checkOutSegue.rawValue, sender: nil)
        //self.tableView.reloadData()
    }

}

//MARK:- TopTabBarViewDelegate

extension HomeViewController: TopTabBarViewDelegate {
    
    func topTabBarView(didSelectItemAt indexPath: IndexPath) {
        
        self.tabContentViewController.selecctItemAt(indexPath: indexPath)
        //Update the data once tabcontent refreshed. so give 0.1 seconds delay.
        if self.foodMenus.indices.contains(indexPath.row) {
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false, block: { _ in
              self.postDataUpdateNotification(with: self.foodMenus[indexPath.row].categories)    
            })
        }
    }
    
    func topTabBarView(configure tabCollectionViewCell: TabCollectionViewCell, at indexPath: IndexPath) {
        
        tabCollectionViewCell.tabTitleLabel.text = self.foodMenus[indexPath.row].name
    }
    
    func numberOfItemsInTopTabBar() -> Int {
        return self.foodMenus.count
    }
    
    func topTabBarView(seizForItem at: IndexPath, collectionView: UICollectionView) -> CGSize {
        
        let contentInset = collectionView.contentInset
        let  hieght = collectionView.frame.height - (contentInset.top + contentInset.bottom)
        let font = UIFont.systemFont(ofSize: 18.0, weight: UIFontWeightSemibold)
        let width = self.foodMenus[at.row].name.width(constraintedHieght: hieght, font: font) + 16.0
        return CGSize(width: width, height: hieght)
    }
}

//MARK:- TabContentViewDelegate

extension HomeViewController: TabContentViewDelegate {
    
    func tabContentView(setUp collectionView: UICollectionView, viewController: TabContentViewController) {
        collectionView.delegate = viewController
        collectionView.dataSource = viewController
        collectionView.isPagingEnabled = true
        
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.minimumLineSpacing = 0
        }
        
        collectionView.register(SweetsCollectionViewCell.nib(), forCellWithReuseIdentifier: SweetsCollectionViewCell.cellIdentifier())
        collectionView.reloadData()
        
    }
    
    
    func numberOfItemsInTabContentCollectionView() -> Int {
        return self.foodMenus.count
    }
    
    func tabContentView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SweetsCollectionViewCell.cellIdentifier(), for: indexPath) as! SweetsCollectionViewCell
        
        //cell.backgroundColor = getRandomColor()
        return cell
    }
    
    func tabContentView(didMoveCellAt indexPath: IndexPath) {
        self.topTabBarViewController.selectItemAt(indexPath: indexPath)
        if self.foodMenus.indices.contains(indexPath.row) {
            self.postDataUpdateNotification(with: self.foodMenus[indexPath.row].categories)
        }
    }
    
    func postDataUpdateNotification(with categories: [FoodMenuCategory]) {
        DispatchQueue.main.async(execute: {
            NotificationCenter.default.post(name: dataFetchFinishNotification, object: categories, userInfo: nil)
        })
    }
}
