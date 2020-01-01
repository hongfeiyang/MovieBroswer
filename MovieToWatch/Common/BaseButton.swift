//
//  BaseButton.swift
//  MovieToWatch
//
//  Created by Clark on 30/12/19.
//  Copyright © 2019 Hongfei Yang. All rights reserved.
//

import UIKit

class BaseButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var topicLabel = UILabel()
    
    var contentLabel = UILabel()
    
    public func updateContent(content: String?) {
        contentLabel.text = content
        setNeedsLayout()
    }
    
    private func setupLabel(label: UILabel, textColor: UIColor, alignment: NSTextAlignment) {
        label.text = ""
        label.textAlignment = alignment
        label.textColor = textColor
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
    }
    
    private func setupLayout() {
        let padding = CGFloat(10)
        let constraints = [
            topicLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            topicLabel.centerYAnchor.constraint(equalTo: centerYAnchor),

            contentLabel.leadingAnchor.constraint(greaterThanOrEqualTo: topicLabel.trailingAnchor),
            contentLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            contentLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    
    convenience init(topic: String, content: String) {
        self.init(frame: .zero)
        topicLabel.text = topic
        contentLabel.text = content
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabel(label: topicLabel, textColor: .label, alignment: .left)
        setupLabel(label: contentLabel, textColor: .secondaryLabel, alignment: .right)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        topicLabel.sizeToFit()
        contentLabel.sizeToFit()
    }
    
}
