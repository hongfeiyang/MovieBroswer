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
        
    var posterImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 6
        return view
    }()
    
    var titleLabel = UILabel(text: "", font: .systemFont(ofSize: 17, weight: .semibold), numberOfLines: 3, textColor: .label, textAlignment: .left)
    
    var releaseDateLabel = UILabel(text: "", font: .systemFont(ofSize: 15, weight: .regular), numberOfLines: 1, textColor: .label, textAlignment: .left)
    
    lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            self.posterImageView,
            UIStackView(arrangedSubviews: [
                self.titleLabel,
                self.releaseDateLabel,
            ], axis: .vertical, spacing: 2, distribution: .fillEqually, alignment: .fill),
        ], axis: .horizontal, spacing: 10, distribution: .fill, alignment: .fill)
        
        return view
    }()

    private func updateView(result: MovieMultiSearchResult) {
        
        posterImageView.sd_setImage(with: APIConfiguration.parsePosterURL(file_path: result.posterPath, size: .w92))

        if let originalTitle = result.originalTitle, let title = result.title, title != originalTitle {
            titleLabel.text = "\(title) (\(originalTitle))"
        } else {
            titleLabel.text = result.title
        }
        
        if let dateString = result.releaseDate, let date = DateParser.shared.parseDate(dateString: dateString), let year = Calendar.current.dateComponents([.year], from: date).year {
            releaseDateLabel.text = String(year)
        } else {
            releaseDateLabel.text = "Unknown"
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        posterImageView.constrainWidth(constant: 80)
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        posterImageView.heightAnchor.constraint(equalTo: posterImageView.widthAnchor, multiplier: 3/2).isActive = true
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 5, left: 5, bottom: 5, right: 5))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
