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
    
    var gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.secondarySystemGroupedBackground.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        return gradientLayer
    }()
    
    var titleView = UIView()

    var imageViewTopConstraint: NSLayoutConstraint?
    var imageViewWidthConstraint: NSLayoutConstraint?
    var imageViewBottomConstraint: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .secondarySystemGroupedBackground
        addSubview(posterImageView)
        
        addSubview(titleView)
        titleView.layer.addSublayer(gradientLayer)
        titleView.addSubview(stackView)
        
        
        stackView.anchor(top: nil, leading: titleView.leadingAnchor, bottom: titleView.bottomAnchor, trailing: titleView.trailingAnchor, padding: .init(top: 0, left: 20, bottom: 20, right: 20))
    
        titleView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, size: .init(width: 0, height: 400))
        
        posterImageView.translatesAutoresizingMaskIntoConstraints = false

        posterImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageViewTopConstraint = posterImageView.topAnchor.constraint(equalTo: topAnchor)
        imageViewWidthConstraint = posterImageView.widthAnchor.constraint(equalTo: posterImageView.heightAnchor, multiplier: 2/3)
        imageViewBottomConstraint = posterImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        [imageViewTopConstraint, imageViewBottomConstraint, imageViewWidthConstraint].forEach { $0?.isActive = true }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = titleView.bounds
    }
}
