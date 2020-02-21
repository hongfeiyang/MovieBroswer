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
            profileImageView.image = nil
            profileImageURL = APIConfiguration.parsePosterURL(file_path: viewModel.profilePath, size: .w154)
        }
    }

    var nameLabel = UILabel(text: "", font: .systemFont(ofSize: 10, weight: .light), numberOfLines: 0, textColor: .label)
    
    var characterLabel = UILabel(text: "", font: .systemFont(ofSize: 10, weight: .ultraLight), numberOfLines: 0, textColor: .label)

    var profileImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.heightAnchor.constraint(equalToConstant: 120).isActive = true
        return view
    }()
    
    var profileImageURL: URL? {
        didSet {
            profileImageView.sd_setImage(with: profileImageURL, completed: nil)
        }
    }
    
    lazy var stackView: UIStackView = {
        let view = VerticalStackView(arrangedSubviews: [
            self.profileImageView,
            self.nameLabel,
            self.characterLabel
        ], spacing: 5)
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .tertiarySystemBackground
        addSubview(stackView)
        stackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


