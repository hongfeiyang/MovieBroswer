//
//  PersonIntroMovieCell.swift
//  MovieToWatch
//
//  Created by Clark on 16/3/20.
//  Copyright © 2020 Hongfei Yang. All rights reserved.
//

import UIKit

class PersonIntroMovieCell: UICollectionViewCell {
    
    var data: PersonCastCredit! {
        didSet {
            posterImageView.sd_setImage(with: APIConfiguration.parsePosterURL(file_path: data.posterPath, size: .original), completed: nil)
            title.text = data.title
            if let vote = data.voteAverage {
                rating.text = String(vote)
            } else {
                rating.text = "Unknown"
            }
        }
    }
    
    var posterImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    var title = UILabel(text: "", font: .systemFont(ofSize: 11, weight: .regular), numberOfLines: 2, textColor: .label, textAlignment: .left)
    var rating = UILabel(text: "", font: .systemFont(ofSize: 10, weight: .regular), numberOfLines: 1, textColor: .secondaryLabel, textAlignment: .left)
    
    lazy var stackView = UIStackView(arrangedSubviews: [
        self.title,
        self.rating
    ], axis: .vertical, spacing: 0, distribution: .fill, alignment: .fill)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(posterImageView)
        posterImageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor)
        posterImageView.heightAnchor.constraint(equalTo: posterImageView.widthAnchor, multiplier: 3/2).isActive = true
        addSubview(stackView)
        stackView.anchor(top: posterImageView.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
