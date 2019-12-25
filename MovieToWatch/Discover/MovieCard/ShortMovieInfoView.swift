//
//  SummaryMovieInfoView.swift
//  MovieToWatch
//
//  Created by Clark on 21/12/19.
//  Copyright © 2019 Hongfei Yang. All rights reserved.
//

import UIKit

struct ShortMovieInfo {
    let title: String?
    let tagLine: String?
    let rating: Double?
    
    init(title: String?, tagLine: String?, rating: Double?) {
        self.title = title
        self.tagLine = tagLine
        self.rating = rating
        
    }
}

class ShortMovieInfoView: UIView {
    
    var observation: NSKeyValueObservation?
    
    public var info: ShortMovieInfo! {
        didSet {
            DispatchQueue.main.async { [unowned self] in
                self.titleLabel.text = self.info.title
                self.tagLineLabel.text = self.info.tagLine
                self.ratingLabel.text = String(self.info.rating ?? 0)+"/10"
            }
        }
    }
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 22, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var ratingLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .secondaryLabel
        label.font = UIFont.systemFont(ofSize: 15, weight: .heavy)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var tagLineLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
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
        
        let padding = CGFloat(15)
        
        let constraints = [
            blurView.topAnchor.constraint(equalTo: topAnchor),
            blurView.leadingAnchor.constraint(equalTo: leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: trailingAnchor),
            blurView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            tagLineLabel.leadingAnchor.constraint(equalTo: blurView.contentView.leadingAnchor, constant: padding),
            //tagLineLabel.trailingAnchor.constraint(equalTo: blurView.contentView.trailingAnchor, constant: -padding),
            tagLineLabel.topAnchor.constraint(equalTo: blurView.contentView.centerYAnchor),
            tagLineLabel.bottomAnchor.constraint(equalTo: blurView.contentView.bottomAnchor, constant: -padding),
            tagLineLabel.trailingAnchor.constraint(lessThanOrEqualTo: ratingLabel.leadingAnchor, constant: -padding),
            
            titleLabel.leadingAnchor.constraint(equalTo: blurView.contentView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: ratingLabel.leadingAnchor, constant: -padding),
            titleLabel.bottomAnchor.constraint(equalTo: blurView.contentView.centerYAnchor),
            
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
        vibrancyView.contentView.addSubview(tagLineLabel)
        vibrancyView.contentView.addSubview(titleLabel)
        vibrancyView.contentView.addSubview(ratingLabel)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tagLineLabel.sizeToFit()
        titleLabel.sizeToFit()
        ratingLabel.sizeToFit()
    }
    
}


