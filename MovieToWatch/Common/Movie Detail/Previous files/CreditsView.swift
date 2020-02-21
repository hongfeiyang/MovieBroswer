//
//  CastView.swift
//  MovieToWatch
//
//  Created by Clark on 27/12/19.
//  Copyright © 2019 Hongfei Yang. All rights reserved.
//

import UIKit

class CreditsView: UIView {

    
    var credits: Credits? {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.directorButton.contentLabel.text = self.directorCrew?.name
            }
        }
    }
    
    var casts: [Cast] {
        return credits?.cast ?? []
    }
    
    var directorCrew: Crew? {
        return credits?.crew.first {
            $0.job == "Director"
        }
    }
    
    var titleButton = BaseButton(topic: "Cast", content: "")
    
    var directorButton = BaseButton(topic: "Director: ", content: "")
    
    var allCrewButton = BaseButton(topic: "All Cast and Crew", content: "")
    

    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .secondarySystemBackground
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CreditsCell.self, forCellWithReuseIdentifier: "CastCell")
        return collectionView
    }()
    
    
    private func setupLayout() {
        
        let padding = CGFloat(5)
        titleButton.translatesAutoresizingMaskIntoConstraints = false
        directorButton.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        allCrewButton.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            titleButton.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            titleButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleButton.heightAnchor.constraint(equalToConstant: 40),
            
            collectionView.topAnchor.constraint(equalTo: titleButton.bottomAnchor, constant: padding),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 180),
            
            directorButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: padding),
            directorButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            directorButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            directorButton.heightAnchor.constraint(equalToConstant: 40),
            
            allCrewButton.topAnchor.constraint(equalTo: directorButton.bottomAnchor, constant: padding),
            allCrewButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            allCrewButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            allCrewButton.heightAnchor.constraint(equalToConstant: 40),
            
            allCrewButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleButton)
        addSubview(collectionView)
        addSubview(directorButton)
        addSubview(allCrewButton)
        backgroundColor = .secondarySystemBackground
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}


extension CreditsView: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return casts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CastCell", for: indexPath) as! CreditsCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let cell = cell as! CreditsCell
        cell.nameLabel.text = casts[indexPath.item].name
        cell.characterLabel.text = casts[indexPath.item].character
        cell.profileImageView.image = nil
        cell.profileImageURL = APIConfiguration.parsePosterURL(file_path: casts[indexPath.item].profilePath, size: .w154)
        cell.profileImageView.image = UIImage(systemName: "photo")
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 80, height: 180)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}

class CreditsCell: UICollectionViewCell {
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 10, weight: .light)
        label.textColor = .label
        label.numberOfLines = 2
        label.sizeToFit()
        return label
    }()
    
    var characterLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 10, weight: .ultraLight)
        label.textColor = .label
        label.numberOfLines = 2
        label.sizeToFit()
        return label
    }()
    
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
        
        let padding = CGFloat(5)
        
        let constraints = [
            
            // profile photo has height 120
            profileImageView.topAnchor.constraint(equalTo: topAnchor),
            profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            profileImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            //profileImageView.heightAnchor.constraint(equalToConstant: 90),
            profileImageView.widthAnchor.constraint(equalTo: profileImageView.heightAnchor, multiplier: 2/3),
            
            // vertical padding is 5
            
            // label has height 20
            nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: padding),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            nameLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 20),
            
            // vertical padding is 5
            
            // label height 20
            
            characterLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: padding),
            characterLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            characterLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            characterLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 20),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(profileImageView)
        addSubview(nameLabel)
        addSubview(characterLabel)
        setupLayout()
        backgroundColor = .tertiarySystemBackground
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CreditsCell {
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
