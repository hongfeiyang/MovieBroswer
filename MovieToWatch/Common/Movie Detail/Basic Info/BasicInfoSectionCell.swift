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
            if let id = movieDetail?.id {
                let group = DispatchGroup()
                var imdbRating: String?
                var metaRating: String?
                
                let query = ExternalIdQuery(movie_id: id)
                group.enter()
                Network.getExternalId(query: query) {(result) in
                    switch result {
                    case.success(let response):
                        if let imdbId = response.imdbID {
                            let omdbQuery = OMDB_Query(i: imdbId)
                            group.enter()
                            Network.getOMDBDetail(query: omdbQuery) {(omdbResult) in
                                switch omdbResult {
                                case .success(let omdbResponse):
                                    imdbRating = omdbResponse.imdbRating
                                    metaRating = omdbResponse.metascore
                                case .failure(_):
                                    imdbRating = "-"
                                    metaRating = "-"
                                }
                                group.leave()
                            }
                        }
                    case .failure(_):
                        imdbRating = "--"
                        metaRating = "--"
                    }
                    group.leave()
                }
                group.notify(queue: .main) {
                    self.imdbRating.text = imdbRating
                    self.metacriticRating.text = metaRating
                }
            }
            
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
    
    var imdbLogoView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "IMDB_Logo"))
        view.contentMode = .scaleAspectFit
        view.constrainWidth(constant: 1200/605*25)
        view.constrainHeight(constant: 25)
        return view
    }()
    var imdbRating = UILabel(text: "", font: .systemFont(ofSize: 16, weight: .regular), numberOfLines: 1, textColor: .label, textAlignment: .left)
    
    var metacriticView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "MetacriticLogo"))
        view.contentMode = .scaleAspectFit
        view.constrainWidth(constant: 1280/300*25)
        view.constrainHeight(constant: 25)
        return view
    }()
    var metacriticRating = UILabel(text: "", font: .systemFont(ofSize: 16, weight: .regular), numberOfLines: 1, textColor: .label, textAlignment: .left)
    
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
        UIStackView(arrangedSubviews: [
            UIStackView(arrangedSubviews: [
                self.imdbLogoView,
                self.imdbRating
            ], axis: .horizontal, spacing: 5, distribution: .fill, alignment: .center),
            UIStackView(arrangedSubviews: [
                self.metacriticView,
                self.metacriticRating
            ], axis: .horizontal, spacing: 5, distribution: .fill, alignment: .center),
        ], axis: .horizontal, spacing: 20, distribution: .fill, alignment: .center),
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
