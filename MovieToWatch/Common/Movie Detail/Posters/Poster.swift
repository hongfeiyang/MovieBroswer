//
//  PosterView.swift
//  MovieToWatch
//
//  Created by Clark on 21/2/20.
//  Copyright © 2020 Hongfei Yang. All rights reserved.
//

import UIKit

class ImagesSectionCell: MovieDetailSectionBaseCell {

    let cellId = "ImagesCell"
    
    override var movieDetail: MovieDetail? {
        didSet {
            DispatchQueue.main.async { self.collectionView.reloadData() }
        }
    }
    
    var data: MovieImages? {
        return movieDetail?.images
    }
    
    var allImagesButton = BaseButton(topic: "Images", content: "view all")
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .secondarySystemBackground
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ImagesCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        return collectionView
    }()
    
    lazy var stackView: UIStackView = {
        let view = VerticalStackView(arrangedSubviews: [
            self.collectionView,
            self.allImagesButton
        ], spacing: 0)
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .secondarySystemBackground
        addSubview(stackView)
        stackView.fillSuperview()
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
        
        let widthToDisplay = collectionView.frame.height / CGFloat(image.height!) * CGFloat(image.width!)
        return .init(width: widthToDisplay, height: collectionView.frame.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}
