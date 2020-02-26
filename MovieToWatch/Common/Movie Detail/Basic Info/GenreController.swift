//
//  GenreController.swift
//  MovieToWatch
//
//  Created by Clark on 26/2/20.
//  Copyright © 2020 Hongfei Yang. All rights reserved.
//

import UIKit

class GenreController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let genreCellId = "genreCellId"
    
    var data: [Genre]? {
        didSet {
            DispatchQueue.main.async { self.collectionView.reloadData() }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        collectionView.backgroundColor = .clear
        collectionView.register(GenreCell.self, forCellWithReuseIdentifier: genreCellId)
    }

    init() {
        let layout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: genreCellId, for: indexPath) as! GenreCell
        cell.genre = data?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let dummyCell = GenreCell(frame: .init(x: 0, y: 0, width: 1000, height: collectionView.frame.height))
        dummyCell.genre = data?[indexPath.row]
        let size = dummyCell.systemLayoutSizeFitting(.init(width: 1000, height: collectionView.frame.height))
        return .init(width: size.width, height: collectionView.frame.height)
    }
}
