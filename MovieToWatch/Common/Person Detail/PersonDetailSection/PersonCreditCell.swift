//
//  PersonCreditCell.swift
//  MovieToWatch
//
//  Created by Clark on 3/4/20.
//  Copyright © 2020 Hongfei Yang. All rights reserved.
//

import UIKit

class PersonCreditCell: UICollectionViewCell {
    
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.25) {
                self.backgroundColor = self.isHighlighted ? .opaqueSeparator : .systemBackground
            }
        }
    }
    
    var personCredit: PersonCreditViewModel! {
        didSet {
            detailLabel.attributedText = personCredit.detailAttributedString
            yearLabel.text = personCredit.year
        }
    }
    
    var creditImageView: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    var yearLabel = UILabel(text: "YEAR", font: .systemFont(ofSize: 15, weight: .regular), numberOfLines: 1, textColor: .label, textAlignment: .left)
    var detailLabel = UILabel(text: "Detail", font: .systemFont(ofSize: 15, weight: .regular), numberOfLines: 0, textColor: .label, textAlignment: .left)
    
    lazy var stackView = UIStackView(arrangedSubviews: [
        self.yearLabel,
        self.detailLabel,
    ], axis: .horizontal, spacing: 0, distribution: .fill, alignment: .center)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(stackView)
        yearLabel.constrainWidth(constant: 50)
        stackView.fillSuperview(padding: .init(top: 5, left: 20, bottom: 5, right: 20))
        backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
