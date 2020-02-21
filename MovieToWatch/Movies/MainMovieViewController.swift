//
//  MainMovieViewController.swift
//  MovieToWatch
//
//  Created by Clark on 8/1/20.
//  Copyright © 2020 Hongfei Yang. All rights reserved.
//

import UIKit

class MainMovieViewController: UIViewController {
    
    
    var nowPlayingResult = [NowPlayingResult]()
    var topRatedResult = [TopRatedResult]()
    
    let nowPlayingQuery = NowPlayingQuery(language: nil, page: 1, region: "AU")
    let nowPlayingPage = 1
    
    let topRatedQuery = TopRatedQuery(language: nil, page: 1, region: "AU")
    let topRatedPage = 1

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero , collectionViewLayout: layout)
        view.delegate = self
        view.dataSource = self
        view.register(MovieCategoryCell.self, forCellWithReuseIdentifier: "CategoryCell")
        view.backgroundColor = .systemBackground
        return view
    }()
        
    private func setupLayout() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        setupLayout()
        
        Network.getNowPlaying(query: nowPlayingQuery) { [weak self] (result) in
            DispatchQueue.main.async {
                self?.nowPlayingResult = result.results
                self?.collectionView.reloadData()
            }
        }
        
        Network.getTopRated(query: topRatedQuery) { [weak self] (result) in
            DispatchQueue.main.async {
                self?.topRatedResult = result.results
                self?.collectionView.reloadData()
            }
        }
    }
}

extension MainMovieViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! MovieCategoryCell
        cell.resetContent()
        switch(indexPath.row) {
        case 0:
            cell.dataSource = nowPlayingResult.map {
                $0.toMovieCategoryItem()
            }
        case 1:
            cell.dataSource = topRatedResult.map {
                $0.toMovieCategoryItem()
            }
        default:
            break
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: UIScreen.main.bounds.width, height: 200)
    }
}


