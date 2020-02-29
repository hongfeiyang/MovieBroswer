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

    var titleLabel = UILabel(text: "", font: .systemFont(ofSize: 23, weight: .semibold), numberOfLines: 1, textColor: .label)
    var ratingLabel = UILabel(text: "", font: .systemFont(ofSize: 20, weight: .bold), textColor: .secondaryLabel, textAlignment: .right)
    var tagLineLabel = UILabel(text: "", font: .systemFont(ofSize: 18, weight: .light), numberOfLines: 2, textColor: .secondaryLabel)

    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            VerticalStackView(arrangedSubviews: [self.titleLabel, self.tagLineLabel], spacing: 1),
            self.ratingLabel
        ])
        stackView.spacing = 1
        return stackView
    }()
    
    private var vibrancyView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.systemUltraThinMaterial)
        let vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect, style: UIVibrancyEffectStyle.label)
        let vibrancyView = UIVisualEffectView(effect: vibrancyEffect)
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
        vibrancyView.fillSuperview()
        vibrancyView.contentView.addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 10, left: 10, bottom: 10, right: 10))
        blurView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


