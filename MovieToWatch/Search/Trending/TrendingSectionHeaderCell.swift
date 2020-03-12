//
//  TrendingSectionHeaderCell.swift
//  MovieToWatch
//
//  Created by Clark on 12/3/20.
//  Copyright © 2020 Hongfei Yang. All rights reserved.
//

import UIKit

class TrendingSectionHeaderCell: UICollectionReusableView {
    
    var titleLabel = UILabel(text: "Header", font: .systemFont(ofSize: 22, weight: .bold), numberOfLines: 1, textColor: .label, textAlignment: .left)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        titleLabel.fillSuperview(padding: .init(top: 5, left: 10, bottom: 5, right: 10))
        backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
