//
//  File.swift
//  MovieToWatch
//
//  Created by Clark on 8/3/20.
//  Copyright © 2020 Hongfei Yang. All rights reserved.
//

import UIKit

class MovieCollectionController: BaseCollectionViewController {
    
    var dataSource: [BaseMovieResult]? {
        didSet {
            DispatchQueue.main.async { self.collectionView.reloadData() }
        }
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        title = "Title"
        collectionView.register(IndividualMovieCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! IndividualMovieCell
        cell.movieItem = dataSource?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 100, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    
}
