//
//  MovieDetailSecionCell.swift
//  MovieToWatch
//
//  Created by Clark on 20/2/20.
//  Copyright © 2020 Hongfei Yang. All rights reserved.
//

import UIKit

class BaseMovieDetailSectionCell: UICollectionViewCell {
    
    var movieDetail: MovieDetail?
    weak var navController: UINavigationController?
    var emptyDatasourceLabel = UILabel(text: "Nothing here", font: .systemFont(ofSize: 20, weight: .regular), numberOfLines: 0, textColor: .label, textAlignment: .center)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
