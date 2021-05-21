//
//  SPUsersContainer.swift
//  Friends
//
//  Created by Md. Mamun-Ur-Rashid on 5/21/21.
//

import UIKit

class SPUsersContainer: SPCollectionView {
    
    var detailsHandler: ((SPUserModel?) -> Void)?
    var calculatedCellWidth: CGFloat = 0.0
    var calculatedCellHeight: CGFloat = 0.0
    
    override func setUpView() {
        
        super.setUpView()
        self.numberOfColumn = 2
        self.minimumInteritemSpacing = 20.0
        self.minimumLineSpacing = 20.0
        self.dataSource = self
        self.delegate = self
        self.reloadData()
        
    }
    
    /// Register Xib Information
    override func registerXibForDisplay() {
        self.register(UINib(nibName: SPUserCell.className, bundle: Bundle.main), forCellWithReuseIdentifier: SPUserCell.className)
    }
    
    /// Set custom flow layout
    override func setUpCollectionViewLayoutForDisplay() {
        super.setUpCollectionViewLayoutForDisplay()
        self.flowLayout?.itemSize = CGSize.init(width: self.frame.size.width, height: self.frame.size.height)
        self.flowLayout?.scrollDirection = UICollectionView.ScrollDirection.vertical
    }
    
    /// Add user  information
    func addUserInformation(items: [SPUserModel]) {
        super.addItems(items: items)
        self.reloadData()
    }
    
}

// MARK: ---------- EXTENSION : SPUsersContainer(UICollectionViewDelegateFlowLayout) ----------
extension SPUsersContainer: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let padding = (self.numberOfColumn-1) * self.minimumInteritemSpacing
        let containerWidth = CGFloat(Int((self.bounds.width-padding) / self.numberOfColumn))
        let containerheight = (250/205.0) * containerWidth
        return CGSize.init(width: containerWidth, height: containerheight)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return self.minimumInteritemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return self.minimumLineSpacing
    }
    
}

// MARK: ---------- EXTENSION : SPUsersContainer(UICollectionViewDataSource) ----------
extension SPUsersContainer: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let user = self.items[indexPath.item] as? SPUserModel {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SPUserCell.className, for: indexPath as IndexPath) as? SPUserCell {
                cell.setInformation(information: user)
                cell.layoutIfNeeded()
                cell.setNeedsDisplay()
                return cell
            } else {
                return UICollectionViewCell()
            }
        } else {
            return UICollectionViewCell()
        }
        
    }
    
}

// MARK: ---------- EXTENSION : SPUsersContainer(UICollectionViewDelegate) ----------
extension SPUsersContainer: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedUseer = self.items[indexPath.item] as? SPUserModel
        self.detailsHandler?(selectedUseer)
    }
    
}

