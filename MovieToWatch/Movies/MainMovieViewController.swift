//
//  MainMovieViewController.swift
//  MovieToWatch
//
//  Created by Clark on 8/1/20.
//  Copyright © 2020 Hongfei Yang. All rights reserved.
//

import UIKit

class MainMovieViewController: UIViewController {
    
    var nowPlayingResult: [NowPlayingResult]?
    var topRatedResult: [TopRatedResult]?
    var upcomingResult: [UpcomingResult]?
    var popularResult: [PopularResult]?
    
    let nowPlayingQuery: NowPlayingQuery = {
        var query = NowPlayingQuery()
        query.region = "AU"
        return query
    }()
    
    let topRatedQuery: TopRatedQuery = {
        var query = TopRatedQuery()
        query.region = "AU"
        return query
    }()
    
    var upcomingQuery: UpcomingQuery = {
        var query = UpcomingQuery()
        query.region = "AU"
        return query
    }()
    
    var popularQuery: PopularQuery = {
        var query = PopularQuery()
        query.region = "AU"
        return query
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = BetterSnappingLayout()
        // layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let view = UICollectionView(frame: .zero , collectionViewLayout: layout)
        view.decelerationRate = .fast
        view.showsVerticalScrollIndicator = false
        view.backgroundColor = .systemBackground
        view.delegate = self
        view.dataSource = self
        view.register(MovieCategoryCell.self, forCellWithReuseIdentifier: "CategoryCell")
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        collectionView.fillSuperview()
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}



extension MainMovieViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! MovieCategoryCell
        switch(indexPath.item) {
        case 0:
            cell.dataSource = nowPlayingResult
            cell.titleLabel.text = "In Cinema"
        case 1:
            cell.dataSource = popularResult
            cell.titleLabel.text = "Popular"
        case 2:
            cell.dataSource = upcomingResult
            cell.titleLabel.text = "Upcoming"
        case 3:
            cell.dataSource = topRatedResult
            cell.titleLabel.text = "Top Rated"
        default:
            fatalError("not implemented")
        }
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //return .init(width: UIScreen.main.bounds.width, height: 200)
        let width = collectionView.frame.width
        let dummyCell = MovieCategoryCell(frame: .init(origin: .zero, size: .init(width: width, height: 1000)))
        switch(indexPath.item) {
        case 0:
            dummyCell.dataSource = nowPlayingResult
            dummyCell.titleLabel.text = "In Cinema"
        case 1:
            dummyCell.dataSource = popularResult
            dummyCell.titleLabel.text = "Popular"
        case 2:
            dummyCell.dataSource = upcomingResult
            dummyCell.titleLabel.text = "Upcoming"
        case 3:
            dummyCell.dataSource = topRatedResult
            dummyCell.titleLabel.text = "Top Rated"
        default:
            fatalError("not implemented")
        }
        dummyCell.layoutIfNeeded()
        let estimatedSize = dummyCell.systemLayoutSizeFitting(.init(width: width, height: 1000))
        return .init(width: width, height: estimatedSize.height)
    }
}

extension MainMovieViewController {
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
