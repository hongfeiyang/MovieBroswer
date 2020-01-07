//
//  NowPlayingQuery.swift
//  MovieToWatch
//
//  Created by Clark on 8/1/20.
//  Copyright © 2020 Hongfei Yang. All rights reserved.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let nowPlaying = try? newJSONDecoder().decode(NowPlaying.self, from: jsonData)

//
// To read values from URLs:
//
//   let task = URLSession.shared.nowPlayingTask(with: url) { nowPlaying, response, error in
//     if let nowPlaying = nowPlaying {
//       ...
//     }
//   }
//   task.resume()


// MARK: - NowPlaying
struct NowPlaying: Codable {
    let results: [NowPlayingResult]
    let page, totalResults: Int
    let dates: Dates
    let totalPages: Int

    enum CodingKeys: String, CodingKey {
        case results, page
        case totalResults = "total_results"
        case dates
        case totalPages = "total_pages"
    }
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.datesTask(with: url) { dates, response, error in
//     if let dates = dates {
//       ...
//     }
//   }
//   task.resume()

// MARK: - Dates
struct Dates: Codable {
    let maximum, minimum: Date?
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.resultTask(with: url) { result, response, error in
//     if let result = result {
//       ...
//     }
//   }
//   task.resume()

// MARK: - Result
struct NowPlayingResult: Codable {
    let popularity: Double?
    let voteCount: Int?
    let video: Bool?
    let posterPath: String?
    let id: Int?
    let adult: Bool?
    let backdropPath: String?
    let originalLanguage: String?
    let originalTitle: String?
    let genreIDS: [Int]
    let title: String?
    let voteAverage: Double?
    let overview, releaseDate: String?

    enum CodingKeys: String, CodingKey {
        case popularity
        case voteCount = "vote_count"
        case video
        case posterPath = "poster_path"
        case id, adult
        case backdropPath = "backdrop_path"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case genreIDS = "genre_ids"
        case title
        case voteAverage = "vote_average"
        case overview
        case releaseDate = "release_date"
    }
}

// MARK: - URLSession response handlers

extension URLSession {
    fileprivate func codableTask<T: Codable>(with url: URL, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, error)
                return
            }
            do {
                let data = try newJSONDecoder().decode(T.self, from: data)
                completionHandler(data, response, nil)
            } catch let error {
                print(error.localizedDescription)
                completionHandler(nil, response, nil)
            }
            
        }
    }

    func nowPlayingTask(with url: URL, completionHandler: @escaping (NowPlaying?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
}
