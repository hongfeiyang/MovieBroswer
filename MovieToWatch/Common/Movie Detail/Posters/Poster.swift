//
//  PosterView.swift
//  MovieToWatch
//
//  Created by Clark on 21/2/20.
//  Copyright © 2020 Hongfei Yang. All rights reserved.
//

import UIKit

class ImagesSectionCell: BaseMovieDetailSectionCell {

    let cellId = "ImagesCell"
    
    override var movieDetail: MovieDetail? {
        didSet {
            if let data = movieDetail?.images.backdrops, data.count > 0 {
                emptyDatasourceLabel.isHidden = true
            } else {
                emptyDatasourceLabel.isHidden = false
            }
            DispatchQueue.main.async { self.collectionView.reloadData() }
        }
    }
    
    var data: MovieImages? {
        return movieDetail?.images
    }
    
    var allImagesButton = BaseButton(topic: "Images", content: "")
    
    lazy var collectionView: UICollectionView = {
        let layout = BetterSnappingLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.decelerationRate = .fast
        collectionView.contentInset = .init(top: 0, left: 10, bottom: 0, right: 30)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ImagesCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        return collectionView
    }()
    
    lazy var stackView: UIStackView = {
        let view = VerticalStackView(arrangedSubviews: [
            self.allImagesButton,
            self.collectionView
        ], spacing: 0)
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(stackView)
        stackView.fillSuperview()
        
        emptyDatasourceLabel.text = "No Images Available"
        collectionView.addSubview(emptyDatasourceLabel)
        emptyDatasourceLabel.centerInSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension ImagesSectionCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data?.backdrops.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ImagesCell
        cell.image = data?.backdrops[indexPath.row]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        guard let image = data?.backdrops[indexPath.row] else {return .init(width: 0, height: 0)}
        
        let adjustedHeight = collectionView.frame.height // - 10*2
        let widthToDisplay = adjustedHeight / CGFloat(image.height!) * CGFloat(image.width!)
        return .init(width: widthToDisplay, height: adjustedHeight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
