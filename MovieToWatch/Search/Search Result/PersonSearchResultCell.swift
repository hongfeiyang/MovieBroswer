//
//  PersonSearchResultCell.swift
//  MovieToWatch
//
//  Created by Clark on 10/3/20.
//  Copyright © 2020 Hongfei Yang. All rights reserved.
//

import UIKit

class PersonSearchResultCell: BaseSearchResultCell {
    
    override var result: ISearchResult? {
        didSet {
            if let personResult = result as? PersonMultiSearchResult {
                leftImageView.sd_setImage(with: APIConfiguration.parsePosterURL(file_path: personResult.profilePath, size: .w92), completed: {[weak self] (image, _, _, _) in
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
                titleLabel.text = personResult.name
                subtitleLabel.text = personResult.knownForDepartment
            }
        }
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        leftImageView.constrainWidth(constant: 80)
        leftImageView.constrainHeight(constant: 80)
        leftImageView.layer.cornerRadius = 40
        leftImageView.contentMode = .scaleAspectFill
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
