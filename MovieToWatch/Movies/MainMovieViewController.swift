//
//  MainMovieViewController.swift
//  MovieToWatch
//
//  Created by Clark on 8/1/20.
//  Copyright © 2020 Hongfei Yang. All rights reserved.
//

import UIKit

class MainMovieViewController: UIViewController {

    let query = NowPlayingQuery(language: nil, page: 1, region: "AU")
    let page = 1
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero , collectionViewLayout: layout)
        view.delegate = self
        view.dataSource = self
        view.register(NowPlayingCell.self, forCellWithReuseIdentifier: "NowPlayingCell")
        view.backgroundColor = .systemBackground
        return view
    }()
        
    var dataSource = [NowPlayingResult]()
    
    
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
        Network.getNowPlaying(query: query) { [weak self] (nowPlaying) in
            DispatchQueue.main.async {
                self?.dataSource = nowPlaying.results
                self?.collectionView.reloadData()
            }
        }
    }
}

extension MainMovieViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NowPlayingCell", for: indexPath) as! NowPlayingCell
        cell.label.text = dataSource[indexPath.row].title
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 80, height: 80)
    }
}

class NowPlayingCell: UICollectionViewCell {
    
    var label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 15, weight: .thin)
        return label
    }()
    
    private func setupLayout() {
        label.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            label.topAnchor.constraint(equalTo: topAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGroupedBackground
        addSubview(label)
        setupLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
