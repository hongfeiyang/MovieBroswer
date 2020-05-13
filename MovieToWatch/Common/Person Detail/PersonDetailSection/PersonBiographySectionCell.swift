//
//  File.swift
//  MovieToWatch
//
//  Created by Clark on 28/3/20.
//  Copyright © 2020 Hongfei Yang. All rights reserved.
//

import UIKit

class PersonBiographySectionCell: PersonDetailBaseSectionCell {
    
    override var data: PersonDetail? {
        didSet {
            contentLabel.text = data?.biography
        }
    }
    
    var contentLabel = UILabel(text: "CONTENT", font: .systemFont(ofSize: 14, weight: .regular), numberOfLines: 0, textColor: .label, textAlignment: .left)
    
    lazy var stackView = UIStackView(arrangedSubviews: [
        self.titleLabel,
        self.contentLabel
    ], axis: .vertical, spacing: 5, distribution: .fill, alignment: .fill)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel.text = "Biography"
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 10, left: 20, bottom: 20, right: 20))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
