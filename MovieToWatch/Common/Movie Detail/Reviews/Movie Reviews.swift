//
//  Movie Reviews.swift
//  MovieToWatch
//
//  Created by Clark on 22/2/20.
//  Copyright © 2020 Hongfei Yang. All rights reserved.
//

import UIKit

class ReviewsSectionCell: MovieDetailSectionBaseCell {
    
    let reviewCellId = "singleReviewCellId"
    
    override var movieDetail: MovieDetail? {
        didSet {
            DispatchQueue.main.async { self.collectionView.reloadData() }
        }
    }
    
    var data: [ReviewsResult]? {
        return movieDetail?.reviews.results
    }

    var allReviewsButton = BaseButton(topic: "Reviews", content: "")
    
    lazy var collectionView: UICollectionView = {
        let layout = BetterSnappingLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.decelerationRate = .fast
        view.contentInset = .init(top: 0, left: 10, bottom: 0, right: 10)
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = .clear
        view.register(MovieReviewCell.self, forCellWithReuseIdentifier: reviewCellId)
        view.heightAnchor.constraint(equalToConstant: 200).isActive = true
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let view = VerticalStackView(arrangedSubviews: [
            self.allReviewsButton,
            self.collectionView
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

extension ReviewsSectionCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reviewCellId, for: indexPath) as! MovieReviewCell
        cell.review = data?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return interItemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return lineSpacingforSections
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return .init(width: collectionView.frame.width - interItemSpacing*2, height: collectionView.frame.height - lineSpacingforSections*2)
    }
    
    var interItemSpacing: CGFloat {return 16}
    var lineSpacingforSections: CGFloat {return 16}
}
