//
//  Title.swift
//  MovieToWatch
//
//  Created by Clark on 21/2/20.
//  Copyright © 2020 Hongfei Yang. All rights reserved.
//

import UIKit

class MovieHeader: UICollectionReusableView {
    
    var movieDetail: MovieDetail? {
        didSet {
            posterImagePath = APIConfiguration.parsePosterURL(file_path: movieDetail?.posterPath, size: .original)
            titleLabel.text = movieDetail?.title
            tagLineLabel.text = movieDetail?.tagline
        }
    }

     var posterImagePath: URL? {
         didSet {
             posterImageView.sd_setImage(with: posterImagePath, completed: nil)
         }
     }
    
    var posterImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()
 
    var titleLabel = UILabel(text: "", font: .systemFont(ofSize: 32, weight: .medium), numberOfLines: 0, textColor: .label, textAlignment: .center)
    
    var tagLineLabel = UILabel(text: "", font: .systemFont(ofSize: 18, weight: .regular), numberOfLines: 0, textColor: .label, textAlignment: .center)
    
    lazy var stackView = VerticalStackView(arrangedSubviews: [
        self.titleLabel,
        self.tagLineLabel
    ], spacing: 5)
    
    
    var imageViewBottomConstraint: NSLayoutConstraint?
    var imageViewWidthConstraint: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(posterImageView)
        addSubview(stackView)
        
        stackView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 20, bottom: 20, right: 20))
        
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        posterImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        posterImageView.heightAnchor.constraint(equalTo: posterImageView.widthAnchor, multiplier: 3/2).isActive = true
        imageViewWidthConstraint = posterImageView.widthAnchor.constraint(equalTo: widthAnchor)
        imageViewBottomConstraint = posterImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        [imageViewWidthConstraint, imageViewBottomConstraint].forEach { $0?.isActive = true }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
