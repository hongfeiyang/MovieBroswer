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

    var titleLabel = UILabel(text: "", font: .systemFont(ofSize: 22, weight: .regular), textColor: .label)
    var ratingLabel = UILabel(text: "", font: .systemFont(ofSize: 20, weight: .heavy), textColor: .secondaryLabel)
    var tagLineLabel = UILabel(text: "", font: .systemFont(ofSize: 12, weight: .light), numberOfLines: 0, textColor: .secondaryLabel)

    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            VerticalStackView(arrangedSubviews: [self.titleLabel, self.tagLineLabel], spacing: 5),
            self.ratingLabel
        ])
        return stackView
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
        return blurView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(blurView)
        blurView.contentView.addSubview(vibrancyView)
        vibrancyView.contentView.addSubview(stackView)
        stackView.anchor(top: vibrancyView.topAnchor, leading: vibrancyView.leadingAnchor, bottom: vibrancyView.bottomAnchor, trailing: vibrancyView.trailingAnchor, padding: .init(top: 15, left: 15, bottom: 15, right: 15))
        blurView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


