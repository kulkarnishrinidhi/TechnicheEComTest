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
    func topTabBarView(seizForItem at: IndexPath, collectionView: UICollectionView) -> CGSize
}

protocol ItemSelectable {
    func selectItemAt(indexPath: IndexPath)
}

class TopTabBarViewController: UIViewController {

    @IBOutlet weak var tabBarCollectionView: UICollectionView!
    
    weak var tabBarDelegate: TopTabBarViewDelegate?
    
    var highlightView = UIView()
    
    fileprivate let highlightedViewHieght:CGFloat = 3.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpCollectionView()
        self.setupHighLightView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.updateHighlightedViewIfNeeded()
    }
}


extension TopTabBarViewController {
    
    func setUpCollectionView() {
        self.tabBarCollectionView.dataSource = self
        self.tabBarCollectionView.delegate = self
        self.tabBarCollectionView.allowsSelection = true
        
        self.tabBarCollectionView.register(TabCollectionViewCell.nib(), forCellWithReuseIdentifier: TabCollectionViewCell.cellIdentifier())
    

    }
    
    
    func setupHighLightView() {
        let highlightedViewY = self.tabBarCollectionView.frame.height - highlightedViewHieght
        let defaultFrame = CGRect(x: 0, y: highlightedViewY, width: 0.0, height: self.highlightedViewHieght)
        self.highlightView.frame = defaultFrame
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
        if indexPath.row == 0 {
          self.updateHighlightedViewIfNeeded()
        }
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
}


extension TopTabBarViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return (tabBarDelegate?.topTabBarView(seizForItem: indexPath, collectionView: collectionView))!
    }
    
}

extension TopTabBarViewController {
    
    func refreshView() {
        self.tabBarCollectionView.reloadData()
        self.perform(#selector(self.updateHighlightedViewIfNeeded), with: nil, afterDelay: 0.1)
    }
    
    func updateHighlightedViewIfNeeded() {
        let firstIndexPath = IndexPath(item: 0, section: 0)
        guard let cell = self.tabBarCollectionView.cellForItem(at: firstIndexPath) else { return }
        self.updateHighlightedView(forCell: cell)
    }
    
}


extension String {
    
    func width(constraintedHieght hieght: CGFloat, font: UIFont, width: CGFloat = .greatestFiniteMagnitude) -> CGFloat {
        let label =  UILabel(frame: CGRect(x: 0, y: 0, width: width, height: hieght))
        label.numberOfLines = 0
        label.text = self
        label.font = font
        return label.intrinsicContentSize.width
    }
    
}
