//
//  BasicInfoSectionCell.swift
//  MovieToWatch
//
//  Created by Clark on 24/2/20.
//  Copyright © 2020 Hongfei Yang. All rights reserved.
//

import UIKit

class BasicInfoSectionCell: MovieDetailSectionBaseCell {
    
    override var movieDetail: MovieDetail? {
        didSet {
            if let date = movieDetail?.releaseDate {
                let formatter = DateFormatter()
                formatter.dateStyle = .medium
                let string = formatter.string(from: date)
                releaseDate.text = string
            }
            
            if let status = movieDetail?.status, status == "Released" {
                runtime.text = String(movieDetail?.runtime ?? 0) + " minutes"
                self.status.text = status
            } else {
                self.status.text = movieDetail?.status
            }
            genreController.data = movieDetail?.genres
            
            isMovieInList(successHandler: {[weak self] in
                self?.addToListButton.isEnabled = false
                self?.addToListButton.backgroundColor = .systemYellow
            }, failureHandler: nil)
        }
    }
    
    lazy var addToListButton: UIButton = {
        let button = UIButton(title: "Add to my list", titleColor: .label, font: .systemFont(ofSize: 16, weight: .semibold))
        button.contentEdgeInsets = .init(top: 5, left: 5, bottom: 5, right: 5)
        button.clipsToBounds = true
        button.layer.borderColor = UIColor.systemYellow.cgColor
        button.layer.borderWidth = 1
        button.setTitle("Added", for: .disabled)
        let plus = UIImage.symbolWithTintColor(symbol: "plus", weight: .semibold, tintColor: .label)
        let checkmark = UIImage.symbolWithTintColor(symbol: "checkmark", weight: .semibold, tintColor: .label)
        button.setImage(plus, for: .normal)
        button.setImage(checkmark, for: .disabled)
        button.addTarget(self, action: #selector(addToListButtonTapped), for: .touchUpInside)
        button.constrainHeight(constant: 30)
        button.layer.cornerRadius = 15
        return button
    }()
    
    @objc func addToListButtonTapped() {
        guard let movieDetail = movieDetail else {return}
        isMovieInList(successHandler: {
            print("Attempting to add a movie that is already in your list")
        }, failureHandler: {
            CoreDataManager.shared.saveMovie(movieDetail: movieDetail)
        })
        
        addToListButton.isEnabled = false
        addToListButton.backgroundColor = .systemYellow
    }
    
    private func isMovieInList(successHandler: (()->Void)?, failureHandler: (()->Void)?) {
        guard let movieDetail = movieDetail else {return}
        CoreDataManager.shared.readMovie(id: movieDetail.id) { (result) in
            switch result {
            case .success(_):
                successHandler?()
            case .failure(_):
                failureHandler?()
            }
        }
    }
    
    var releaseDate = UILabel(text: "", font: .systemFont(ofSize: 13, weight: .light), numberOfLines: 1, textColor: .label, textAlignment: .left)
    var runtime = UILabel(text: "", font: .systemFont(ofSize: 13, weight: .light), numberOfLines: 1, textColor: .label, textAlignment: .left)
    var status = UILabel(text: "", font: .systemFont(ofSize: 13, weight: .light), numberOfLines: 1, textColor: .label, textAlignment: .left)
    
    var genreController = GenreController()
  
    lazy var stackView = UIStackView(arrangedSubviews: [
        self.addToListButton,
        UIStackView(arrangedSubviews: [
            self.releaseDate, self.status, self.runtime
        ], axis: .horizontal, spacing: 10)
    ], axis: .vertical, spacing: 10, distribution: .fill, alignment: .leading)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(stackView)
        addSubview(genreController.view)
        stackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 10, left: 10, bottom: 10, right: 10))
        stackView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor).isActive = true
        genreController.view.anchor(top: stackView.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 10, left: 10, bottom: 10, right: 10))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
