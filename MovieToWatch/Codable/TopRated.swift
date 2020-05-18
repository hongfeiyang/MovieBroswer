// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let topRated = try? newJSONDecoder().decode(TopRated.self, from: jsonData)

//
// To read values from URLs:
//
//   let task = URLSession.shared.topRatedTask(with: url) { topRated, response, error in
//     if let topRated = topRated {
//       ...
//     }
//   }
//   task.resume()

import Foundation

// MARK: - TopRated
struct TopRated: Codable {
    let page, totalResults, totalPages: Int
    let results: [MovieListResult]

    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
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
            completionHandler(try? newJSONDecoder().decode(T.self, from: data), response, nil)
        }
    }

    func topRatedTask(with url: URL, completionHandler: @escaping (TopRated?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
}
