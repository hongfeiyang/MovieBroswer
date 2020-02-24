//
//  MovieDetailViewController.swift
//  MovieToWatch
//
//  Created by Clark on 20/2/20.
//  Copyright © 2020 Hongfei Yang. All rights reserved.
//

import UIKit
import SDWebImage

class BaseCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    init() {
        let layout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: layout)
        collectionView.backgroundColor = .systemGroupedBackground
        collectionView.contentInsetAdjustmentBehavior = .never
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var topPosterWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    var topPosterHeight: CGFloat {
        return topPosterWidth * 3/2
    }
}


class MovieDetailViewController: BaseCollectionViewController {
    
    let creditsCellId = "creditsCellId"
    let imagesCellId = "imagesCellId"
    let videosCellId = "videosCellId"
    let reviewsCellId = "reviewsCellId"
    
    let movidHeaderId = "movieHeaderId"
    
    var movieDetail: MovieDetail? {
        didSet {
            DispatchQueue.main.async { self.collectionView.reloadData() }
        }
    }
    
    
    var movieId: Int! {
        didSet {
            let query = MovieDetailQuery(movieID: movieId)
            Network.getMovieDetail(query: query) { [weak self] (response) in
                guard let self = self else {return}
                self.movieDetail = response
            }
        }
    }
    
    func setupNavigationBar() {
        let leftItem = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(leftItemTapped))
        navigationItem.leftBarButtonItem = leftItem
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    @objc func leftItemTapped() {
        //navigationController?.navigationBar.isHidden = true
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.alwaysBounceVertical = true
        collectionView.delegate = self
        collectionView.register(MovieHeader.self, forCellWithReuseIdentifier: movidHeaderId)
        collectionView.register(CreditsSectionCell.self, forCellWithReuseIdentifier: creditsCellId)
        collectionView.register(ImagesSectionCell.self, forCellWithReuseIdentifier: imagesCellId)
        collectionView.register(VideosSectionCell.self, forCellWithReuseIdentifier: videosCellId)
        collectionView.register(ReviewsSectionCell.self, forCellWithReuseIdentifier: reviewsCellId)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        navigationController?.navigationBar.isHidden = false
//        setupNavigationBar()
        
        let gesterRecognizer = UITapGestureRecognizer(target: self, action: #selector(leftItemTapped))
        view.addGestureRecognizer(gesterRecognizer)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = navigationController?.viewControllers.count == 1 ? true : false
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell: MovieDetailSectionBaseCell!
        
        if indexPath.item == 0 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: movidHeaderId, for: indexPath) as! MovieHeader
        } else if indexPath.item == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: creditsCellId, for: indexPath) as! CreditsSectionCell
        } else if indexPath.item == 2 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: imagesCellId, for: indexPath) as! ImagesSectionCell
        } else if indexPath.item == 3 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: videosCellId, for: indexPath) as! VideosSectionCell
        } else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: reviewsCellId, for: indexPath) as! ReviewsSectionCell
        }
        cell.movieDetail = movieDetail
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var height: CGFloat = 280
        
        let dummyCell: MovieDetailSectionBaseCell
        
        
        if indexPath.item == 0 {
            return .init(width: topPosterWidth, height: topPosterHeight)
        } else if indexPath.item == 1 {
            dummyCell = CreditsSectionCell(frame: .init(x: 0, y: 0, width: collectionView.frame.width, height: 1000))
        } else if indexPath.item == 2 {
            dummyCell = ImagesSectionCell(frame: .init(x: 0, y: 0, width: collectionView.frame.width, height: 1000))
        } else if indexPath.item == 3 {
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
    
//    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//
//        switch kind {
//        case UICollectionView.elementKindSectionHeader:
//            let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: movidHeaderId, for: indexPath) as! MovieHeader
//            cell.movieDetail = movieDetail
//            return cell
//        default:
//            let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: movidHeaderId, for: indexPath)
//            return cell
//        }
//
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return .init(width: topPosterWidth, height: topPosterHeight)
//    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        guard let cell = collectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionHeader, at: .init(item: 0, section: 0)) as? MovieHeader else {return}
        print("ScrollViewDidScroll ==================>", scrollView.contentOffset)
//        if scrollView.contentOffset.y > 0 {
//            // push poster image up at X/Y scrolling speed when scrolling up
//            cell.clipsToBounds = true
//            cell.imageViewTopConstraint?.constant = scrollView.contentOffset.y//*2/5
//            //cell.imageViewWidthConstraint?.constant = UIScreen.main.bounds.width
////            cell.imageViewHeightConstraint?.constant = UIScreen.main.bounds.width * 3/2
//        } else {
//            // expand poster image proportionally when scrolling down
//            cell.clipsToBounds = false
//            cell.imageViewTopConstraint?.constant = 0
//            //cell.imageViewWidthConstraint?.constant = UIScreen.main.bounds.width -  scrollView.contentOffset.y/3*2
////            cell.imageViewHeightConstraint?.constant = UIScreen.main.bounds.width * 3/2 -  scrollView.contentOffset.y
//        }
    }
    
}
