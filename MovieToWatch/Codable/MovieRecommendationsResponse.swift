//
//  MovieRecommendationsResponse.swift
//  MovieToWatch
//
//  Created by Clark on 18/5/20.
//  Copyright © 2020 Hongfei Yang. All rights reserved.
//

import Foundation

//
// To read values from URLs:
//
//   let task = URLSession.shared.recommendationsTask(with: url) { recommendations, response, error in
//     if let recommendations = recommendations {
//       ...
//     }
//   }
//   task.resume()

// MARK: - Recommendations
struct MovieRecommendationsResponse: Codable {
    let page: Int
    let results: [MovieListResult]
    let totalPages, totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

