//
//  TrendingController.swift
//  MovieToWatch
//
//  Created by Clark on 12/3/20.
//  Copyright © 2020 Hongfei Yang. All rights reserved.
//

import UIKit

class TrendingController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
//    var dataSource: [ISearchResult]? {
//        didSet { DispatchQueue.main.async { self.collectionView.reloadData() } }
//    }
    
//    var personResult: [PersonMultiSearchResult]? {
//        return (dataSource?.filter { $0.media_type == .person }) as? [PersonMultiSearchResult]
//    }
    
//    var movieResult: [MovieMultiSearchResult]? {
//        return (dataSource?.filter { $0.media_type == .movie }) as? [MovieMultiSearchResult]
//    }
    
    var movieResult: [MovieMultiSearchResult]? {
        didSet { DispatchQueue.main.async { self.collectionView.reloadData() } }
    }
    
    var personResult: [PersonMultiSearchResult]? {
        didSet { DispatchQueue.main.async { self.collectionView.reloadData() } }
    }
    
    init() {
        let layout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.register(PersonTrendingSectionCell.self, forCellWithReuseIdentifier: personSectionCellId)
        collectionView.register(TrendingMovieCell.self, forCellWithReuseIdentifier: trendingMovieCellId)
        collectionView.register(TrendingSectionHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: sectionHeaderCellId)
        collectionView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let personSectionCellId = "personCellId"
    let movieSectionCellId = "movieCellId"
    let trendingMovieCellId = "trendingMovieCellId"
    let sectionHeaderCellId = "sectionHeaderCellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return movieResult?.count ?? 0
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: personSectionCellId, for: indexPath) as! PersonTrendingSectionCell
            cell.dataSource = personResult
            cell.navController = navigationController
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: trendingMovieCellId, for: indexPath) as! TrendingMovieCell
            cell.result = movieResult?[indexPath.item]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
//            let cell = PersonTrendingSectionCell(frame: .init(origin: .zero, size: .init(width: collectionView.frame.width, height: 1000)))
//            cell.dataSource = personResult
//            cell.layoutIfNeeded()
//            let size = cell.systemLayoutSizeFitting(.init(width: collectionView.frame.width, height: 1000))
//            return size
            return .init(width: collectionView.frame.width, height: 140)
        } else {
            let cell = TrendingMovieCell(frame: .init(origin: .zero, size: .init(width: collectionView.frame.width, height: 1000)))
            cell.result = movieResult?[indexPath.item]
            cell.layoutIfNeeded()
            let size = cell.systemLayoutSizeFitting(.init(width: collectionView.frame.width, height: 1000))
            return .init(width: collectionView.frame.width, height: size.height)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: sectionHeaderCellId, for: indexPath) as! TrendingSectionHeaderCell
            cell.titleLabel.text = "Trending Person"
            return cell
        } else {
            let cell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: sectionHeaderCellId, for: indexPath) as! TrendingSectionHeaderCell
            cell.titleLabel.text = "Trending Movies"
            return cell
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            
        } else {
            let result = movieResult?[indexPath.item]
            if let id = result?.id {
                let vc = MovieDetailViewController()
                vc.movieId = id
                vc.hidesBottomBarWhenPushed = true
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: collectionView.frame.width, height: 40)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadTrending(media_type: .movie, time_window: .day) { [weak self] in
            //self?.dataSource = $0?.results
            self?.movieResult = $0?.results as? [MovieMultiSearchResult]
        }
        
        loadTrending(media_type: .person, time_window: .day) { [weak self] in
            self?.personResult = $0?.results as? [PersonMultiSearchResult]
        }
    }
    
    func loadTrending(media_type: TrendingMediaType, time_window: TimeWindow, completion: ((MultiSearchResults?) -> Void)?) {
        let item = TrendingQuery(media_type: media_type, time_window: time_window)
        Network.getTrending(query: item) { (res) in
            switch res {
            case .success(let trendingResults):
                completion?(trendingResults)
            case .failure(let error):
                completion?(nil)
                print(error)
            }
        }
    }
}
