//
//  MovieVideosView.swift
//  MovieToWatch
//
//  Created by Clark on 2/1/20.
//  Copyright © 2020 Hongfei Yang. All rights reserved.
//

import UIKit
import WebKit

class MovieVideosView: UIView {
    
    var allVideosButton = BaseButton(topic: "Videos", content: "view all")
    
    var data = MovieVideos(results: []) {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .secondarySystemBackground
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MovieVideosCell.self, forCellWithReuseIdentifier: "VideosCell")
        return collectionView
    }()
    
    private func setupLayout() {
        let padding = CGFloat(5)
        allVideosButton.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            allVideosButton.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            allVideosButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            allVideosButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            allVideosButton.heightAnchor.constraint(equalToConstant: 40),
            
            collectionView.topAnchor.constraint(equalTo: allVideosButton.bottomAnchor, constant: padding),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(allVideosButton)
        addSubview(collectionView)
        
        backgroundColor = .secondarySystemBackground
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension MovieVideosView: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    fileprivate var cellHeight: Double {
        return 120.0
    }
    
    fileprivate var cellWidth: Double {
        return 120.0 / 1080 * 1920
    }
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideosCell", for: indexPath) as! MovieVideosCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let cell = cell as! MovieVideosCell
        
        guard let site = data.results[indexPath.row].site else {return}
        switch site {
        case "YouTube":
            let videoKey = data.results[indexPath.row].key!
            let url = URL(string: "https://www.youtube.com/embed/\(videoKey)")!
            let request = URLRequest(url: url)
            cell.videoView.stopLoading()
            cell.videoView.load(request)
        default:
            return
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return .init(width: cellWidth, height: cellHeight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}

class MovieVideosCell: UICollectionViewCell {

    var profileImageURL: URL? {
        didSet {
            fetchAndSetImage()
        }
    }
    
    var videoView: WKWebView = {
        let configuration = WKWebViewConfiguration()
        let view = WKWebView(frame: .zero, configuration: configuration)
        view.scrollView.isScrollEnabled = false
        view.clipsToBounds = true
        return view
    }()
    
    private func setupLayout() {
        
        videoView.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            videoView.topAnchor.constraint(equalTo: topAnchor),
            videoView.leadingAnchor.constraint(equalTo: leadingAnchor),
            videoView.trailingAnchor.constraint(equalTo: trailingAnchor),
            videoView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(videoView)
        setupLayout()
        backgroundColor = .tertiarySystemBackground
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MovieVideosCell {
    private func fetchAndSetImage() {

//        DispatchQueue.main.async {
//            self.profileImageView.image = nil
//        }
//
        guard let url = profileImageURL else {print("failed to have a valid image url"); return}

        Cache.shared.cacheImage(url: url) { [weak self] (url, image) in
            if url == self?.profileImageURL {
                DispatchQueue.main.async {
                    //self?.videoView.image = image
                }
            }
        }
    }
}


