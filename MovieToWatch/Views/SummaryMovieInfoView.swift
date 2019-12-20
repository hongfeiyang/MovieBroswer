//
//  SummaryMovieInfoView.swift
//  MovieToWatch
//
//  Created by Clark on 21/12/19.
//  Copyright © 2019 Hongfei Yang. All rights reserved.
//

import UIKit

struct SummaryMovieInfo {
    var title: String = ""
    var summary: String = ""
}

class SummaryMovieInfoView: UIView {
    
    public var info: SummaryMovieInfo! {
        didSet {
            titleLabel.text = info.title
            summaryLabel.text = info.summary
        }
    }

    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var summaryLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.isHidden = true
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy private var blurView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.regular)
        //let vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect, style: UIVibrancyEffectStyle.secondaryLabel)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private func setupLayout() {
        
        let padding = CGFloat(10)
        
        let constraints = [
            blurView.topAnchor.constraint(equalTo: topAnchor),
            blurView.leadingAnchor.constraint(equalTo: leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: trailingAnchor),
            blurView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            summaryLabel.leadingAnchor.constraint(equalTo: blurView.contentView.leadingAnchor, constant: padding),
            summaryLabel.trailingAnchor.constraint(equalTo: blurView.contentView.trailingAnchor, constant: -padding),
            summaryLabel.centerYAnchor.constraint(equalTo: blurView.contentView.centerYAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: blurView.contentView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: blurView.contentView.trailingAnchor, constant: -padding),
            titleLabel.centerYAnchor.constraint(equalTo: blurView.contentView.centerYAnchor),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(blurView)
        blurView.contentView.addSubview(summaryLabel)
        blurView.contentView.addSubview(titleLabel)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        summaryLabel.sizeToFit()
        titleLabel.sizeToFit()
    }
    
}
