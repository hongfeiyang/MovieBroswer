//
//  PersonCreditCell.swift
//  MovieToWatch
//
//  Created by Clark on 3/4/20.
//  Copyright © 2020 Hongfei Yang. All rights reserved.
//

import UIKit

struct PersonCreditViewModel {
    var detailAttributedString: NSMutableAttributedString
    var year: String
    
    init(credit: PersonCastCredit) {
        self.year = credit.releaseDate ?? credit.firstAirDate ?? "-"
        
        let resultString = NSMutableAttributedString()
        
        if let title = credit.title {
            let mediaTitle = NSMutableAttributedString(string: title, attributes: [
                .font : UIFont.systemFont(ofSize: 16, weight: .semibold),
                .foregroundColor: UIColor.label
            ])
            resultString.append(mediaTitle)
        }
        
        if let character = credit.character {
            
            let connective = NSMutableAttributedString(string: " as ", attributes: [
                .font : UIFont.systemFont(ofSize: 14, weight: .regular),
                .foregroundColor: UIColor.secondaryLabel
            ])
            resultString.append(connective)
            
            let characterTitle = NSMutableAttributedString(string: character, attributes: [
                .font : UIFont.systemFont(ofSize: 16, weight: .regular),
                .foregroundColor: UIColor.label
            ])
            resultString.append(characterTitle)
        }
        
        self.detailAttributedString = resultString
    }
    
    init(credit: PersonCrewCredit) {
        self.year = credit.releaseDate ?? credit.firstAirDate ?? "-"
        
        let resultString = NSMutableAttributedString()
        
        if let title = credit.title {
            let mediaTitle = NSMutableAttributedString(string: title, attributes: [
                .font : UIFont.systemFont(ofSize: 16, weight: .semibold),
                .foregroundColor: UIColor.label
            ])
            resultString.append(mediaTitle)
        }
        
        if let job = credit.job {
            
            let connective = NSMutableAttributedString(string: " ... ", attributes: [
                .font : UIFont.systemFont(ofSize: 14, weight: .regular),
                .foregroundColor: UIColor.secondaryLabel
            ])
            resultString.append(connective)
            
            let jobTitle = NSMutableAttributedString(string: job, attributes: [
                .font : UIFont.systemFont(ofSize: 16, weight: .regular),
                .foregroundColor: UIColor.label
            ])
            resultString.append(jobTitle)
        }
        
        self.detailAttributedString = resultString
    }
}


class PersonCreditCell: UICollectionViewCell {
    
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
    ], axis: .horizontal, spacing: 10, distribution: .fill, alignment: .fill)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 5, left: 20, bottom: 5, right: 20))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
