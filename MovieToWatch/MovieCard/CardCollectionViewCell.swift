//
//  CardCollectionViewCell.swift
//  MovieToWatch
//
//  Created by Clark on 16/12/19.
//  Copyright © 2019 Hongfei Yang. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    public var result: MovieItem! {
        didSet {
            imageURL = APIConfiguration.parsePosterURL(file_path: result.posterPath, size: .original)
            var info = SummaryMovieInfo()
            info.summary = result.overview
            info.title = result.title
            summaryInfoView.info = info
        }
    }
    
    private var activityIndicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView()
        
        indicatorView.hidesWhenStopped = true
        indicatorView.style = .large
        indicatorView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        return indicatorView
    }()
    
    private var imageURL: URL? {
        didSet {
            
            guard let url = imageURL else {print("failed to have a valid image url"); return}

            
            DispatchQueue.main.async {
                self.activityIndicatorView.startAnimating()
                self.imageView.image = nil
            }
            Cache.shared.cacheImage(url: url) { (url, image) in
                if url == self.imageURL {
                    DispatchQueue.main.async {
                        self.activityIndicatorView.stopAnimating()
                        self.imageView.image = image
                    }
                }
            }
            
        }
    }
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    private var summaryInfoView: SummaryMovieInfoView = {
        let view = SummaryMovieInfoView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private func setupLayout() {
        let constraints = [
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 3/2),
            
            summaryInfoView.leadingAnchor.constraint(equalTo: leadingAnchor),
            summaryInfoView.trailingAnchor.constraint(equalTo: trailingAnchor),
            summaryInfoView.heightAnchor.constraint(equalToConstant: CGFloat(Constants.MOIVE_SUMMARY_VIEW_HEIGHT)),
            summaryInfoView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = CGFloat(Constants.CARD_CORNER_RADIUS)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = CGFloat(Constants.CARD_SHADOW_RADIUS)
        layer.shadowOpacity = Constants.CARD_SHADOW_OPACITY
        layer.masksToBounds = true
        clipsToBounds = true
        
        contentView.addSubview(imageView)
        contentView.addSubview(summaryInfoView)
        imageView.addSubview(activityIndicatorView)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    
}
