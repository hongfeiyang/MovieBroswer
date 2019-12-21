//
//  SummaryMovieInfoView.swift
//  MovieToWatch
//
//  Created by Clark on 21/12/19.
//  Copyright © 2019 Hongfei Yang. All rights reserved.
//

import UIKit

struct ShortMovieInfo {
    let title: String
    let overview: String
    let rating: Float
    
    init(title: String, overview: String, rating: Float) {
        self.title = title
        self.overview = overview
        self.rating = rating
        
    }
}

class ShortMovieInfoView: UIView {
    
    var observation: NSKeyValueObservation?
    
    public var info: ShortMovieInfo! {
        didSet {
            DispatchQueue.main.async { [unowned self] in
                self.titleLabel.text = self.info.title
                self.overviewLabel.text = self.info.overview
                self.ratingLabel.text = String(self.info.rating)+"/10"
            }
        }
    }
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var ratingLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .secondaryLabel
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var overviewLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .label
        label.isHidden = true
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var vibrancyView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.systemUltraThinMaterial)
        let vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect, style: UIVibrancyEffectStyle.label)
        let vibrancyView = UIVisualEffectView(effect: vibrancyEffect)
        vibrancyView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return vibrancyView
    }()
    
    private var blurView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.systemUltraThinMaterial)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        return blurView
    }()
    
    private func setupLayout() {
        
        let padding = CGFloat(10)
        
        let constraints = [
            blurView.topAnchor.constraint(equalTo: topAnchor),
            blurView.leadingAnchor.constraint(equalTo: leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: trailingAnchor),
            blurView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            overviewLabel.leadingAnchor.constraint(equalTo: blurView.contentView.leadingAnchor, constant: padding),
            overviewLabel.trailingAnchor.constraint(equalTo: blurView.contentView.trailingAnchor, constant: -padding),
            overviewLabel.centerYAnchor.constraint(equalTo: blurView.contentView.centerYAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: blurView.contentView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: ratingLabel.leadingAnchor, constant: -padding),
            titleLabel.centerYAnchor.constraint(equalTo: blurView.contentView.centerYAnchor),
            
            ratingLabel.trailingAnchor.constraint(equalTo: blurView.contentView.trailingAnchor, constant: -padding),
            ratingLabel.centerYAnchor.constraint(equalTo: blurView.contentView.centerYAnchor),
            ratingLabel.widthAnchor.constraint(equalToConstant: 50),
            
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(blurView)
        blurView.contentView.addSubview(vibrancyView)
        vibrancyView.contentView.addSubview(overviewLabel)
        vibrancyView.contentView.addSubview(titleLabel)
        vibrancyView.contentView.addSubview(ratingLabel)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        overviewLabel.sizeToFit()
        titleLabel.sizeToFit()
        ratingLabel.sizeToFit()
    }
    
}


