//
//  BasicInfoSectionCell.swift
//  MovieToWatch
//
//  Created by Clark on 24/2/20.
//  Copyright © 2020 Hongfei Yang. All rights reserved.
//

import UIKit

class BasicInfoSectionCell: MovieDetailSectionBaseCell {
    
    override var movieDetail: MovieDetail? {
        didSet {
            if let date = movieDetail?.releaseDate {
                let formatter = DateFormatter()
                formatter.dateStyle = .short
                let string = formatter.string(from: date)
                releaseDate.text = string
            }
            runtime.text = String(movieDetail?.runtime ?? 0) + " minutes"
            status.text = movieDetail?.status
        }
    }
    
    
    var releaseDate = UILabel(text: "", font: .systemFont(ofSize: 13, weight: .light), numberOfLines: 1, textColor: .secondaryLabel, textAlignment: .left)
    var runtime = UILabel(text: "", font: .systemFont(ofSize: 13, weight: .light), numberOfLines: 1, textColor: .secondaryLabel, textAlignment: .left)
    var status = UILabel(text: "", font: .systemFont(ofSize: 13, weight: .light), numberOfLines: 1, textColor: .secondaryLabel, textAlignment: .left)
    
    lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [self.releaseDate, self.runtime, self.status, UIView()])
        view.spacing = 10
        view.distribution = .fillProportionally
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 10, left: 10, bottom: 10, right: 10))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
