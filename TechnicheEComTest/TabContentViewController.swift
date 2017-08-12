//
//  TabContentViewController.swift
//  LynxStudy
//
//  Created by Kulkarni on 02/08/17.
//  Copyright © 2017 Mahabaleshwar Hegde. All rights reserved.
//

import UIKit

protocol TabContentViewDelegate: class {
    
    func tabContentView(setUp collectionView: UICollectionView, viewController: TabContentViewController)
    
    func numberOfItemsInTabContentCollectionView() -> Int
    
    func tabContentView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    
    func tabContentView(didMoveCellAt indexPath: IndexPath)
}


class TabContentViewController: UIViewController {

    @IBOutlet weak var tabContentCollectionView: UICollectionView!
    
    weak var tabContentViewDelegate: TabContentViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupCollectionView()
    }
}


extension TabContentViewController {
    
    func selecctItemAt(indexPath: IndexPath) {
        print(indexPath.row)
        self.tabContentCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        //collectionView(self.tabContentCollectionView, didSelectItemAt: indexPath)
    }
    
    func setupCollectionView() {
        self.tabContentViewDelegate?.tabContentView(setUp: self.tabContentCollectionView, viewController: self)
    }
    
    func checkIfCellIsVisible() {
        let visibleIndexPaths = self.tabContentCollectionView.indexPathsForVisibleItems
        for indexPath in visibleIndexPaths {
            print(indexPath.row)
            self.tabContentViewDelegate?.tabContentView(didMoveCellAt: indexPath)
        }
    }
}


extension TabContentViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let delegate = self.tabContentViewDelegate else {
            fatalError("set delegate")
        }
        return delegate.tabContentView(collectionView, cellForItemAt: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let delegate = self.tabContentViewDelegate else {
            return 0
        }
        return delegate.numberOfItemsInTabContentCollectionView()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}


extension TabContentViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
}


extension TabContentViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //checkIfCellIsVisible()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        checkIfCellIsVisible()
    }
}



