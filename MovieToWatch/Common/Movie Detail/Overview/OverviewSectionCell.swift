//
//  OverviewSectionCell.swift
//  MovieToWatch
//
//  Created by Clark on 24/2/20.
//  Copyright © 2020 Hongfei Yang. All rights reserved.
//

import UIKit

class OverviewSectionCell: BaseMovieDetailSectionCell {
    
    override var movieDetail: MovieDetail? {
        didSet {
            overviewContentLabel.text = movieDetail?.overview
        }
    }

    var overviewContentLabel = UILabel(text: "", font: .systemFont(ofSize: 14, weight: .light), numberOfLines: 0, textColor: .label, textAlignment: .left)
    var overviewButton = BaseButton(topic: "Overview", content: "")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(overviewButton)
        addSubview(overviewContentLabel)
        overviewButton.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 10, left: 0, bottom: 10, right: 0))
        overviewContentLabel.anchor(top: overviewButton.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 5, left: 10, bottom: 10, right: 10))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
