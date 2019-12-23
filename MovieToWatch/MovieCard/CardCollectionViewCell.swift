//
//  CardCollectionViewCell.swift
//  MovieToWatch
//
//  Created by Clark on 16/12/19.
//  Copyright © 2019 Hongfei Yang. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    public var content: (result: MovieResult, detail: MovieMO?)! {
        didSet {
            imageURL = APIConfiguration.parsePosterURL(file_path: content.result.posterPath, size: .original)
            updateShortMovieInfoView()
        }
    }
    
//    public var movieID: Int! {
//        didSet {
//            let movieDetailQuery = MovieDetailQuery(movieID: movieID)
//            Network.getMovieDetail(query: movieDetailQuery) { [weak self] detail in
//                self?.content = content
//                
//            }
//        }
//    }
    
    private var activityIndicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView()
        
        indicatorView.hidesWhenStopped = true
        indicatorView.style = .large
        indicatorView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        return indicatorView
    }()
    
    private var imageURL: URL? {
        didSet {
            fetchAndSetImage()
        }
    }
    
    private var imageView: UIImageView = {
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
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 3/2),
            
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
        
        contentView.addSubview(imageView)
        contentView.addSubview(shortInfoView)
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

extension CardCollectionViewCell {
    public func updateShortMovieInfoView() {
        let info = ShortMovieInfo(title: content.result.title, overview: content.result.overview, rating: Float(content.result.voteAverage))
        shortInfoView.info = info
    }
    
    private func fetchAndSetImage() {
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
