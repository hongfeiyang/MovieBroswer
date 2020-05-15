//
//  PersonIntroController.swift
//  MovieToWatch
//
//  Created by Clark on 14/3/20.
//  Copyright © 2020 Hongfei Yang. All rights reserved.
//

import UIKit

class PersonIntroController: UIViewController {
    
    public let MOVIE_COLLECTION_VIEW_HEIGHT: CGFloat = 160
    public let NAME_LABEL_FULL_HEIGHT: CGFloat = 80
    let window = UIApplication.shared.windows[0]
    lazy var topPadding = window.safeAreaInsets.top
    lazy var bottomPadding = window.safeAreaInsets.bottom
    lazy var profileImageViewFullHeight = UIScreen.main.bounds.height - topPadding - bottomPadding - MOVIE_COLLECTION_VIEW_HEIGHT
    
    var complementaryTextColor: UIColor?
    
    var personDetail: PersonDetail? {
        didSet {
            let group = DispatchGroup()
            group.enter()
            profileImageView.sd_setImage(with: APIConfiguration.parsePosterURL(file_path: personDetail?.profilePath, size: .original), placeholderImage: Constants.personPlaceholderImage) { [weak self] (image, _, _, _) in
                if let avgColor = image?.averageColor {
                    self?.view.backgroundColor = avgColor
                    self?.nameLabel.textColor = avgColor.complementaryColor
                    self?.complementaryTextColor = avgColor.complementaryColor
                } else {
                    self?.view.backgroundColor = .secondarySystemBackground
                    self?.nameLabel.textColor = .label
                    self?.complementaryTextColor = .label
                }
                group.leave()
            }
            group.notify(queue: .main) {
                self.nameLabel.text = self.personDetail?.name
                self.dataSource = self.personDetail?.movieCredits?.cast
                self.collectionView.reloadData()
            }
        }
    }
    
    var dataSource: [PersonCastCredit]? {
        didSet {
            dataSource?.sort(by: { (lhs, rhs) -> Bool in
                return lhs.popularity ?? 0 > rhs.popularity ?? 0
            })
        }
    }
    
    lazy var blurEdgeLayer: CAGradientLayer = {
        let maskLayer = CAGradientLayer()
        maskLayer.shadowRadius = 10
        maskLayer.shadowOpacity = 1
        maskLayer.shadowOffset = CGSize.zero
        maskLayer.shadowColor = UIColor.white.cgColor
        maskLayer.frame = .init(origin: .zero, size: .init(width: UIScreen.main.bounds.width, height: profileImageViewFullHeight))
        maskLayer.shadowPath = CGPath(roundedRect: CGRect(origin: .zero, size: .init(width: UIScreen.main.bounds.width, height: profileImageViewFullHeight)).insetBy(dx: 5, dy: 5), cornerWidth: 5, cornerHeight: 5, transform: nil)
        return maskLayer
    }()
    
    lazy var profileImageView: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 10
        return view
    }()
    
    var nameLabel = UILabel(text: "", font: UIFont(name: "AvenirNext-Medium", size: 35)!, numberOfLines: 0, textColor: .label, textAlignment: .center)
    var ratingLabel = UILabel(text: "Rating", font: .systemFont(ofSize: 20, weight: .semibold), numberOfLines: 0, textColor: .label, textAlignment: .center)
    var rankingLabel = UILabel(text: "Ranking", font: .systemFont(ofSize: 20, weight: .semibold), numberOfLines: 0, textColor: .label, textAlignment: .center)
    
    lazy var nameLabelContainerView: UIView = {
        let view = UIView()
        view.addSubview(self.nameLabel)
        nameLabel.fillSuperview(padding: .init(top: 0, left: 20, bottom: 0, right: 20))
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            self.ratingLabel,
            self.rankingLabel
        ], axis: .horizontal, spacing: 20, distribution: .fill, alignment: .fill)
        return view
    }()
    
    let cellId = "cellId"
    
    lazy var collectionView: UICollectionView = {
        let layout = BetterSnappingLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.contentInset = .init(top: 0, left: 20, bottom: 0, right: 20)
        view.decelerationRate = .fast
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = .clear
        view.register(PersonIntroMovieCell.self, forCellWithReuseIdentifier: cellId)
        return view
    }()

    var profileImageViewConstraints: AnchoredConstraints?
    var nameLabelConstraints: AnchoredConstraints?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        nameLabel.contentMode = .center
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.minimumScaleFactor = 0
        view.addSubview(profileImageView)
        profileImageViewConstraints = profileImageView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: topPadding, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: profileImageViewFullHeight))
        
        view.addSubview(nameLabelContainerView)
        nameLabelConstraints = nameLabelContainerView.anchor(top: nil, leading: view.leadingAnchor, bottom: profileImageView.bottomAnchor, trailing: view.trailingAnchor, size: .init(width: 0, height: NAME_LABEL_FULL_HEIGHT))
        view.addSubview(collectionView)
        collectionView.anchor(top: profileImageView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: .init(width: 0, height: MOVIE_COLLECTION_VIEW_HEIGHT))
        collectionView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
}


extension PersonIntroController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PersonIntroMovieCell
        cell.data = dataSource?[indexPath.item]
        cell.title.textColor = complementaryTextColor
        cell.rating.textColor = complementaryTextColor
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let id = dataSource?[indexPath.item].id {
            let vc = MovieDetailViewController()
            vc.movieId = id
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.height - 10
        return .init(width: height/2, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
