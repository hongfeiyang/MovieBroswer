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
                formatter.dateStyle = .medium
                let string = formatter.string(from: date)
                releaseDate.text = string
            }
            
            if let status = movieDetail?.status, status == "Released" {
                runtime.text = String(movieDetail?.runtime ?? 0) + " minutes"
                self.status.text = status
            } else {
                self.status.text = movieDetail?.status
            }
            genreController.data = movieDetail?.genres
        }
    }
    
    var releaseDate = UILabel(text: "", font: .systemFont(ofSize: 13, weight: .light), numberOfLines: 1, textColor: .label, textAlignment: .left)
    var runtime = UILabel(text: "", font: .systemFont(ofSize: 13, weight: .light), numberOfLines: 1, textColor: .label, textAlignment: .left)
    var status = UILabel(text: "", font: .systemFont(ofSize: 13, weight: .light), numberOfLines: 1, textColor: .label, textAlignment: .left)
    
    var genreController = GenreController()
    
    lazy var basicInfoStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [self.releaseDate, self.status, self.runtime])
        view.spacing = 10
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(basicInfoStack)
        addSubview(genreController.view)
        basicInfoStack.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 10, left: 10, bottom: 10, right: 10))
        basicInfoStack.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor).isActive = true
        genreController.view.anchor(top: basicInfoStack.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 10, left: 10, bottom: 10, right: 10))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
