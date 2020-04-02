//
//  PersonDetailViewController.swift
//  MovieToWatch
//
//  Created by Clark on 13/3/20.
//  Copyright © 2020 Hongfei Yang. All rights reserved.
//

import UIKit


class PersonDetailController: UIViewController {

    var personDetail: PersonDetail? {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    var cast: [PersonCastCredit]? {
        return personDetail?.movieCredits?.cast
    }

    let biographyCellId = "biographyCellId"
    let dobCellId = "dobCellId"
    let alsoKnownAsCellId = "alsoKnownAsCellId"
    let personCreditCellId = "personCreditCellId"
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = .systemBackground
        view.addRoundedCorners(radius: 20, corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        view.register(PersonBiographySectionCell.self, forCellWithReuseIdentifier: biographyCellId)
        view.register(PersonDobSectionCell.self, forCellWithReuseIdentifier: dobCellId)
        view.register(PersonAlsoKnownAsCell.self, forCellWithReuseIdentifier: alsoKnownAsCellId)
        view.register(PersonCreditCell.self, forCellWithReuseIdentifier: personCreditCellId)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        collectionView.fillSuperview()
        collectionView.addRoundedCorners(radius: 12, curve: .circular, corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        collectionView.contentInsetAdjustmentBehavior = .never
    }
    
}


extension PersonDetailController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            return 3
        } else if section == 1 {
            return cast?.count ?? 0
        } else {
            fatalError("Not implemented")
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            let cell: PersonDetailBaseSectionCell
            
            if indexPath.item == 0 {
                cell = collectionView.dequeueReusableCell(withReuseIdentifier: biographyCellId, for: indexPath) as! PersonBiographySectionCell
            } else if indexPath.item == 1 {
                cell = collectionView.dequeueReusableCell(withReuseIdentifier: dobCellId, for: indexPath) as! PersonDobSectionCell
            } else if indexPath.item == 2 {
                cell = collectionView.dequeueReusableCell(withReuseIdentifier: alsoKnownAsCellId, for: indexPath) as! PersonAlsoKnownAsCell
            } else {
                fatalError()
            }
            cell.data = personDetail
            return cell
        } else if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: personCreditCellId, for: indexPath) as! PersonCreditCell
            cell.personCredit = PersonCreditViewModel(credit: cast![indexPath.item])
            return cell
        } else {
            fatalError("Not implemented")
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 0 {
            let cell: PersonDetailBaseSectionCell
            if indexPath.item == 0 {
                cell = PersonBiographySectionCell(frame: .init(origin: .zero, size: .init(width: collectionView.frame.width, height: 1000)))
            } else if indexPath.item == 1 {
                cell = PersonDobSectionCell(frame: .init(origin: .zero, size: .init(width: collectionView.frame.width, height: 1000)))
            } else if indexPath.item == 2 {
                cell = PersonAlsoKnownAsCell(frame: .init(origin: .zero, size: .init(width: collectionView.frame.width, height: 1000)))
            } else {
                fatalError()
            }
            
            cell.data = personDetail
            cell.layoutIfNeeded()
            let size = cell.systemLayoutSizeFitting(.init(width: collectionView.frame.width, height: 1000))
            return .init(width: collectionView.frame.width, height: size.height)
        } else if indexPath.section == 1 {
            let cell = PersonCreditCell(frame: .init(origin: .zero, size: .init(width: collectionView.frame.width, height: 1000)))
            cell.personCredit = PersonCreditViewModel(credit: cast![indexPath.item])
            cell.layoutIfNeeded()
            let size = cell.systemLayoutSizeFitting(.init(width: collectionView.frame.width, height: 1000))
            return .init(width: collectionView.frame.width, height: size.height)
        } else {
            fatalError("Not implemented")
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0 {
            scrollView.isScrollEnabled = false
            scrollView.isScrollEnabled = true
        }
        
    }
}

