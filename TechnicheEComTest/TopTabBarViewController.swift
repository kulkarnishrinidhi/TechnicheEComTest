//
//  TopTabBarViewController.swift
//  LynxStudy
//
//  Created by Kulkarni on 02/08/17.
//  Copyright © 2017 Mahabaleshwar Hegde. All rights reserved.
//

import UIKit

protocol TopTabBarViewDelegate: class {
    func numberOfItemsInTopTabBar() -> Int
    func topTabBarView(configure tabCollectionViewCell : TabCollectionViewCell, at indexPath : IndexPath)
    func topTabBarView(didSelectItemAt indexPath: IndexPath)
}

protocol ItemSelectable {
    func selectItemAt(indexPath: IndexPath)
}

class TopTabBarViewController: UIViewController {

    @IBOutlet weak var tabBarCollectionView: UICollectionView!
    
    weak var tabBarDelegate: TopTabBarViewDelegate?
    
    var highlightView = UIView()
    
    fileprivate let highlightedViewHieght:CGFloat = 2.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpCollectionView()
        self.setupHighLightView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
//        if indexPath.row == 0 {
//            
//        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let tabCounts = self.tabBarDelegate?.numberOfItemsInTopTabBar(), tabCounts > 0 else { return  }
        let firstIndexPath = IndexPath(item: 0, section: 0)
        let cell = self.tabBarCollectionView.cellForItem(at: firstIndexPath)!
        self.updateHighlightedView(forCell: cell)
    }
}


extension TopTabBarViewController {
    
    func setUpCollectionView() {
        self.tabBarCollectionView.dataSource = self
        self.tabBarCollectionView.delegate = self
        self.tabBarCollectionView.isPagingEnabled = true
        self.tabBarCollectionView.allowsSelection = true
        
        self.tabBarCollectionView.register(TabCollectionViewCell.nib(), forCellWithReuseIdentifier: TabCollectionViewCell.cellIdentifier())
        
        if let flowLayout = self.tabBarCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.minimumInteritemSpacing = 10
            flowLayout.estimatedItemSize = CGSize(width: 40, height: self.tabBarCollectionView.frame.height)
            flowLayout.itemSize = UICollectionViewFlowLayoutAutomaticSize
            
        }
    }
    
    func setupHighLightView() {
        
        let highlightedViewY = self.tabBarCollectionView.frame.height - highlightedViewHieght
        let defaultFrame = CGRect(x: 0, y: highlightedViewY, width: 0.0, height: highlightedViewHieght)
        self.highlightView.frame = defaultFrame
        highlightView.frame = defaultFrame
        highlightView.backgroundColor = UIColor(red: 237.0/255.0, green: 175.0/255.0, blue: 54.0/255.0, alpha: 1.0)
        self.tabBarCollectionView.addSubview(highlightView)
    }
    
    func updateHighlightedView(forCell cell: UICollectionViewCell) {
        UIView.animate(withDuration: 0.3) {
            self.highlightView.frame.origin.x = cell.frame.origin.x
            self.highlightView.frame.size = CGSize(width: cell.frame.width, height: self.highlightedViewHieght)
            self.highlightView.layoutIfNeeded()
        }
    }
    
    func selectItemAt(indexPath: IndexPath) {
        let cell = self.tabBarCollectionView.cellForItem(at: indexPath)!
        UIView.animate(withDuration: 0.1) {
            self.highlightView.frame.origin.x = cell.frame.origin.x
        }
        self.tabBarCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
    }
}


extension TopTabBarViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let tabBarDelegate = self.tabBarDelegate else {
            return 0
        }
        return tabBarDelegate.numberOfItemsInTopTabBar()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TabCollectionViewCell.cellIdentifier(), for: indexPath) as! TabCollectionViewCell
        //cell.tabTitleLabel.preferredMaxLayoutWidth = 70
        self.tabBarDelegate?.topTabBarView(configure: cell, at: indexPath)
        //Set the initial state of highlighted view
        
        return cell
    }
    
    
}


extension TopTabBarViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)!
        self.updateHighlightedView(forCell: cell)
        self.tabBarDelegate?.topTabBarView(didSelectItemAt: indexPath)
    }
    
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return (arrayOfStats[indexPath.row] as? String)?.size(attributes: nil)!
//    }
}

