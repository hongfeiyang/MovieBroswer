//
//  SimilarMoviesResponse.swift
//  MovieToWatch
//
//  Created by Clark on 18/5/20.
//  Copyright © 2020 Hongfei Yang. All rights reserved.
//

import Foundation

// MARK: - MovieListResult
struct SimilarMoviesResponse: Codable {
    let page: Int
    let results: [MovieListResult]
    let totalPages, totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
