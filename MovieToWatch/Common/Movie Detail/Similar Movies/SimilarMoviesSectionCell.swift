//
//  SimilarMoviesSectionCell.swift
//  MovieToWatch
//
//  Created by Clark on 18/5/20.
//  Copyright © 2020 Hongfei Yang. All rights reserved.
//

import UIKit

class SimilarMoviesSectionCell: HorizontalMovieCollectionCell {
    override var movieDetail: MovieDetail? {
        didSet {
            movieItems = movieDetail?.similarMovies?.results.map{IndividualMovieItem(movieListResult: $0)}
        }
    }
    
    override func setupLayout() {
        addSubview(movieCollectionView)
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 10, bottom: 0, right: 10))
        movieCollectionView.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel.font = UIFont.systemFont(ofSize: 21, weight: .medium)
        titleLabel.text = "Similar Movies"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
