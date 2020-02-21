//
//  ImagesCell.swift
//  MovieToWatch
//
//  Created by Clark on 21/2/20.
//  Copyright © 2020 Hongfei Yang. All rights reserved.
//

import UIKit


class ImagesCell: UICollectionViewCell {
    
    var image: ImageDetail? {
        didSet {
            profileImageView.image = nil
            profileImageURL = APIConfiguration.parsePosterURL(file_path: image?.filePath, size: .w500)
        }
    }

    var profileImageURL: URL? {
        didSet {
            profileImageView.sd_setImage(with: profileImageURL, completed: nil)
        }
    }
    
    var profileImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .tertiarySystemBackground
        addSubview(profileImageView)
        profileImageView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
