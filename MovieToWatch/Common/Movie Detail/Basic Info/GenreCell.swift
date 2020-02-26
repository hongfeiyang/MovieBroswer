//
//  GenreCell.swift
//  MovieToWatch
//
//  Created by Clark on 26/2/20.
//  Copyright © 2020 Hongfei Yang. All rights reserved.
//

import UIKit

class GenreCell: UICollectionViewCell {
    
    var genre: Genre? {
        didSet {
            genreLabel.text = genre?.name
        }
    }
    
    var genreLabel = UILabel(text: "", font: .systemFont(ofSize: 12, weight: .light), numberOfLines: 1, textColor: .label, textAlignment: .center)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(genreLabel)
        genreLabel.fillSuperview(padding: .init(top: 5, left: 5, bottom: 5, right: 5))
        layer.borderColor = UIColor.label.cgColor
        layer.borderWidth = 1
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
