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
}

class HomeViewController: UIViewController {

    var topTabBarViewController: TopTabBarViewController!
    var tabContentViewController: TabContentViewController!
    
    let menuLabels = ["Sweets", "Chat", "Rice", "Juice", "Roti", "Deserts", "Abcdefgh", "xyzqwer"]
    override func viewDidLoad() {
        super.viewDidLoad()
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
        }
    }
    
    
    func getRandomColor() -> UIColor {
        let randomRed:CGFloat = CGFloat(drand48())
        let randomGreen:CGFloat = CGFloat(drand48())
        let randomBlue:CGFloat = CGFloat(drand48())
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
}


extension HomeViewController: TopTabBarViewDelegate {
    
    func topTabBarView(didSelectItemAt indexPath: IndexPath) {
        // TODO: Implement delegates to content view
        self.tabContentViewController.selecctItemAt(indexPath: indexPath)
    }
    
    func topTabBarView(configure tabCollectionViewCell: TabCollectionViewCell, at indexPath: IndexPath) {
        // TODO: Fetch the values and configure cell
        if indexPath.row == 0 {
            tabCollectionViewCell.tabTitleLabel.text = "Mahabaleshwar"
        } else {
            tabCollectionViewCell.tabTitleLabel.text = "Hegde"
        }
        tabCollectionViewCell.tabTitleLabel.text = menuLabels[indexPath.row]
    }
    
    func numberOfItemsInTopTabBar() -> Int {
        // TODO: Fetch data and return proper value
        return menuLabels.count
    }
}


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
        // TODO: Fetch data and return proper value
        return menuLabels.count
    }
    
    func tabContentView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SweetsCollectionViewCell.cellIdentifier(), for: indexPath) as! SweetsCollectionViewCell
        cell.backgroundColor = getRandomColor()
        return cell
    }
    
    func tabContentView(didMoveCellAt indexPath: IndexPath) {
        self.topTabBarViewController.selectItemAt(indexPath: indexPath)
    }
}
