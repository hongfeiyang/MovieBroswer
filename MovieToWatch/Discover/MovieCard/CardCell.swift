//
//  CardCollectionViewCell.swift
//  MovieToWatch
//
//  Created by Clark on 16/12/19.
//  Copyright © 2019 Hongfei Yang. All rights reserved.
//

import UIKit

class CardViewCell: UICollectionViewCell {
        
    var movieDetail: MovieDetail? {
        didSet {
            let url = APIConfiguration.parsePosterURL(file_path: movieDetail?.posterPath, size: .original)
            self.imageURL = url
            self.shortInfoView.titleLabel.text = movieDetail?.title
            self.shortInfoView.tagLineLabel.text = movieDetail?.tagline
            self.shortInfoView.ratingLabel.text = String(movieDetail?.voteAverage ?? 0)
        }
    }
    
    public var imageURL: URL? {
        didSet {
            self.posterImageView.sd_setImage(with: imageURL) { [weak self] (_, _, _, _) in
                guard let self = self else {return}
                self.activityIndicatorView.stopAnimating()
            }
        }
    }
    
    
    var activityIndicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView()
        indicatorView.hidesWhenStopped = true
        indicatorView.style = .large
        indicatorView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return indicatorView
    }()

    var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var shortInfoView: ShortMovieInfoView = {
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
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    
    var summaryInfoConstraints: AnchoredConstraints?
    
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.transform = self.isHighlighted ? CGAffineTransform(scaleX: 0.95, y: 0.95) : .identity
            }, completion: nil)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        backgroundColor = .systemGroupedBackground
        layer.cornerRadius = CGFloat(Constants.CARD_CORNER_RADIUS)
        clipsToBounds = true
        
        contentView.addSubview(posterImageView)
        contentView.addSubview(shortInfoView)
        
        summaryInfoConstraints = shortInfoView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, size: .init(width: 0, height: 100))
        
        posterImageView.addSubview(activityIndicatorView)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


class LoadingCollectionViewCell: UICollectionViewCell {
    
    var activityIndicator = UIActivityIndicatorView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        activityIndicator.style = .large
        activityIndicator.color = .label
        addSubview(activityIndicator)
        activityIndicator.fillSuperview()        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
