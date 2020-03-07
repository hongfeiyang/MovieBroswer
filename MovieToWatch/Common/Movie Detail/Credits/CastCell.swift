//
//  CreditsCell.swift
//  MovieToWatch
//
//  Created by Clark on 20/2/20.
//  Copyright © 2020 Hongfei Yang. All rights reserved.
//

import UIKit

class CastCell: UICollectionViewCell {
    
    var viewModel: Cast! {
        didSet {
            nameLabel.text = viewModel.name
            characterLabel.text = viewModel.character
            profileImageURL = APIConfiguration.parsePosterURL(file_path: viewModel.profilePath, size: .w154)
        }
    }

    var nameLabel = UILabel(text: "", font: .systemFont(ofSize: 12, weight: .regular), numberOfLines: 0, textColor: .label)
    
    var characterLabel = UILabel(text: "", font: .systemFont(ofSize: 12, weight: .light), numberOfLines: 0, textColor: .secondaryLabel)

    var profileImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.heightAnchor.constraint(equalToConstant: 120).isActive = true
        view.layer.cornerRadius = 10
        return view
    }()
    
    var profileImageURL: URL? {
        didSet {
            profileImageView.sd_setImage(with: profileImageURL, placeholderImage: UIImage(systemName: "person.fill", withConfiguration: UIImage.SymbolConfiguration(weight: .ultraLight))?.withTintColor(.systemGray, renderingMode: .alwaysOriginal))
        }
    }
    
    lazy var stackView: UIStackView = {
        let view = VerticalStackView(arrangedSubviews: [
            self.profileImageView,
            self.nameLabel,
            self.characterLabel
        ], spacing: 1)
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(stackView)
        stackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


