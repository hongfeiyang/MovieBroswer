//
//  MovieDetailViewController.swift
//  MovieToWatch
//
//  Created by Clark on 20/2/20.
//  Copyright © 2020 Hongfei Yang. All rights reserved.
//

import UIKit

class BaseCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    init() {
        let layout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: layout)
        self.collectionView.backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class MovieDetailViewController: BaseCollectionViewController {

    let creditsCellId = "creditsCellId"
    let imagesCellId = "imagesCellId"
    let videosCellId = "videosCellId"
    
    var movieDetail: MovieDetail?
    
    var movieId: Int! {
        didSet {
            let query = MovieDetailQuery(movieID: movieId)
            Network.getMovieDetail(query: query) { [weak self] (response) in
                guard let self = self else {return}
                self.movieDetail = response
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.register(CreditsSectionCell.self, forCellWithReuseIdentifier: creditsCellId)
        collectionView.register(ImagesSectionCell.self, forCellWithReuseIdentifier: imagesCellId)
        collectionView.register(VideosSectionCell.self, forCellWithReuseIdentifier: videosCellId)
        self.title = "TEST"
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell: MovieDetailSectionBaseCell!
        
        if indexPath.item == 0 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: creditsCellId, for: indexPath) as! CreditsSectionCell
        } else if indexPath.item == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: imagesCellId, for: indexPath) as! ImagesSectionCell
        } else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: videosCellId, for: indexPath) as! VideosSectionCell
        }
        cell.movieDetail = movieDetail
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var height: CGFloat = 280
        
        if indexPath.item == 0 {
            let dummyCell = CreditsSectionCell(frame: .init(x: 0, y: 0, width: collectionView.frame.width, height: 1000))
            dummyCell.movieDetail = movieDetail
            dummyCell.layoutIfNeeded()
            let estimatedSize = dummyCell.systemLayoutSizeFitting(.init(width: collectionView.frame.width, height: 1000))
            height = estimatedSize.height
        } else if indexPath.item == 1{
            let dummyCell = ImagesSectionCell(frame: .init(x: 0, y: 0, width: collectionView.frame.width, height: 1000))
            dummyCell.movieDetail = movieDetail
            dummyCell.layoutIfNeeded()
            let estimatedSize = dummyCell.systemLayoutSizeFitting(.init(width: collectionView.frame.width, height: 1000))
            height = estimatedSize.height
        } else {
            let dummyCell = VideosSectionCell(frame: .init(x: 0, y: 0, width: collectionView.frame.width, height: 1000))
            dummyCell.movieDetail = movieDetail
            dummyCell.layoutIfNeeded()
            let estimatedSize = dummyCell.systemLayoutSizeFitting(.init(width: collectionView.frame.width, height: 1000))
            height = estimatedSize.height
        }

        return .init(width: collectionView.frame.width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
}
