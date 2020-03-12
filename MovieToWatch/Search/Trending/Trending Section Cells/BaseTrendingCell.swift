//
//  TrendingCell.swift
//  MovieToWatch
//
//  Created by Clark on 12/3/20.
//  Copyright © 2020 Hongfei Yang. All rights reserved.
//

import UIKit

class BaseTrendingCell: UICollectionViewCell {
    
    var result: ISearchResult?
    
    var profileImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 10
        view.layer.cornerCurve = .continuous
        view.clipsToBounds = true
        view.backgroundColor = .secondarySystemBackground
        return view
    }()
    
    var titleLabel = UILabel(text: "", font: .systemFont(ofSize: 14, weight: .semibold), numberOfLines: 2, textColor: .label, textAlignment: .left)

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
