//
//  SaveMovieCell.swift
//  MovieToWatch
//
//  Created by Clark on 14/5/20.
//  Copyright © 2020 Hongfei Yang. All rights reserved.
//

import UIKit

class SavedMovieCell: UITableViewCell {
    
    var movie: MovieMO? {
        didSet {
            posterImageView.sd_setImage(with: APIConfiguration.parsePosterURL(file_path: movie?.posterPath, size: .w92), completed: nil)
            titleLabel.text = movie?.title
            if let date = movie?.releaseDate, date != Date.distantPast {
                let formatter = DateFormatter()
                formatter.dateStyle = .medium
                formatter.timeStyle = .none
                relaseDateLabel.text = formatter.string(from: date)
            }
        }
    }
    
    var posterImageView: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.contentMode = .scaleAspectFill
        view.constrainWidth(constant: 60)
        view.constrainHeight(constant: 90)
        return view
    }()
    
    var titleLabel = UILabel(text: "", font: .systemFont(ofSize: 15, weight: .semibold), numberOfLines: 2, textColor: .label, textAlignment: .left)
    var relaseDateLabel = UILabel(text: "", font: .systemFont(ofSize: 14, weight: .regular), numberOfLines: 1, textColor: .secondaryLabel, textAlignment: .left)
    
    lazy var stackView = UIStackView(arrangedSubviews: [
        self.posterImageView,
        UIStackView(arrangedSubviews: [
            self.titleLabel,
            self.relaseDateLabel
        ], axis: .vertical, spacing: 10, distribution: .fill, alignment: .leading)
    ], axis: .horizontal, spacing: 10, distribution: .fill, alignment: .center)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 10, left: 20, bottom: 10, right: 20))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
