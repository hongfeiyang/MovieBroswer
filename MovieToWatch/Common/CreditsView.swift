//
//  CastView.swift
//  MovieToWatch
//
//  Created by Clark on 27/12/19.
//  Copyright © 2019 Hongfei Yang. All rights reserved.
//

import UIKit

class CreditsView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var credits: Credits? {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                
                // update director button
                let attributes: [NSAttributedString.Key: Any] = [
                    .foregroundColor: UIColor.secondaryLabel,
                    .font: UIFont.systemFont(ofSize: 15, weight: .regular)
                ]
                let attributedString = NSMutableAttributedString(string: "Director: \(self.directorCrew?.name ?? "")", attributes: attributes)
                let addedAttributes: [NSAttributedString.Key: Any] = [
                    .foregroundColor: UIColor.label,
                ]
                attributedString.addAttributes(addedAttributes, range: .init(location: 0, length: "Director:".count))
                self.directorButton.setAttributedTitle(attributedString, for: .normal)
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
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Cast"
        label.textAlignment = .left
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .secondarySystemGroupedBackground
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CreditsCell.self, forCellWithReuseIdentifier: "CastCell")
        return collectionView
    }()
    
    lazy var directorButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setTitleColor(.label, for: .normal)
        //button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    
    private func setupLayout() {
        
        let padding = CGFloat(5)
        
        let constraints = [
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.heightAnchor.constraint(greaterThanOrEqualToConstant: 180),
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding * 4),
            
            directorButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: padding),
            directorButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            directorButton.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
            directorButton.heightAnchor.constraint(equalToConstant: 20),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleLabel)
        addSubview(collectionView)
        addSubview(directorButton)
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
        if let profilePath = casts[indexPath.item].profilePath {
            cell.profileImageURL = APIConfiguration.parsePosterURL(file_path: profilePath, size: .w154)
        }
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CreditsCell {
    private func fetchAndSetImage() {

        guard let url = profileImageURL else {print("failed to have a valid image url"); return}

        DispatchQueue.main.async {
            self.profileImageView.image = UIImage(named: "photo")
        }

        Cache.shared.cacheImage(url: url) { [weak self] (url, image) in
            if url == self?.profileImageURL {
                DispatchQueue.main.async {
                    self?.profileImageView.image = image
                }
            }
        }
    }
}
