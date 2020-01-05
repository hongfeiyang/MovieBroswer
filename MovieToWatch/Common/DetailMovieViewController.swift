//
//  DetailMovieViewController.swift
//  MovieToWatch
//
//  Created by Clark on 17/12/19.
//  Copyright © 2019 Hongfei Yang. All rights reserved.
//

import UIKit

class DetailMovieViewController: UIViewController {

    public var content: MovieDetail!
    
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
                DispatchQueue.main.async {
                    self?.updateViewFromModel()
                }
                
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
        scrollView.alwaysBounceVertical = false
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.contentInset = .init(top: 0, left: 0, bottom: self.tabBarController?.tabBar.frame.height ?? 0, right: 0)
        return scrollView
    }()
    

    
    private var dismissButton: UIButton =  {
        let button = UIButton()
        
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
        
        return imageView
    }()
    
    
    private var shortInfoView: ShortMovieInfoView = {
        let view = ShortMovieInfoView()
        
        return view
    }()
    
    private var contentView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    private lazy var creditsView: CreditsView = {
        let view = CreditsView()
        view.allCrewButton.addTarget(self, action: #selector(allCrewButtonTapped), for: .touchUpInside)
        return view
    }()
    
    @objc func allCrewButtonTapped() {
        let vc = AllCrewViewController()
        vc.data = content.credits
        self.present(vc, animated: true, completion: nil)
    }
    
    private lazy var movieImagesView: MovieImagesView = {
        let view = MovieImagesView()
        return view
    }()
    
    private lazy var movieVideosView: MovieVideosView = {
        let view = MovieVideosView()
        return view
    }()
    
    private lazy var movieReviewView: MovieReviewView = {
        let view = MovieReviewView()
        view.allReviewsButton.addTarget(self, action: #selector(viewAllReviews), for: .touchUpInside)
        return view
    }()
    
    @objc private func viewAllReviews() {
        let vc = AllReviewsController()
        vc.page = content.reviews.page
        vc.totalPages = content.reviews.totalPages
        vc.totalResults = content.reviews.totalResults
        vc.dataSource = content.reviews.results
        
        present(vc, animated: true, completion: nil)
    }
    
    private func setupLayout() {
        
        let sectionPadding = CGFloat(10)
        
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        shortInfoView.translatesAutoresizingMaskIntoConstraints = false
        creditsView.translatesAutoresizingMaskIntoConstraints = false
        movieImagesView.translatesAutoresizingMaskIntoConstraints = false
        movieVideosView.translatesAutoresizingMaskIntoConstraints = false
        movieReviewView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        contentView.addSubview(imageView)
        contentView.addSubview(shortInfoView)
        contentView.addSubview(dismissButton)
        contentView.addSubview(creditsView)
        contentView.addSubview(movieImagesView)
        contentView.addSubview(movieVideosView)
        contentView.addSubview(movieReviewView)
        
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
            creditsView.heightAnchor.constraint(equalToConstant: 325),
            creditsView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: sectionPadding),
            
            movieImagesView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            movieImagesView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            movieImagesView.heightAnchor.constraint(equalToConstant: 175),
            movieImagesView.topAnchor.constraint(equalTo: creditsView.bottomAnchor, constant: sectionPadding),
            
            movieVideosView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            movieVideosView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            movieVideosView.heightAnchor.constraint(equalToConstant: 175),
            movieVideosView.topAnchor.constraint(equalTo: movieImagesView.bottomAnchor, constant: sectionPadding),
            
            movieReviewView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            movieReviewView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            movieReviewView.heightAnchor.constraint(equalToConstant: 135),
            movieReviewView.topAnchor.constraint(equalTo: movieVideosView.bottomAnchor, constant: sectionPadding),
            
            movieReviewView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
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

    
    private func updateViewFromModel() {
        let info = ShortMovieInfo(title: content.title, tagLine: content.tagline, rating: content.voteAverage)
        shortInfoView.info = info
        if let path = content.posterPath {
            imageURL = APIConfiguration.parsePosterURL(file_path: path, size: .original)
            fetchAndSetImage()
        }
        creditsView.credits = content.credits
        movieImagesView.data = content.images
        movieVideosView.data = content.videos
        movieReviewView.data = content.reviews
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
