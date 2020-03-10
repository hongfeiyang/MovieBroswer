//
//  MovieSearchResultCell.swift
//  MovieToWatch
//
//  Created by Clark on 10/3/20.
//  Copyright © 2020 Hongfei Yang. All rights reserved.
//

import UIKit

class MovieSearchResultCell: BaseSearchResultCell {
    
    override var result: ISearchResult? {
        didSet {
            if let result = result as? MovieMultiSearchResult {
                updateView(result: result)
            }
        }
    }

    private func updateView(result: MovieMultiSearchResult) {
        
        leftImageView.sd_setImage(with: APIConfiguration.parsePosterURL(file_path: result.posterPath, size: .w92), completed: {[weak self] (image, _, _, _) in
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
        
        
        if let originalTitle = result.originalTitle, let title = result.title, title != originalTitle {
            titleLabel.text = "\(title) (\(originalTitle))"
        } else {
            titleLabel.text = result.title
        }
        
        if let dateString = result.releaseDate, let date = DateParser.shared.parseDate(dateString: dateString), let year = Calendar.current.dateComponents([.year], from: date).year {
            titleLabel.text = titleLabel.text! + " (\(String(year)))" 
        }
        
        subtitleLabel.text = "Movie"
        
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
