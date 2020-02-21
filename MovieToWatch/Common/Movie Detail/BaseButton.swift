//
//  BaseButton.swift
//  MovieToWatch
//
//  Created by Clark on 30/12/19.
//  Copyright © 2019 Hongfei Yang. All rights reserved.
//

import UIKit

class BaseButton: UIButton {

    
    var topicLabel = UILabel(text: "", font: .systemFont(ofSize: 18, weight: .regular), numberOfLines: 0, textColor: .label, textAlignment: .left)
    
    var contentLabel = UILabel(text: "", font: .systemFont(ofSize: 18, weight: .regular), numberOfLines: 0, textColor: .secondaryLabel, textAlignment: .right)
    
    lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            self.topicLabel,
            self.contentLabel
        ])
        return view
    }()
    
    convenience init(topic: String, content: String) {
        self.init(frame: .zero)
        topicLabel.text = topic
        contentLabel.text = content
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(stackView)
        stackView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
