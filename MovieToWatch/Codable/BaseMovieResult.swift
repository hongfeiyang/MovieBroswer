//
//  BaseMovieResult.swift
//  MovieToWatch
//
//  Created by Clark on 7/3/20.
//  Copyright © 2020 Hongfei Yang. All rights reserved.
//

import Foundation

protocol BaseMovieResult {
    var popularity: Double? { get set }
    var voteCount: Int? { get set }
    var video: Bool? { get set }
    var posterPath: String? { get set }
    var id: Int? { get set }
    var adult: Bool? { get set }
    var backdropPath: String? { get set }
    var originalLanguage: String? { get set }
    var originalTitle: String? { get set }
    var genreIDS: [Int] { get set }
    var title: String? { get set }
    var voteAverage: Double? { get set }
    var overview: String? { get set }
    var releaseDate: String? { get set }
}
