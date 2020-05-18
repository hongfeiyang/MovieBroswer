//
//  MainMovieViewController.swift
//  MovieToWatch
//
//  Created by Clark on 8/1/20.
//  Copyright © 2020 Hongfei Yang. All rights reserved.
//

import UIKit

class BrowseMovieViewController: UIViewController {
    
    var nowPlayingResult: [MovieListResult]?
    var topRatedResult: [MovieListResult]?
    var upcomingResult: [MovieListResult]?
    var popularResult: [MovieListResult]?
    
    let nowPlayingQuery = NowPlayingQuery(region: "AU")
    let topRatedQuery = TopRatedQuery(region: "AU")
    let upcomingQuery = UpcomingQuery(region: "AU")
    let popularQuery = PopularQuery(region: "AU")
       
    lazy var collectionView: UICollectionView = {
        let layout = BetterSnappingLayout()
        // layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let view = UICollectionView(frame: .zero , collectionViewLayout: layout)
        view.decelerationRate = .fast
        view.showsVerticalScrollIndicator = false
        view.backgroundColor = .systemBackground
        view.delegate = self
        view.dataSource = self
        view.register(HorizontalMovieCollectionCell.self, forCellWithReuseIdentifier: "CategoryCell")
        return view
    }()
    
    func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Browse"
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.label]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.label]
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        collectionView.fillSuperview()
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
}



extension BrowseMovieViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! HorizontalMovieCollectionCell
        switch(indexPath.item) {
        case 0:
            cell.movieItems = nowPlayingResult?.map{IndividualMovieItem(movieListResult: $0)}
            cell.titleLabel.text = "In Cinema"
        case 1:
            cell.movieItems = popularResult?.map{IndividualMovieItem(movieListResult: $0)}
            cell.titleLabel.text = "Popular"
        case 2:
            cell.movieItems = upcomingResult?.map{IndividualMovieItem(movieListResult: $0)}
            cell.titleLabel.text = "Upcoming"
        case 3:
            cell.movieItems = topRatedResult?.map{IndividualMovieItem(movieListResult: $0)}
            cell.titleLabel.text = "Top Rated"
        default:
            fatalError("not implemented")
        }
        cell.parentController = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //return .init(width: UIScreen.main.bounds.width, height: 200)
        let width = collectionView.frame.width
        let dummyCell = HorizontalMovieCollectionCell(frame: .init(origin: .zero, size: .init(width: width, height: 1000)))
        switch(indexPath.item) {
        case 0:
            dummyCell.movieItems = nowPlayingResult?.map{IndividualMovieItem(movieListResult: $0)}
            dummyCell.titleLabel.text = "In Cinema"
        case 1:
            dummyCell.movieItems = popularResult?.map{IndividualMovieItem(movieListResult: $0)}
            dummyCell.titleLabel.text = "Popular"
        case 2:
            dummyCell.movieItems = upcomingResult?.map{IndividualMovieItem(movieListResult: $0)}
            dummyCell.titleLabel.text = "Upcoming"
        case 3:
            dummyCell.movieItems = topRatedResult?.map{IndividualMovieItem(movieListResult: $0)}
            dummyCell.titleLabel.text = "Top Rated"
        default:
            fatalError("not implemented")
        }
        dummyCell.layoutIfNeeded()
        let estimatedSize = dummyCell.systemLayoutSizeFitting(.init(width: width, height: 1000))
        return .init(width: width, height: estimatedSize.height)
    }
}

extension BrowseMovieViewController {
    func loadData() {
        let group = DispatchGroup()
        group.enter()
        Network.getNowPlaying(query: nowPlayingQuery) { [weak self] (result) in
            self?.nowPlayingResult = result?.results
            group.leave()
        }
        
        group.enter()
        Network.getTopRated(query: topRatedQuery) { [weak self] (result) in
            self?.topRatedResult = result?.results
            group.leave()
        }
        
        group.enter()
        Network.getUpcoming(query: upcomingQuery) { [weak self] (result) in
            self?.upcomingResult = result?.results
            group.leave()
        }
        
        group.enter()
        Network.getPopular(query: popularQuery) { [weak self] (result) in
            self?.popularResult = result?.results
            group.leave()
        }
        group.notify(queue: .main) { [weak self] in
            self?.collectionView.reloadData()
        }
    }
}
