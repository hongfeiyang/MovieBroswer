// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let popular = try? newJSONDecoder().decode(Popular.self, from: jsonData)

//
// To read values from URLs:
//
//   let task = URLSession.shared.popularTask(with: url) { popular, response, error in
//     if let popular = popular {
//       ...
//     }
//   }
//   task.resume()

import Foundation

// MARK: - Popular
struct Popular: Codable {
    let results: [MovieListResult]
    let page, totalResults: Int
    let totalPages: Int

    enum CodingKeys: String, CodingKey {
        case results, page
        case totalResults = "total_results"
        case totalPages = "total_pages"
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

    func popularTask(with url: URL, completionHandler: @escaping (Popular?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
}
