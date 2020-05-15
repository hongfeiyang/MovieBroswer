//
//  File.swift
//  MovieToWatch
//
//  Created by Clark on 12/3/20.
//  Copyright © 2020 Hongfei Yang. All rights reserved.
//

import UIKit

class TrendingPersonCell: BaseTrendingCell {

    override var result: ISearchResult? {
        didSet {
            if let personResult = result as? PersonMultiSearchResult {
                profileImageView.sd_setImage(with: APIConfiguration.parsePosterURL(file_path: personResult.profilePath, size: .original), placeholderImage: Constants.personPlaceholderImage, completed: nil)
                titleLabel.text = personResult.name
            }
        }
    }
    
    lazy var stackView = UIStackView(arrangedSubviews: [
        self.profileImageView,
        self.titleLabel
    ], axis: .vertical, spacing: 10, distribution: .fill, alignment: .center)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        profileImageView.constrainHeight(constant: 60)
        profileImageView.constrainWidth(constant: 60)
        profileImageView.layer.cornerRadius = 30
        profileImageView.layer.cornerCurve = .circular
        titleLabel.font = .systemFont(ofSize: 12, weight: .medium)
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 20, left: 0, bottom: 20, right: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
