//
//  Title.swift
//  MovieToWatch
//
//  Created by Clark on 21/2/20.
//  Copyright © 2020 Hongfei Yang. All rights reserved.
//

import UIKit

class MovieHeader: UICollectionReusableView {
    
    var movieDetail: MovieDetail? {
        didSet {
            titleLabel.text = movieDetail?.title
            tagLineLabel.text = movieDetail?.tagline
        }
    }

    var titleLabel = UILabel(text: "", font: .systemFont(ofSize: 22, weight: .semibold), numberOfLines: 2, textColor: .label, textAlignment: .center)
    var tagLineLabel = UILabel(text: "", font: .italicSystemFont(ofSize: 18), numberOfLines: 2, textColor: .label, textAlignment: .center)
    var containerView: UIView = {
        let view = UIView()
        view.addRoundedCorners(radius: 20, curve: .circular, corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        view.addShadow(offset: .init(width: 0, height: -3), color: .black, radius: 0, opacity: 0.3)
        view.backgroundColor = .systemBackground
        return view
    }()
    
    
    lazy var stackView = UIStackView(arrangedSubviews: [
        self.titleLabel,
        self.tagLineLabel
    ], axis: .vertical, spacing: 1, distribution: .fill, alignment: .fill)

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(containerView)
        containerView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, size: .init(width: 0, height: 100))

        containerView.addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 10, left: 20, bottom: 10, right: 20))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
