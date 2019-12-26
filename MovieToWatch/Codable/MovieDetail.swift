// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let movieDetail = try? newJSONDecoder().decode(MovieDetail.self, from: jsonData)

//
// To read values from URLs:
//
//   let task = URLSession.shared.movieDetailTask(with: url) { movieDetail, response, error in
//     if let movieDetail = movieDetail {
//       ...
//     }
//   }
//   task.resume()

import Foundation

// MARK: - MovieDetail
struct MovieDetail: Codable {
    let adult: Bool?
    let backdropPath: String?
    let belongsToCollection: BelongsToCollection?
    let budget: Int?
    let genres: [Genre]?
    let homepage: String?
    let id: Int
    let imdbID, originalLanguage, originalTitle, overview: String?
    let popularity: Double?
    let posterPath: String?
    let productionCompanies: [ProductionCompany]?
    let productionCountries: [ProductionCountry]?
    let releaseDate: Date?
    let revenue, runtime: Int?
    let spokenLanguages: [SpokenLanguage]?
    let status, tagline, title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case belongsToCollection = "belongs_to_collection"
        case budget, genres, homepage, id
        case imdbID = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case revenue, runtime
        case spokenLanguages = "spoken_languages"
        case status, tagline, title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.belongsToCollectionTask(with: url) { belongsToCollection, response, error in
//     if let belongsToCollection = belongsToCollection {
//       ...
//     }
//   }
//   task.resume()

// MARK: - BelongsToCollection
struct BelongsToCollection: Codable {
    let id: Int
    let name, posterPath, backdropPath: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.genreTask(with: url) { genre, response, error in
//     if let genre = genre {
//       ...
//     }
//   }
//   task.resume()

// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name: String?
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.productionCompanyTask(with: url) { productionCompany, response, error in
//     if let productionCompany = productionCompany {
//       ...
//     }
//   }
//   task.resume()

// MARK: - ProductionCompany
struct ProductionCompany: Codable {
    let id: Int
    let logoPath, name, originCountry: String?

    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.productionCountryTask(with: url) { productionCountry, response, error in
//     if let productionCountry = productionCountry {
//       ...
//     }
//   }
//   task.resume()

// MARK: - ProductionCountry
struct ProductionCountry: Codable {
    let iso3166_1, name: String?

    enum CodingKeys: String, CodingKey {
        case iso3166_1 = "iso_3166_1"
        case name
    }
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.spokenLanguageTask(with: url) { spokenLanguage, response, error in
//     if let spokenLanguage = spokenLanguage {
//       ...
//     }
//   }
//   task.resume()

// MARK: - SpokenLanguage
struct SpokenLanguage: Codable {
    let iso639_1, name: String?

    enum CodingKeys: String, CodingKey {
        case iso639_1 = "iso_639_1"
        case name
    }
}

// MARK: - Helper functions for creating encoders and decoders
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
            completionHandler(try? newJSONDecoder().decode(T.self, from: data), response, nil)
        }
    }

    func movieDetailTask(with url: URL, completionHandler: @escaping (MovieDetail?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
}
