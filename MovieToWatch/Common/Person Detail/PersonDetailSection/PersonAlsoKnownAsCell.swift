//
//  PersonAlsoKnownAsCell.swift
//  MovieToWatch
//
//  Created by Clark on 28/3/20.
//  Copyright © 2020 Hongfei Yang. All rights reserved.
//

import UIKit

class PersonAlsoKnownAsCell: PersonDetailBaseSectionCell {
    
    override var data: PersonDetail? {
        didSet {
            if let alsoKnownAs = data?.alsoKnownAs {
                contentLabel.text = alsoKnownAs.joined(separator: "\n")
            }
        }
    }
    
    var contentLabel = UILabel(text: "", font: .systemFont(ofSize: 15, weight: .regular), numberOfLines: 0, textColor: .label, textAlignment: .left)
    lazy var stackView = UIStackView(arrangedSubviews: [
        self.titleLabel,
        self.contentLabel
    ], axis: .vertical, spacing: 5, distribution: .fill, alignment: .fill)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel.text = "Also Known As"
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 0, left: 20, bottom: 0, right: 20))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
