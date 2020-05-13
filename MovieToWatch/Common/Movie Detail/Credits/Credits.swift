//
//  Credits.swift
//  MovieToWatch
//
//  Created by Clark on 20/2/20.
//  Copyright © 2020 Hongfei Yang. All rights reserved.
//

import UIKit

class CreditsSectionCell: MovieDetailSectionBaseCell {
    
    override var movieDetail: MovieDetail? {
        didSet {
            DispatchQueue.main.async {
                self.directorButton.contentLabel.text = self.directorCrew?.name
                self.collectionView.reloadData()
            }
        }
    }
    
    var credits: Credits? {
        return movieDetail?.credits
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
    //var allCrewButton = BaseButton(topic: "All Cast and Crew", content: "")
    
    lazy var collectionView: UICollectionView = {
        let layout = BetterSnappingLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.decelerationRate = .fast
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = .init(top: 0, left: 10, bottom: 0, right: 30)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CastCell.self, forCellWithReuseIdentifier: "CastCell")
        collectionView.heightAnchor.constraint(equalToConstant: 210).isActive = true
        return collectionView
    }()
    
    lazy var stackView: UIStackView = {
        let view = VerticalStackView(arrangedSubviews: [
            self.titleButton,
            self.collectionView,
            self.directorButton,
            //self.allCrewButton
        ])
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(stackView)
        stackView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension CreditsSectionCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return casts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CastCell", for: indexPath) as! CastCell
        cell.viewModel = casts[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cast = casts[indexPath.item]
        let vc = PersonContainerController()
        vc.personId = cast.id!
        vc.hidesBottomBarWhenPushed = true
        navController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return .init(width: 90, height: collectionView.frame.height - 5*2)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
