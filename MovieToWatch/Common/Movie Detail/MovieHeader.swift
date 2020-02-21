//
//  Title.swift
//  MovieToWatch
//
//  Created by Clark on 21/2/20.
//  Copyright © 2020 Hongfei Yang. All rights reserved.
//

import UIKit

class MovieHeader: UICollectionReusableView {
    
    var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    var posterImagePath: URL? {
        didSet {
            imageView.sd_setImage(with: posterImagePath, completed: nil)
        }
    }
    
    
    var imageViewBottomConstraint: NSLayoutConstraint?
    var imageViewWidthConstraint: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 3/2).isActive = true
        imageViewWidthConstraint = imageView.widthAnchor.constraint(equalTo: widthAnchor)
        imageViewBottomConstraint = imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        [imageViewWidthConstraint, imageViewBottomConstraint].forEach { $0?.isActive = true }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
