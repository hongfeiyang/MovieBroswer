//
//  ViewController.swift
//  MovieToWatch
//
//  Created by Clark on 16/12/19.
//  Copyright © 2019 Hongfei Yang. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    
    private var cardPresentAnimator = CardPresentAnimator()
    private var cardDismissAnimator = CardDismissAnimator()
    private var currentPage = 0
    private var pageIsLoadingMoreContent = false
    
    private var results = [MovieResult]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
//    private var movieDetailDict = [Int: MovieDetail]()
    
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.refreshControl = refreshControl
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CardCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return collectionView
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return control
    }()
    
    @objc private func refresh() {
        currentPage = 1
        loadMoreData { results in
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
                self.results = results
            }
        }
    }
    
    private func setupLayout() {
        
        let constraints = [
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        setupLayout()
        refresh()
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = UIScreen.main.bounds.width - 40
        let height = width * 6/5
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? CardCollectionViewCell else {fatalError("no cell named CardCollectionViewCell")}
        
        let result = results[indexPath.row]
        let id = result.id
        
        cell.content = (result, nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //guard let cell = collectionView.cellForItem(at: indexPath) as? CardCollectionViewCell else {fatalError("failed to cast cell as CardColectionCell at didSelectItemAtIndexPath")}
        
        let vc = DetailMovieViewController()
        let result = results[indexPath.row]
        let id = result.id
        
        vc.movieID = id
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = self
        //vc.isModalInPresentation = true
        present(vc, animated: true, completion: nil)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let yOffset = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let triggerOffset = CGFloat(100)
        
        if yOffset > contentHeight - scrollView.frame.height + triggerOffset && !pageIsLoadingMoreContent {
            currentPage += 1
            loadMoreData { results in
                DispatchQueue.main.async {
                    self.results += results
                    NSLog("new content loaded")
                    self.pageIsLoadingMoreContent = false
                }
            }
            pageIsLoadingMoreContent = true
        }
    }
    
}

extension MainViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        guard
            let selectedIndexPathCell = collectionView.indexPathsForSelectedItems?.first,
            let selectedCell = collectionView.cellForItem(at: selectedIndexPathCell) as? CardCollectionViewCell,
            let selectedCellSuperview = selectedCell.superview
            else {
                return nil
        }
        
        cardPresentAnimator.cell = selectedCell
        cardPresentAnimator.originFrame = selectedCellSuperview.convert(selectedCell.frame, to: nil)
        
        return cardPresentAnimator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        guard
            let selectedIndexPathCell = collectionView.indexPathsForSelectedItems?.first,
            let selectedCell = collectionView.cellForItem(at: selectedIndexPathCell) as? CardCollectionViewCell,
            let selectedCellSuperview = selectedCell.superview
            else {
                return nil
        }
        cardDismissAnimator.cell = selectedCell
        cardDismissAnimator.originFrame = selectedCellSuperview.convert(selectedCell.frame, to: nil)
        
        return cardDismissAnimator
    }
    
}


extension MainViewController {
    
    private func loadMoreData(completion: (([MovieResult]) -> Void)?) {
        let discoverMovieQuery = DiscoverMovieQuery(language: nil, region: "AU", sort_option: nil, order: nil, page: currentPage, include_adult: true, include_video: true)
        Network.getDiscoverMovieResults(query: discoverMovieQuery) { results in
//            for result in results {
//                let movieID = result.id
//                let movieDetailQuery = MovieDetailQuery(movieID: movieID)
//                Network.getMovieDetail(query: movieDetailQuery) { [weak self] detail in
//                    self?.movieDetailDict[movieID] = detail
//                }
//            }
            completion?(results)
        }
    }
    
    private func configureCell() {
        
    }
}
