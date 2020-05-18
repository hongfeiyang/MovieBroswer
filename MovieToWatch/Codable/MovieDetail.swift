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
    let videos: MovieVideos
    let images: MovieImages
    let reviews: MovieReviews
    let keywords: Keywords?
    let releaseDates: ReleaseDates?
    let recommendations: MovieRecommendationsResponse?
    let lists: Lists?
    let credits: Credits?
    let similarMovies: SimilarMoviesResponse?
    
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
        case videos
        case images
        case reviews
        case keywords
        case releaseDates = "release_dates"
        case recommendations, lists
        case credits
        case similarMovies = "similar_movies"
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


// MARK: - Credits
struct Credits: Codable {
    let cast: [Cast]
    let crew: [Crew]
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.castTask(with: url) { cast, response, error in
//     if let cast = cast {
//       ...
//     }
//   }
//   task.resume()

// MARK: - Cast
struct Cast: Codable {
    let castID: Int?
    let character, creditID: String?
    let gender, id: Int?
    let name: String?
    let order: Int?
    let profilePath: String?

    enum CodingKeys: String, CodingKey {
        case castID = "cast_id"
        case character
        case creditID = "credit_id"
        case gender, id, name, order
        case profilePath = "profile_path"
    }
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.crewTask(with: url) { crew, response, error in
//     if let crew = crew {
//       ...
//     }
//   }
//   task.resume()

// MARK: - Crew
struct Crew: Codable {
    let creditID, department: String?
    let gender, id: Int?
    let job, name: String?
    let profilePath: String?

    enum CodingKeys: String, CodingKey {
        case creditID = "credit_id"
        case department, gender, id, job, name
        case profilePath = "profile_path"
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
//   let task = URLSession.shared.imagesTask(with: url) { images, response, error in
//     if let images = images {
//       ...
//     }
//   }
//   task.resume()

// MARK: - Images
struct MovieImages: Codable {
    let backdrops, posters: [ImageDetail]
}


//
// To read values from URLs:
//
//   let task = URLSession.shared.imageDetailTask(with: url) { backdrop, response, error in
//     if let backdrop = backdrop {
//       ...
//     }
//   }
//   task.resume()

// MARK: - ImageDetail
struct ImageDetail: Codable {
    let aspectRatio: Double?
    let filePath: String?
    let height: Int?
    let iso639_1: String?
    let voteAverage: Double?
    let voteCount, width: Int?

    enum CodingKeys: String, CodingKey {
        case aspectRatio = "aspect_ratio"
        case filePath = "file_path"
        case height
        case iso639_1 = "iso_639_1"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case width
    }
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.keywordsTask(with: url) { keywords, response, error in
//     if let keywords = keywords {
//       ...
//     }
//   }
//   task.resume()

// MARK: - Keywords
struct Keywords: Codable {
    let keywords: [Genre]
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.listsTask(with: url) { lists, response, error in
//     if let lists = lists {
//       ...
//     }
//   }
//   task.resume()

// MARK: - Lists
struct Lists: Codable {
    let page: Int
    let results: [ListsResult]
    let totalPages, totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.listsResultTask(with: url) { listsResult, response, error in
//     if let listsResult = listsResult {
//       ...
//     }
//   }
//   task.resume()

// MARK: - ListsResult
struct ListsResult: Codable {
    let resultDescription: String?
    let favoriteCount, id, itemCount: Int?
    let iso639_1: String?
    let listType: String?
    let name: String?
    let posterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case resultDescription = "description"
        case favoriteCount = "favorite_count"
        case id
        case itemCount = "item_count"
        case iso639_1 = "iso_639_1"
        case listType = "list_type"
        case name
        case posterPath = "poster_path"
    }
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
//   let task = URLSession.shared.releaseDatesTask(with: url) { releaseDates, response, error in
//     if let releaseDates = releaseDates {
//       ...
//     }
//   }
//   task.resume()

// MARK: - ReleaseDates
struct ReleaseDates: Codable {
    let results: [ReleaseDatesResult]
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.releaseDatesResultTask(with: url) { releaseDatesResult, response, error in
//     if let releaseDatesResult = releaseDatesResult {
//       ...
//     }
//   }
//   task.resume()

// MARK: - ReleaseDatesResult
struct ReleaseDatesResult: Codable {
    let iso3166_1: String
    let releaseDates: [ReleaseDate]
    
    enum CodingKeys: String, CodingKey {
        case iso3166_1 = "iso_3166_1"
        case releaseDates = "release_dates"
    }
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.releaseDateTask(with: url) { releaseDate, response, error in
//     if let releaseDate = releaseDate {
//       ...
//     }
//   }
//   task.resume()

// MARK: - ReleaseDate
struct ReleaseDate: Codable {
    let certification, iso639_1: String?
    let note: String?
    let releaseDate: String?
    let type: Int?
    
    enum CodingKeys: String, CodingKey {
        case certification
        case iso639_1 = "iso_639_1"
        case note
        case releaseDate = "release_date"
        case type
    }
}


//
// To read values from URLs:
//
//   let task = URLSession.shared.reviewsTask(with: url) { reviews, response, error in
//     if let reviews = reviews {
//       ...
//     }
//   }
//   task.resume()

// MARK: - Reviews
struct MovieReviews: Codable {
    let page: Int
    let results: [ReviewsResult]
    let totalPages, totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.reviewsResultTask(with: url) { reviewsResult, response, error in
//     if let reviewsResult = reviewsResult {
//       ...
//     }
//   }
//   task.resume()

// MARK: - ReviewsResult
struct ReviewsResult: Codable {
    let author, content, id: String?
    let url: String?
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

//
// To read values from URLs:
//
//   let task = URLSession.shared.videosTask(with: url) { videos, response, error in
//     if let videos = videos {
//       ...
//     }
//   }
//   task.resume()

// MARK: - Videos
struct MovieVideos: Codable {
    let results: [VideosResult]
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.videosResultTask(with: url) { videosResult, response, error in
//     if let videosResult = videosResult {
//       ...
//     }
//   }
//   task.resume()

// MARK: - VideosResult
struct VideosResult: Codable {
    let id: String?
    let iso639_1: String?
    let iso3166_1: String?
    let key, name: String?
    let site: String?
    let size: Int?
    let type: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case iso639_1 = "iso_639_1"
        case iso3166_1 = "iso_3166_1"
        case key, name, site, size, type
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
    
    func movieDetailTask(with url: URL, completionHandler: @escaping (MovieDetail?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
}
