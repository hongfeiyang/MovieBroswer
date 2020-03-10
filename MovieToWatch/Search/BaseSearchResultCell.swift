//
//  BaseSearchResultCell.swift
//  MovieToWatch
//
//  Created by Clark on 10/3/20.
//  Copyright © 2020 Hongfei Yang. All rights reserved.
//

import UIKit

class BaseSearchResultCell: UITableViewCell {
    
    var result: ISearchResult?
        
    var containerView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        view.backgroundColor = .secondarySystemBackground
        return view
    }()
    
    var leftImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.backgroundColor = .secondarySystemFill
        return view
    }()
    
    var titleLabel = UILabel(text: "", font: .systemFont(ofSize: 17, weight: .semibold), numberOfLines: 3, textColor: .label, textAlignment: .left)
    
    var subtitleLabel = UILabel(text: "", font: .systemFont(ofSize: 15, weight: .regular), numberOfLines: 1, textColor: .label, textAlignment: .left)
    
    lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            self.leftImageView,
            UIStackView(arrangedSubviews: [
                self.titleLabel,
                self.subtitleLabel,
            ], axis: .vertical, spacing: 10, distribution: .fill, alignment: .fill),
        ], axis: .horizontal, spacing: 10, distribution: .fill, alignment: .center)
        
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        backgroundColor = .systemBackground
        addSubview(containerView)
        containerView.fillSuperview(padding: .init(top: 5, left: 20, bottom: 5, right: 20))
        containerView.addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 15, left: 15, bottom: 15, right: 15))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
