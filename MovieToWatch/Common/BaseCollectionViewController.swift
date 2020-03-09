//
//  BaseCollectionViewController.swift
//  MovieToWatch
//
//  Created by Clark on 8/3/20.
//  Copyright © 2020 Hongfei Yang. All rights reserved.
//

import UIKit

class BaseCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    init() {
        let layout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.contentInsetAdjustmentBehavior = .never
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var topPosterWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    var topPosterHeight: CGFloat {
        return topPosterWidth * 3/2
    }
}

