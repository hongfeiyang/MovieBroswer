//
//  MovieDetailViewController.swift
//  MovieToWatch
//
//  Created by Clark on 20/2/20.
//  Copyright © 2020 Hongfei Yang. All rights reserved.
//

import UIKit
import SDWebImage

class MovieDetailViewController: BaseCollectionViewController {
    
    let creditsCellId = "creditsCellId"
    let imagesCellId = "imagesCellId"
    let videosCellId = "videosCellId"
    let reviewsCellId = "reviewsCellId"
    let overviewCellId = "overviewCellId"
    let basicInfoCellId = "basicInfoCellId"
    let movieHeaderId = "movieHeaderId"
    
    var movieDetail: MovieDetail? {
        didSet {
            DispatchQueue.main.async { self.collectionView.reloadData() }
        }
    }

    var backupImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .systemBackground
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    var backupPosterImage: UIImage? {
        didSet {
            backupImageView.image = backupPosterImage
        }
    }
    
    var movieId: Int! {
        didSet {
            let query = MovieDetailQuery(movieID: movieId)
            Network.getMovieDetail(query: query) { [weak self] (response) in
                guard let self = self else {return}
                self.movieDetail = response
                self.backupImageView.sd_setImage(with: APIConfiguration.parsePosterURL(file_path: response?.posterPath, size: .original), completed: nil)
            }
        }
    }

    var imageViewTopConstraint: NSLayoutConstraint?
    var imageViewWidthConstraint: NSLayoutConstraint?
    var imageViewHeightConstraint: NSLayoutConstraint?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundView = UIView()
        collectionView.backgroundView = backgroundView
        backgroundView.addSubview(backupImageView)
        backupImageView.translatesAutoresizingMaskIntoConstraints = false
        
        backupImageView.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor).isActive = true
        imageViewTopConstraint = backupImageView.topAnchor.constraint(equalTo: backgroundView.topAnchor)
        imageViewWidthConstraint = backupImageView.widthAnchor.constraint(equalTo: backupImageView.heightAnchor, multiplier: 2/3)
        imageViewHeightConstraint = backupImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width*3/2)
        [imageViewTopConstraint, imageViewWidthConstraint, imageViewHeightConstraint].forEach { $0?.isActive = true }
        
        collectionView.delegate = self
        
        collectionView.register(BasicInfoSectionCell.self, forCellWithReuseIdentifier: basicInfoCellId)
        collectionView.register(OverviewSectionCell.self, forCellWithReuseIdentifier: overviewCellId)
        collectionView.register(CreditsSectionCell.self, forCellWithReuseIdentifier: creditsCellId)
        collectionView.register(ImagesSectionCell.self, forCellWithReuseIdentifier: imagesCellId)
        collectionView.register(VideosSectionCell.self, forCellWithReuseIdentifier: videosCellId)
        collectionView.register(ReviewsSectionCell.self, forCellWithReuseIdentifier: reviewsCellId)
        
        collectionView.register(MovieHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: movieHeaderId)
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell: MovieDetailSectionBaseCell!
        
        if indexPath.item == 0 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: basicInfoCellId, for: indexPath) as! BasicInfoSectionCell
        } else if indexPath.item == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: overviewCellId, for: indexPath) as! OverviewSectionCell
        } else if indexPath.item == 2 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: creditsCellId, for: indexPath) as! CreditsSectionCell
        } else if indexPath.item == 3 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: imagesCellId, for: indexPath) as! ImagesSectionCell
        } else if indexPath.item == 4 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: videosCellId, for: indexPath) as! VideosSectionCell
        } else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: reviewsCellId, for: indexPath) as! ReviewsSectionCell
        }
        cell.movieDetail = movieDetail
        cell.navController = navigationController
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var height: CGFloat = 280
        
        let dummyCell: MovieDetailSectionBaseCell
        
        if indexPath.item == 0 {
            dummyCell = BasicInfoSectionCell(frame: .init(x: 0, y: 0, width: collectionView.frame.width, height: 1000))
        } else if indexPath.item == 1 {
            dummyCell = OverviewSectionCell(frame: .init(x: 0, y: 0, width: collectionView.frame.width, height: 1000))
        } else if indexPath.item == 2 {
            dummyCell = CreditsSectionCell(frame: .init(x: 0, y: 0, width: collectionView.frame.width, height: 1000))
        } else if indexPath.item == 3 {
            dummyCell = ImagesSectionCell(frame: .init(x: 0, y: 0, width: collectionView.frame.width, height: 1000))
        } else if indexPath.item == 4 {
            dummyCell = VideosSectionCell(frame: .init(x: 0, y: 0, width: collectionView.frame.width, height: 1000))
        } else {
            dummyCell = ReviewsSectionCell(frame: .init(x: 0, y: 0, width: collectionView.frame.width, height: 1000))
        }
        
        dummyCell.movieDetail = movieDetail
        dummyCell.layoutIfNeeded()
        let estimatedSize = dummyCell.systemLayoutSizeFitting(.init(width: collectionView.frame.width, height: 1000))
        height = estimatedSize.height
        
        return .init(width: collectionView.frame.width, height: height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: movieHeaderId, for: indexPath) as! MovieHeader
            cell.movieDetail = movieDetail
            return cell
        default:
            let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: movieHeaderId, for: indexPath)
            return cell
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = collectionView.frame.width
        let height = width * 3/2
        return .init(width: width, height: height)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if let cell = collectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionHeader, at: .init(item: 0, section: 0)) {
            cell.clipsToBounds = scrollView.contentOffset.y > 0 ? true : false
        }
        
        if scrollView.contentOffset.y > 0 {
            // push poster image up at X/Y scrolling speed when scrolling up
            imageViewHeightConstraint?.constant = UIScreen.main.bounds.width*3/2
            imageViewTopConstraint?.constant = -scrollView.contentOffset.y*2/3
        } else {
            // expand poster image proportionally when scrolling down
            imageViewHeightConstraint?.constant = UIScreen.main.bounds.width*3/2 - scrollView.contentOffset.y
            imageViewTopConstraint?.constant = 0
        }
    }
    
}
