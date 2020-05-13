//
//  PersonDobSectionCell.swift
//  MovieToWatch
//
//  Created by Clark on 28/3/20.
//  Copyright © 2020 Hongfei Yang. All rights reserved.
//

import UIKit

class PersonDobSectionCell: PersonDetailBaseSectionCell {
    
    override var data: PersonDetail? {
        didSet {
            birthdayLabel.text = data?.birthday
            placeOfBirthLabel.text = data?.placeOfBirth
        }
    }
    
    var birthdayLabel = UILabel(text: "BIRTHDAY", font: .systemFont(ofSize: 15, weight: .regular), numberOfLines: 0, textColor: .label, textAlignment: .left)
    var placeOfBirthLabel = UILabel(text: "PLACE OF BIRTH", font: .systemFont(ofSize: 15, weight: .regular), numberOfLines: 0, textColor: .label, textAlignment: .left)
    
    lazy var stackView = UIStackView(arrangedSubviews: [
        self.titleLabel,
        self.birthdayLabel,
        self.placeOfBirthLabel
    ], axis: .vertical, spacing: 5, distribution: .fill, alignment: .fill)
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel.text = "Born"
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 0, left: 20, bottom: 20, right: 20))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
