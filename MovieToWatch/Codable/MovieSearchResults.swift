// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let movieSearchResults = try? newJSONDecoder().decode(MovieSearchResults.self, from: jsonData)

//
// To read values from URLs:
//
//   let task = URLSession.shared.movieSearchResultsTask(with: url) { movieSearchResults, response, error in
//     if let movieSearchResults = movieSearchResults {
//       ...
//     }
//   }
//   task.resume()

import Foundation

// MARK: - MovieSearchResults
struct MovieSearchResults: Codable {
    let page, totalResults, totalPages: Int
    let results: [MovieSearchResult]

    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
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
struct MovieSearchResult: Codable {
    let popularity: Double?
    let id: Int?
    let video: Bool?
    let voteCount: Int?
    let voteAverage: Double?
    let title: String?
    let releaseDate: Date?
    let originalLanguage, originalTitle: String?
    let genreIDS: [Int]
    let backdropPath: String?
    let adult: Bool?
    let overview, posterPath: String?

    enum CodingKeys: String, CodingKey {
        case popularity, id, video
        case voteCount = "vote_count"
        case voteAverage = "vote_average"
        case title
        case releaseDate = "release_date"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case genreIDS = "genre_ids"
        case backdropPath = "backdrop_path"
        case adult, overview
        case posterPath = "poster_path"
    }
}


//// MARK: - Helper functions for creating encoders and decoders
//
//func newJSONDecoder() -> JSONDecoder {
//    let decoder = JSONDecoder()
//    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
//        decoder.dateDecodingStrategy = .iso8601
//    }
//    return decoder
//}
//
//func newJSONEncoder() -> JSONEncoder {
//    let encoder = JSONEncoder()
//    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
//        encoder.dateEncodingStrategy = .iso8601
//    }
//    return encoder
//}

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
                print("unparsed data")
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [.allowFragments])
                    print(json)
                } catch {
                    print(String(data: data, encoding: .utf8) ?? "it's not even a utf8 string!")
                }
                
                completionHandler(nil, response, nil)
            }
            
        }
    }

    func movieSearchResultsTask(with url: URL, completionHandler: @escaping (MovieSearchResults?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
}
