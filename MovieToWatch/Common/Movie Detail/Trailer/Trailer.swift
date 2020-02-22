//
//  Trailer.swift
//  MovieToWatch
//
//  Created by Clark on 21/2/20.
//  Copyright © 2020 Hongfei Yang. All rights reserved.
//

import UIKit
import WebKit

class VideosSectionCell: MovieDetailSectionBaseCell {

    override var movieDetail: MovieDetail? {
        didSet {
            DispatchQueue.main.async { self.collectionView.reloadData() }
        }
    }

    var data: MovieVideos? {
        return movieDetail?.videos
    }

    var allVideosButton = BaseButton(topic: "Videos", content: "view all")
    
    lazy var collectionView: UICollectionView = {
        let layout = BetterSnappingLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.decelerationRate = .fast
        collectionView.contentInset = .init(top: 0, left: 10, bottom: 0, right: 10)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(VideosCell.self, forCellWithReuseIdentifier: "VideosCell")
        collectionView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        return collectionView
    }()
    
    lazy var stackView: UIStackView = {
        let view = VerticalStackView(arrangedSubviews: [
            self.allVideosButton,
            self.collectionView,
        ], spacing: 0)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(stackView)
        stackView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension VideosSectionCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideosCell", for: indexPath) as! VideosCell
        cell.video = data?.results[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let adjustedHight = collectionView.frame.height - 5*2
        let adjustedWidth = adjustedHight * 1920/1080
        
        return .init(width: adjustedWidth, height: adjustedHight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}





