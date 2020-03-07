//
//  MovieCategoryCellCollectionViewCell.swift
//  MovieToWatch
//
//  Created by Clark on 17/1/20.
//  Copyright © 2020 Hongfei Yang. All rights reserved.
//

import UIKit

class MovieCategoryCell: UICollectionViewCell {

    weak var delegate: UIViewController?
    
    var dataSource: [BaseMovieResult]? {
        didSet {
            DispatchQueue.main.async { self.movieCollectionView.reloadData() }
        }
    }
        
    lazy var movieCollectionView: UICollectionView = {
        let layout = BetterSnappingLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.decelerationRate = .fast
        view.showsHorizontalScrollIndicator = false
        view.contentInset = .init(top: 0, left: 20, bottom: 0, right: 20)
        view.register(IndividualMovieCell.self, forCellWithReuseIdentifier: "IndividualMovieCell")
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = .clear
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(movieCollectionView)
        movieCollectionView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension MovieCategoryCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IndividualMovieCell", for: indexPath) as! IndividualMovieCell
        cell.movieItem = dataSource?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = dataSource?[indexPath.item]
        let vc = MovieDetailViewController()
        vc.movieId = item?.id
        vc.hidesBottomBarWhenPushed = true
        delegate?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: self.frame.height * 2/3, height: self.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    
}

class IndividualMovieCell: UICollectionViewCell {
    
    var movieItem: BaseMovieResult? {
        didSet {
            let posterImageURL = APIConfiguration.parsePosterURL(file_path: movieItem?.posterPath, size: .w342)
            posterImageView.sd_setImage(with: posterImageURL, placeholderImage: UIImage(), completed: nil)
        }
    }
            
    private var posterImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(posterImageView)
        posterImageView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
