//
//  SPCollectionView.swift
//  Friends
//
//  Created by Md. Mamun-Ur-Rashid on 5/21/21.
//

import UIKit

class SPCollectionView: UICollectionView {
    
    var items = [Any]()
    var numberOfColumn: CGFloat = 2
    var minimumInteritemSpacing: CGFloat = 10.0
    var minimumLineSpacing: CGFloat = 10.0
    var flowLayout: UICollectionViewFlowLayout?
    var cellObservers: NSMutableArray = []

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setUpView()
    }

    /// Initialize collectionview
    func setUpView() {
        self.setUpCollectionViewLayoutForDisplay()
        self.registerXibForDisplay()
    }

    /// Initialize collectionview layout for display
    func setUpCollectionViewLayoutForDisplay() {
        self.flowLayout = UICollectionViewFlowLayout.init()
        self.collectionViewLayout = self.flowLayout!
    }

    /// Register xibs
    func registerXibForDisplay() {
        // Must override at child class
    }

    /// Reset all informations
    func resetInformation() {
        if self.items.count > 0 {
            self.items.removeAll()
            self.reloadData()
            self.collectionViewLayout.invalidateLayout()
        }
    }

    /// Add Items into display view
    ///
    /// - Parameter items: Image list
    func addItems(items: [Any]?) {
        self.resetInformation()
        if let selectedItems = items, selectedItems.count > 0 {
            self.items.append(contentsOf: selectedItems)
        }
    }

}
