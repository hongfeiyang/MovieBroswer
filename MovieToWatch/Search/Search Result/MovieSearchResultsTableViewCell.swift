//
//  MovieSearchResultsTableViewCell.swift
//  MovieToWatch
//
//  Created by Clark on 26/12/19.
//  Copyright © 2019 Hongfei Yang. All rights reserved.
//

import UIKit

class MovieSearchResultsTableViewCell: UITableViewCell {

    public var content: MovieSearchResult? {
        didSet {
            updateView()
        }
    }
        
    var posterImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.widthAnchor.constraint(equalToConstant: 60).isActive = true
        return view
    }()
    
    var titleLabel = UILabel(text: "", font: .systemFont(ofSize: 17, weight: .semibold), numberOfLines: 3, textColor: .label, textAlignment: .left)
    
    var releaseDateLabel = UILabel(text: "", font: .systemFont(ofSize: 15, weight: .regular), numberOfLines: 1, textColor: .label, textAlignment: .left)
    
    lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            self.posterImageView,
            UIStackView(arrangedSubviews: [
                UIView(vContentHugging: .defaultLow, vCompressionResistancePriority: .defaultLow),
                self.titleLabel,
                self.releaseDateLabel,
                UIView(vContentHugging: .defaultLow, vCompressionResistancePriority: .defaultLow),
            ], axis: .vertical, spacing: 2, distribution: .equalSpacing, alignment: .fill),
        ], axis: .horizontal, spacing: 10, distribution: .fill, alignment: .fill)
        
        return view
    }()

    private func updateView() {
        
        posterImageView.sd_setImage(with: APIConfiguration.parsePosterURL(file_path: content?.posterPath, size: .w92))

        DispatchQueue.main.async { [weak self] in
            
            if let originalTitle = self?.content?.originalTitle, let title = self?.content?.title {
                self?.titleLabel.text = "\(title) (\(originalTitle))"
            } else {
                self?.titleLabel.text = self?.content?.title
            }
            
            if let date = self?.content?.releaseDate, date != Date.distantPast, let year = Calendar.current.dateComponents([.year], from: date).year {
                // Note: custom date decoder will yield 'distantPast' for default optional value when date is nil
                self?.releaseDateLabel.text = String(year)
            } else {
                self?.releaseDateLabel.text = "Unknown"
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .secondarySystemBackground
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

class loadingTableViewCell: UITableViewCell {
    
    var activityIndicator = UIActivityIndicatorView(style: .large)
    
    var lastPageLabel = UILabel(text: "你到底了", font: .systemFont(ofSize: 20, weight: .regular), numberOfLines: 1, textColor: .label, textAlignment: .center)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(lastPageLabel)
        addSubview(activityIndicator)
        activityIndicator.color = .label
        activityIndicator.hidesWhenStopped = true
        activityIndicator.fillSuperview()
        lastPageLabel.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
