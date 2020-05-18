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
    let results: [MovieListResult]
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
