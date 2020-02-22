//
//  ReviewCell.swift
//  MovieToWatch
//
//  Created by Clark on 22/2/20.
//  Copyright © 2020 Hongfei Yang. All rights reserved.
//

import UIKit


class MovieReviewCell: UICollectionViewCell {
    
    var review: ReviewsResult? {
        didSet {
            authorLabel.text = review?.author
            contentLabel.text = review?.content
        }
    }
    
    var authorLabel = UILabel(text: "", font: .systemFont(ofSize: 16, weight: .semibold), numberOfLines: 0, textColor: .label, textAlignment: .left)
    
    var contentLabel = UILabel(text: "", font: .systemFont(ofSize: 14, weight: .light), numberOfLines: 0, textColor: .label, textAlignment: .left)
    
    lazy var stackView = VerticalStackView(arrangedSubviews: [
        self.authorLabel, self.contentLabel
    ], spacing: 5)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .tertiarySystemGroupedBackground
        layer.cornerRadius = 12
        clipsToBounds = true
        
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 20, left: 20, bottom: 20, right: 20))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
