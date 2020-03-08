//
//  IndividualMovieCell.swift
//  MovieToWatch
//
//  Created by Clark on 8/3/20.
//  Copyright © 2020 Hongfei Yang. All rights reserved.
//

import UIKit

class IndividualMovieCell: UICollectionViewCell {
    
    var movieItem: BaseMovieResult? {
        didSet {
            let posterImageURL = APIConfiguration.parsePosterURL(file_path: movieItem?.posterPath, size: .w342)
            posterImageView.sd_setImage(with: posterImageURL, placeholderImage: UIImage(), completed: nil)
            titleLabel.text = movieItem?.title
            if let voteAverage = movieItem?.voteAverage {
                let voteString = String(voteAverage)
                let string = NSMutableAttributedString(string: "\(voteString)/10", attributes: [
                    NSAttributedString.Key.foregroundColor : UIColor.secondaryLabel,
                    .font: UIFont.systemFont(ofSize: 11, weight: .regular)
                ])
                string.addAttributes([
                    .font: UIFont.systemFont(ofSize: 14, weight: .semibold),
                    .foregroundColor: UIColor.label,
                ], range: .init(location: 0, length: voteString.count))
                ratingNumberLabel.attributedText = string
            }
            
        }
    }
            
    var posterImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    var starView: UIImageView = {
        let image = UIImage.symbolWithTintColor(symbol: "star.fill", weight: .light, tintColor: .systemYellow)
        let view = UIImageView(image: image)
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        return view
    }()
    
    var ratingNumberLabel = UILabel(text: "", font: .systemFont(ofSize: 14, weight: .regular), numberOfLines: 1, textColor: .secondaryLabel, textAlignment: .right)
    
    var titleLabel = UILabel(text: "", font: .systemFont(ofSize: 14, weight: .semibold), numberOfLines: 2, textColor: .label, textAlignment: .left)
    
    lazy var ratingStarView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            self.starView, self.ratingNumberLabel, UIView()
        ], axis: .horizontal, spacing: 5, distribution: .fill, alignment: .fill)
        return view
    }()
    
    lazy var topStackView = UIStackView(arrangedSubviews: [
        self.posterImageView,
        self.titleLabel
    ], axis: .vertical, spacing: 5, distribution: .fill, alignment: .fill)

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(topStackView)
        addSubview(ratingStarView)
        posterImageView.heightAnchor.constraint(equalTo: posterImageView.widthAnchor, multiplier: 3/2).isActive = true
        topStackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor)
        ratingStarView.anchor(top: topStackView.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 2, left: 0, bottom: 0, right: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//
//
//import SwiftUI
//
//struct MainPreview: PreviewProvider {
//    static var previews: some View {
//        ContainterView().edgesIgnoringSafeArea(.all)
//    }
//
//    struct ContainterView: UIViewControllerRepresentable {
//
//        typealias UIViewControllerType = UIViewController
//
//        func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<MainPreview.ContainterView>) {
//        }
//
//        func makeUIViewController(context: UIViewControllerRepresentableContext<MainPreview.ContainterView>) -> MainPreview.ContainterView.UIViewControllerType {
//            return MainMovieViewController()
//        }
//    }
//}
