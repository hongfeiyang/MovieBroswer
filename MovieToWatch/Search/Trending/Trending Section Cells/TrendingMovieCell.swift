//
//  TrendingMovieCell.swift
//  MovieToWatch
//
//  Created by Clark on 12/3/20.
//  Copyright © 2020 Hongfei Yang. All rights reserved.
//

import UIKit

class TrendingMovieCell: BaseTrendingCell {
    
    override var result: ISearchResult? {
        didSet {
            if let movieResult = result as? MovieMultiSearchResult {
                profileImageView.sd_setImage(with: APIConfiguration.parsePosterURL(file_path: movieResult.backdropPath, size: .w154), completed: nil)
                titleLabel.text = movieResult.title
            }
        }
    }
    
    lazy var stackView = UIStackView(arrangedSubviews: [
        self.profileImageView,
        self.titleLabel
    ], axis: .horizontal, spacing: 10, distribution: .fill, alignment: .center)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 5, left: 10, bottom: 5, right: 10))
        profileImageView.constrainHeight(constant: 40)
        profileImageView.constrainWidth(constant: 80)
        profileImageView.layer.cornerRadius = 6
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
