//
//  TvSearchResultCell.swift
//  MovieToWatch
//
//  Created by Clark on 10/3/20.
//  Copyright © 2020 Hongfei Yang. All rights reserved.
//

import UIKit

class TvSearchResultCell: BaseSearchResultCell {
    
    override var result: ISearchResult? {
        didSet {
            if let tvResult = result as? TvMultiSearchResult {
                leftImageView.sd_setImage(with: APIConfiguration.parsePosterURL(file_path: tvResult.posterPath, size: .w92), completed: {[weak self] (image, _, _, _) in
                    if let avgColor = image?.averageColor {
                        self?.containerView.backgroundColor = avgColor
                        self?.titleLabel.textColor = avgColor.complementaryColor
                        self?.subtitleLabel.textColor = avgColor.complementaryColor
                    } else {
                        self?.containerView.backgroundColor = .secondarySystemBackground
                        self?.titleLabel.textColor = .label
                        self?.subtitleLabel.textColor = .secondaryLabel
                    }
                })
                titleLabel.text = tvResult.name
                subtitleLabel.text = "Television Series"
            }
        }
    }
    
   
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        leftImageView.constrainWidth(constant: 60)
        leftImageView.constrainHeight(constant: 90)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
