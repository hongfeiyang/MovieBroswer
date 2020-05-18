//
//  HorizontalMovieCollectionCell.swift
//  MovieToWatch
//
//  Created by Clark on 17/1/20.
//  Copyright © 2020 Hongfei Yang. All rights reserved.
//

import UIKit

class HorizontalMovieCollectionCell: BaseMovieDetailSectionCell {

    weak var parentController: UIViewController?
    
    var movieItems: [IndividualMovieItem]? {
        didSet {
            if let items = movieItems, items.count > 0 {
                emptyDatasourceLabel.isHidden = true
            } else {
                emptyDatasourceLabel.isHidden = false
            }
            DispatchQueue.main.async { self.movieCollectionView.reloadData() }
        }
    }
    
    var titleLabel = UILabel(text: "", font: .systemFont(ofSize: 22, weight: .bold), numberOfLines: 0, textColor: .label, textAlignment: .left)
    
    lazy var movieCollectionView: UICollectionView = {
        let layout = BetterSnappingLayout()
        //layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.decelerationRate = .fast
        view.showsHorizontalScrollIndicator = false
        view.contentInset = .init(top: 0, left: 20, bottom: 0, right: 20)
        view.register(IndividualMovieCell.self, forCellWithReuseIdentifier: "IndividualMovieCell")
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = .clear
        view.constrainHeight(constant: 210)
        return view
    }()

    func setupLayout() {
        addSubview(movieCollectionView)
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 20, left: 20, bottom: 0, right: 20))
        movieCollectionView.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 20, left: 0, bottom: 0, right: 0))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        
        emptyDatasourceLabel.text = "No Movies"
        movieCollectionView.addSubview(emptyDatasourceLabel)
        emptyDatasourceLabel.centerInSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HorizontalMovieCollectionCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieItems?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IndividualMovieCell", for: indexPath) as! IndividualMovieCell
        cell.movieItem = movieItems?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = movieItems?[indexPath.item]
        let vc = MovieDetailViewController()
        vc.movieId = item?.id
        vc.hidesBottomBarWhenPushed = true
        parentController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 100, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
