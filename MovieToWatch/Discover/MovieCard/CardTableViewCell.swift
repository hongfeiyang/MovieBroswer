//
//  CardCollectionViewCell.swift
//  MovieToWatch
//
//  Created by Clark on 16/12/19.
//  Copyright © 2019 Hongfei Yang. All rights reserved.
//

import UIKit

class CardViewCell: UICollectionViewCell {
    
    public var content: DiscoverMovieResult! {
        didSet {
            imageURL = APIConfiguration.parsePosterURL(file_path: content.posterPath, size: .w780)
            DispatchQueue.main.async { [weak self] in
                self?.updateShortMovieInfoView()
            }
            
        }
    }
    
    public var imageURL: URL? {
        didSet {
            fetchAndSetImage()
        }
    }
    
    
    private var activityIndicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView()
        
        indicatorView.hidesWhenStopped = true
        indicatorView.style = .large
        indicatorView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        return indicatorView
    }()
    

    
    public var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    private var shortInfoView: ShortMovieInfoView = {
        let view = ShortMovieInfoView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private func setupLayout() {
        let constraints = [
            posterImageView.topAnchor.constraint(equalTo: topAnchor),
            posterImageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            posterImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            posterImageView.heightAnchor.constraint(equalTo: posterImageView.widthAnchor, multiplier: 3/2),
            
            shortInfoView.leadingAnchor.constraint(equalTo: leadingAnchor),
            shortInfoView.trailingAnchor.constraint(equalTo: trailingAnchor),
            shortInfoView.heightAnchor.constraint(equalToConstant: CGFloat(Constants.MOIVE_SUMMARY_VIEW_HEIGHT)),
            shortInfoView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        backgroundColor = .systemGroupedBackground
        layer.cornerRadius = CGFloat(Constants.CARD_CORNER_RADIUS)
        layer.shadowColor = UIColor.systemGroupedBackground.cgColor
        layer.shadowRadius = CGFloat(Constants.CARD_SHADOW_RADIUS)
        layer.shadowOpacity = Constants.CARD_SHADOW_OPACITY
        layer.masksToBounds = true
        clipsToBounds = true
        
        contentView.addSubview(posterImageView)
        contentView.addSubview(shortInfoView)
        
        posterImageView.addSubview(activityIndicatorView)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}


class LoadingCollectionViewCell: UICollectionViewCell {
    
    private var activityIndicator = UIActivityIndicatorView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        activityIndicator.style = .large
        activityIndicator.startAnimating()
        
        addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            activityIndicator.widthAnchor.constraint(equalToConstant: 40),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CardViewCell {
    public func updateShortMovieInfoView() {
        let info = ShortMovieInfo(title: content.title, tagLine: content.overview, rating: content.voteAverage ?? 0)
        shortInfoView.info = info
    }
    
    private func fetchAndSetImage() {

        DispatchQueue.main.async {
            self.posterImageView.image = nil
        }
        
        guard let url = imageURL else {
            print("failed to have a valid image url")
            return
        }

        DispatchQueue.main.async {
            self.activityIndicatorView.startAnimating()
        }

        Cache.shared.cacheImage(url: url) { (url, image) in
            if url == self.imageURL {
                DispatchQueue.main.async {
                    self.activityIndicatorView.stopAnimating()
                    self.posterImageView.image = image
                }
            }
        }
    }
}
