//
//  MovieSearchResultsTableViewCell.swift
//  MovieToWatch
//
//  Created by Clark on 26/12/19.
//  Copyright © 2019 Hongfei Yang. All rights reserved.
//

import UIKit

class MovieSearchResultsTableViewCell: UITableViewCell {

    public var content: MovieSearchResult! {
        didSet {
            updateView()
        }
    }
    
    
    private var posterImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "photo")
        //view.backgroundColor = .secondarySystemFill
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textAlignment = .left
        label.textColor = .label
        return label
    }()
    
    private var releaseDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .secondaryLabel
        label.textAlignment = .left
        return label
    }()
    
    private func setupLayout() {
        
        let padding = CGFloat(5)
        
        let constraints = [
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            posterImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            posterImageView.widthAnchor.constraint(equalTo: posterImageView.heightAnchor, multiplier: 2/3),
            
            titleLabel.bottomAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -padding/2),
            titleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: padding * 2),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -padding),
            
            releaseDateLabel.topAnchor.constraint(equalTo: contentView.centerYAnchor, constant: padding/2),
            releaseDateLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: padding * 2),
            releaseDateLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -padding),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func updateView() {
        titleLabel.text = content.title
        if let date = content.releaseDate, let year = Calendar.current.dateComponents([.year], from: date).year {
            releaseDateLabel.text = String(year)
        }
        DispatchQueue.main.async { [weak self] in
            self?.posterImageView.image = nil
        }
        if let posterPath = content.posterPath, let url = APIConfiguration.parsePosterURL(file_path: posterPath, size: .w92) {
            Cache.shared.cacheImage(url: url) { [weak self] (originalURL, image) in
                guard originalURL == url else {return}
                DispatchQueue.main.async {
                    self?.posterImageView.image = image
                }
            }
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .secondarySystemBackground
        
        contentView.addSubview(posterImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(releaseDateLabel)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
