//
//  PersonTrendingSectionCell.swift
//  MovieToWatch
//
//  Created by Clark on 12/3/20.
//  Copyright © 2020 Hongfei Yang. All rights reserved.
//

import UIKit

class PersonTrendingSectionCell: BaseTrendingSectionCell {

    var dataSource: [PersonMultiSearchResult]? {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    weak var navController: UINavigationController?
    
    private let cellId = "cellId"
    
    override func setupCollectionView() {
        let layout = BetterSnappingLayout()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = .init(top: 0, left: 10, bottom: 0, right: 10)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(TrendingPersonCell.self, forCellWithReuseIdentifier: cellId)
        //collectionView.constrainHeight(constant: 100)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
        addSubview(collectionView)
        collectionView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! TrendingPersonCell
        cell.result = dataSource?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let result = dataSource?[indexPath.item]
        
        if let id = result?.id {
            let vc = PersonContainerController()
            vc.personId = id
            vc.hidesBottomBarWhenPushed = true
            navController?.pushViewController(vc, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let tempSize = CGSize.init(width: 1000, height: collectionView.frame.height)
//        let cell = TrendingPersonCell(frame: .init(origin: .zero, size: tempSize))
//        cell.result = dataSource?[indexPath.item]
//        cell.layoutIfNeeded()
//        let size = cell.systemLayoutSizeFitting(tempSize)
        return .init(width: 60, height: collectionView.frame.height)
    }
}
