//
//  ImagesView.swift
//  MovieToWatch
//
//  Created by Clark on 1/1/20.
//  Copyright © 2020 Hongfei Yang. All rights reserved.
//

import UIKit

class MovieImagesView: UIView {
    
    var allImagesButton = BaseButton(topic: "Images", content: "view all")
    
    var data = MovieImages(backdrops: [], posters: []) {
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
        collectionView.register(MovieImagesCell.self, forCellWithReuseIdentifier: "ImagesCell")
        return collectionView
    }()
    
    private func setupLayout() {
        let padding = CGFloat(5)
        allImagesButton.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            allImagesButton.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            allImagesButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            allImagesButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            allImagesButton.heightAnchor.constraint(equalToConstant: 40),
            
            collectionView.topAnchor.constraint(equalTo: allImagesButton.bottomAnchor, constant: padding),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(allImagesButton)
        addSubview(collectionView)
        
        backgroundColor = .secondarySystemBackground
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension MovieImagesView: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    fileprivate var cellHeight: Double {
        return 120.0
    }
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.backdrops.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImagesCell", for: indexPath) as! MovieImagesCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let cell = cell as! MovieImagesCell

        cell.profileImageView.image = nil
        let imagePathToDisplay = data.backdrops[indexPath.row].filePath
        cell.profileImageURL = APIConfiguration.parsePosterURL(file_path: imagePathToDisplay, size: .w500)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let image = data.backdrops[indexPath.row]
        let widthToDisplay = cellHeight / Double(image.height!) * Double(image.width!)
        
        return .init(width: widthToDisplay, height: cellHeight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}

class MovieImagesCell: UICollectionViewCell {

    var profileImageURL: URL? {
        didSet {
            fetchAndSetImage()
        }
    }
    
    var profileImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    private func setupLayout() {
                
        let constraints = [
            profileImageView.topAnchor.constraint(equalTo: topAnchor),
            profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            profileImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            profileImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(profileImageView)
        setupLayout()
        backgroundColor = .tertiarySystemBackground
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MovieImagesCell {
    private func fetchAndSetImage() {

//        DispatchQueue.main.async {
//            self.profileImageView.image = nil
//        }
//        
        guard let url = profileImageURL else {print("failed to have a valid image url"); return}

        Cache.shared.cacheImage(url: url) { [weak self] (url, image) in
            if url == self?.profileImageURL {
                DispatchQueue.main.async {
                    self?.profileImageView.image = image
                }
            }
        }
    }
}

