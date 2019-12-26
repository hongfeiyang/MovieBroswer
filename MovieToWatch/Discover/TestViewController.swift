//
//  TestViewController.swift
//  MovieToWatch
//
//  Created by Clark on 25/12/19.
//  Copyright © 2019 Hongfei Yang. All rights reserved.
//

import Foundation
import UIKit



class TestViewController: UIViewController {
    
    
    private var cardPresentAnimator = CardPresentAnimator()
    private var cardDismissAnimator = CardDismissAnimator()
    private var currentPage = 0
    private var pageIsLoadingMoreContent = false

    private lazy var collectionView: UICollectionView = {
        
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .systemBackground
        collectionView.refreshControl = refreshControl
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CardViewCell.self, forCellWithReuseIdentifier: "Cell")
        return collectionView
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return control
    }()
    
    private var results = [DiscoverMovieResult]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    private var discoverMovieQuery = DiscoverMovieQuery()
    
    
    @objc private func refresh() {
        currentPage = 1
        results.removeAll()
        loadMoreData() {
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
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
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Discover"
        
        let barItem = UIBarButtonItem(title: "Rank By", style: .plain, target: self, action: #selector(changeOrder))
        navigationItem.rightBarButtonItem = barItem
    }
    
    
    
    
    @objc private func changeOrder() {
        let vc = UIAlertController(title: "Rank By", message: "Choose a ranking method", preferredStyle: .actionSheet)
        let action1 = UIAlertAction(title: "Popularity", style: .default) { _ in
            self.discoverMovieQuery.sort_option = .popularity
            self.discoverMovieQuery.order = .desc
            self.refresh()
        }
        let action2 = UIAlertAction(title: "Revenue", style: .default) { _ in
            self.discoverMovieQuery.sort_option = .revenue
            self.discoverMovieQuery.order = .desc
            self.refresh()
        }
        let action3 = UIAlertAction(title: "Release Date", style: .default) { _ in
            self.discoverMovieQuery.sort_option = .release_date
            self.discoverMovieQuery.order = .desc
            self.refresh()
        }
        let action4 = UIAlertAction(title: "Rating", style: .default) { _ in
            self.discoverMovieQuery.sort_option = .vote_average
            self.discoverMovieQuery.order = .desc
            self.refresh()
        }
        let action5 = UIAlertAction(title: "Vote Count", style: .default) { _ in
            self.discoverMovieQuery.sort_option = .vote_count
            self.discoverMovieQuery.order = .desc
            self.refresh()
        }
        
        let cancel = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        
        vc.addAction(action1)
        vc.addAction(action2)
        vc.addAction(action3)
        vc.addAction(action4)
        vc.addAction(action5)
        vc.addAction(cancel)
        present(vc, animated: true)
    }
    
}


extension TestViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CardViewCell

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        configureCell(cell as! CardViewCell, at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CardViewCell
        selectRow(cell, at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width - 20 * 2
        let height = width * 6/5
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let yOffset = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let triggerOffset = CGFloat(100)
        
        if yOffset > contentHeight - scrollView.frame.height + triggerOffset && !pageIsLoadingMoreContent {
            currentPage += 1
            loadMoreData() {
                self.pageIsLoadingMoreContent = false
            }
            self.pageIsLoadingMoreContent = true
            
        }
    }
    
}



extension TestViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        guard
            let selectedIndexPathCell = collectionView.indexPathsForSelectedItems?.first,
            let selectedCell = collectionView.cellForItem(at: selectedIndexPathCell) as? CardViewCell,
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
            let selectedCell = collectionView.cellForItem(at: selectedIndexPathCell) as? CardViewCell,
            let selectedCellSuperview = selectedCell.superview
            else {
                return nil
        }
        cardDismissAnimator.cell = selectedCell
        cardDismissAnimator.originFrame = selectedCellSuperview.convert(selectedCell.frame, to: nil)
        
        return cardDismissAnimator
    }
    
}


extension TestViewController {
    
    private func loadMoreData(completion: (() -> Void)? = nil) {
        discoverMovieQuery.page = currentPage
        Network.getDiscoverMovieResults(query: discoverMovieQuery) { results in
            self.results += results
            completion?()
        }
    }
    
    private func configureCell(_ cell: CardViewCell, at indexPath: IndexPath) {
        let result = results[indexPath.row]
        cell.content = result
    }
    
    private func selectRow(_ cell: CardViewCell, at indexPath: IndexPath) {
        let vc = DetailMovieViewController()
        //vc.content = result
        let result = results[indexPath.row]
        
        vc.movieID = result.id
        vc.imageURLString = result.posterPath
        vc.hidesBottomBarWhenPushed = true
        vc.posterImage = cell.posterImageView.image
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = self
        //vc.isModalInPresentation = true
        present(vc, animated: true, completion: nil)
    }
    
}

