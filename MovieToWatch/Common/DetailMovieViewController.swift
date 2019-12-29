//
//  DetailMovieViewController.swift
//  MovieToWatch
//
//  Created by Clark on 17/12/19.
//  Copyright © 2019 Hongfei Yang. All rights reserved.
//

import UIKit

class DetailMovieViewController: UIViewController {

    public var content: MovieDetail! {
        didSet {
            
        }
    }
    
    public var imageURLString: String? {
        didSet {
            guard let imageURLString = imageURLString else {return}
            imageURL = APIConfiguration.parsePosterURL(file_path: imageURLString, size: .original)
            fetchAndSetImage()
        }
    }
    
    private var imageURL: URL?
    
    public var movieID: Int! {
        didSet {
            let detailQuery = MovieDetailQuery(movieID: movieID)
            
            Network.getMovieDetail(query: detailQuery) { [weak self] movieDetail in
                self?.content = movieDetail
                self?.updateShortMovieView()
                self?.updateViewFromModel()
            }
        }
    }
    
    public var posterImage: UIImage? {
        didSet {
            DispatchQueue.main.async {
                if self.imageView.image == nil {
                    self.imageView.image = self.posterImage
                }
            }
        }
    }
    
    public lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.delegate = self
        scrollView.alwaysBounceVertical = true
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    

    
    private var dismissButton: UIButton =  {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(.checkmark, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        //button.backgroundColor = .white
        button.addTarget(self, action: #selector(dismissMovieView), for: .touchUpInside)
        return button
    }()
    
    @objc private func dismissMovieView() {
        dismiss(animated: true, completion: nil)
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
    
    private var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var creditsView = CreditsView()
    
    //public lazy var scrollViewWidthConstraint: NSLayoutConstraint = scrollView.widthAnchor.constraint(equalTo: view.widthAnchor)
    
    private func setupLayout() {
        
        let sectionPadding = CGFloat(10)
        
        creditsView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        contentView.addSubview(imageView)
        contentView.addSubview(shortInfoView)
        contentView.addSubview(dismissButton)
        contentView.addSubview(creditsView)
        
        let constraints = [

            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.widthAnchor.constraint(equalToConstant: CGFloat(Constants.MOVIE_POSTER_WIDTH)),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 3/2),

            shortInfoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            shortInfoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            shortInfoView.heightAnchor.constraint(equalToConstant: CGFloat(Constants.MOIVE_SUMMARY_VIEW_HEIGHT)),
            shortInfoView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor),
            
            creditsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            creditsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            creditsView.heightAnchor.constraint(greaterThanOrEqualToConstant: 300),
            creditsView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: sectionPadding),
            
            creditsView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            dismissButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            dismissButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            dismissButton.heightAnchor.constraint(equalToConstant: 40),
            dismissButton.widthAnchor.constraint(equalTo: dismissButton.heightAnchor),
        ]
        
        let constraint1 = shortInfoView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: CGFloat(Constants.MOVIE_POSTER_HEIGHT) - CGFloat(Constants.MOIVE_SUMMARY_VIEW_HEIGHT))
        constraint1.priority = .defaultLow
        constraint1.isActive = true
        
        NSLayoutConstraint.activate(constraints)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        setupLayout()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.contentSize = contentView.frame.size
    }

    
}

extension DetailMovieViewController: UIScrollViewDelegate {
    
}

extension DetailMovieViewController {
    private func updateShortMovieView() {
//        let info = ShortMovieInfo(title: content.title, tagLine: content.tagline, rating: content.voteAverage)
//        shortInfoView.info = info
    }
    
    private func updateViewFromModel() {
        let info = ShortMovieInfo(title: content.title, tagLine: content.tagline, rating: content.voteAverage)
        shortInfoView.info = info
        creditsView.credits = content.credits
        
    }
    
    private func fetchAndSetImage() {
        guard let url = imageURL else {print("failed to have a valid image url"); return}
        Cache.shared.cacheImage(url: url) { (url, image) in
            if url == self.imageURL {
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        }
    }
}
