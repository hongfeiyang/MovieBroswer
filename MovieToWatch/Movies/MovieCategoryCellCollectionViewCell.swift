//
//  MovieCategoryCellCollectionViewCell.swift
//  MovieToWatch
//
//  Created by Clark on 17/1/20.
//  Copyright © 2020 Hongfei Yang. All rights reserved.
//

import UIKit

struct MovieItemInCategory {
    let id: Int
    let title: String?
    let posterPath: String?
}

class MovieCategoryCell: UICollectionViewCell {

    var dataSource = [MovieItemInCategory]() {
        didSet {
            DispatchQueue.main.async {
                self.movieCollectionView.reloadData()
            }
        }
    }
    
    func resetContent() {
        dataSource.removeAll()
    }
    
    lazy var movieCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(IndividualMovieCell.self, forCellWithReuseIdentifier: "IndividualMovieCell")
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    private func setupLayout() {
        movieCollectionView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            movieCollectionView.topAnchor.constraint(equalTo: topAnchor),
            movieCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            movieCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            movieCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGroupedBackground
        addSubview(movieCollectionView)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension MovieCategoryCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IndividualMovieCell", for: indexPath) as! IndividualMovieCell
        cell.resetContent()
        cell.movieItem = dataSource[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: self.frame.height * 2/3, height: self.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    
}

class IndividualMovieCell: UICollectionViewCell {
    
    var movieItem: MovieItemInCategory! {
        didSet {
            updateViewFromModel()
        }
    }
    
    func resetContent() {
        DispatchQueue.main.async {
            self.posterImageView.image = nil
        }
    }
    
    private func updateViewFromModel() {
        
        let posterImageURL = APIConfiguration.parsePosterURL(file_path: movieItem.posterPath, size: .w342)
        guard let fullURL = posterImageURL else {return}
        Cache.shared.cacheImage(url: fullURL) { [weak self] (url, image) in
            if fullURL == url {
                DispatchQueue.main.async {
                    self?.posterImageView.image = image
                }
            }
        }
    }
    
    private var posterImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private func setupLayout() {
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            posterImageView.topAnchor.constraint(equalTo: topAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(posterImageView)
        setupLayout()
        backgroundColor = .systemGroupedBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
