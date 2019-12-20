//
//  ViewController.swift
//  MovieToWatch
//
//  Created by Clark on 16/12/19.
//  Copyright © 2019 Hongfei Yang. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    
    var cardPresentAnimator = CardPresentAnimator()
    var cardDismissAnimator = CardDismissAnimator()
    
    
    private var results = [MovieItem]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CardCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return collectionView
    }()
    
    private func setupLayout() {
        
        let constraints = [
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        setupLayout()
        
        
        let query = DiscoverMovieQuery(language: nil, region: "AU", sort_option: nil, order: nil, page: 1, include_adult: true, include_video: true)
        Network.getDiscoverMovieResults(query: query) { results in
            DispatchQueue.main.async {
                
                self.results = results
                NSLog("Movie data assigned, reloading")
            }
        }
    }

}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = UIScreen.main.bounds.width - 40
        let height = width * 6/5

        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? CardCollectionViewCell else {fatalError("no cell named CardCollectionViewCell")}
        cell.result = results[indexPath.row]
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? CardCollectionViewCell else {fatalError("failed to cast cell as CardColectionCell at didSelectItemAtIndexPath")}

        let vc = DetailMovieViewController()
        vc.result = cell.result
        
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = self
        //vc.isModalInPresentation = true
        present(vc, animated: true, completion: nil)
    }
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}

extension MainViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        guard
            let selectedIndexPathCell = collectionView.indexPathsForSelectedItems?.first,
            let selectedCell = collectionView.cellForItem(at: selectedIndexPathCell) as? CardCollectionViewCell,
            let selectedCellSuperview = selectedCell.superview
        else {
            return nil
        }
        
        cardPresentAnimator.originFrame = selectedCellSuperview.convert(selectedCell.frame, to: nil)

        return cardPresentAnimator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        guard
            let selectedIndexPathCell = collectionView.indexPathsForSelectedItems?.first,
            let selectedCell = collectionView.cellForItem(at: selectedIndexPathCell) as? CardCollectionViewCell,
            let selectedCellSuperview = selectedCell.superview
        else {
            return nil
        }
        
        cardDismissAnimator.originFrame = selectedCellSuperview.convert(selectedCell.frame, to: nil)

        return cardDismissAnimator
    }
    
}
