//
//  PersonDetailSectionBaseCell.swift
//  MovieToWatch
//
//  Created by Clark on 28/3/20.
//  Copyright © 2020 Hongfei Yang. All rights reserved.
//

import UIKit

class PersonDetailBaseSectionCell: UICollectionViewCell {
    
    var titleLabel = UILabel(text: "TITLE", font: .systemFont(ofSize: 18, weight: .semibold), numberOfLines: 1, textColor: .label, textAlignment: .left)
    var data: PersonDetail?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
