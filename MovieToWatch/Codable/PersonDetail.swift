// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let personDetail = try? newJSONDecoder().decode(PersonDetail.self, from: jsonData)

import Foundation

// MARK: - PersonDetail
struct PersonDetail: Codable {
    let birthday, knownForDepartment: String?
    let id: Int
    let placeOfBirth: String?

    let combinedCredits: CombinedCredits?
    let profilePath, imdbID: String?
    let deathday: String?
    let images: Images?
    let taggedImages: TaggedImages?
    let name: String?
    let tvCredits: TvCredits?
    let alsoKnownAs: [String]?
    let movieCredits: MovieCredits?
    
    let homepage: String?
    let translations: Translations?
    let adult: Bool?
    let gender: Int?
    let popularity: Double?
    let biography: String?

    enum CodingKeys: String, CodingKey {
        case birthday
        case knownForDepartment = "known_for_department"
        case id
        case placeOfBirth = "place_of_birth"
       
        case combinedCredits = "combined_credits"
        case profilePath = "profile_path"
        case imdbID = "imdb_id"
        case deathday, images
        case taggedImages = "tagged_images"
        case name
        case tvCredits = "tv_credits"
        case alsoKnownAs = "also_known_as"
        case movieCredits = "movie_credits"
        case homepage, translations, adult, gender, popularity, biography
    }
}

// MARK: - CombinedCredits
struct CombinedCredits: Codable {
    let cast, crew: [CombinedCreditsCast]
}

// MARK: - CombinedCreditsCast
struct CombinedCreditsCast: Codable {
    let id: Int
    let originalLanguage: String?
    let originalTitle: String?
    let overview: String?
    let voteCount: Int?
    let video: Bool?
    let mediaType: MediaType
    let creditID: String?
    let releaseDate: String?
    let voteAverage, popularity: Double?
    let title, character: String?
    let genreIDS: [Int]?
    let adult: Bool?
    let backdropPath, posterPath: String?
    let episodeCount: Int?
    let originCountry: [String]?
    let originalName, name, firstAirDate: String?
    let department: String?
    let job: String?

    enum CodingKeys: String, CodingKey {
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case voteCount = "vote_count"
        case video
        case mediaType = "media_type"
        case creditID = "credit_id"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case popularity, title, character
        case genreIDS = "genre_ids"
        case adult
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
        case episodeCount = "episode_count"
        case originCountry = "origin_country"
        case originalName = "original_name"
        case name
        case firstAirDate = "first_air_date"
        case department, job
    }
}




// MARK: - Images
struct Images: Codable {
    let profiles: [Profile]
}

// MARK: - Profile
struct Profile: Codable {
    let iso639_1: String?
    let aspectRatio: Double?
    let voteCount, height: Int?
    let voteAverage: Double?
    let filePath: String?
    let width: Int?
    let mediaType: MediaType?
    let media: MediaElement?

    enum CodingKeys: String, CodingKey {
        case iso639_1 = "iso_639_1"
        case aspectRatio = "aspect_ratio"
        case voteCount = "vote_count"
        case height
        case voteAverage = "vote_average"
        case filePath = "file_path"
        case width
        case mediaType = "media_type"
        case media
    }
}

// MARK: - MediaElement
struct MediaElement: Codable {
    let releaseDate: String?
    let adult: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    let video: Bool?
    let title: String?
    let popularity: Double?
    let genreIDS: [Int]?
    let originalLanguage: String?
    let character: String?
    let originalTitle: String?
    let posterPath: String?
    let id: Int
    let backdropPath: String?
    let overview: String?
    let creditID: String?
    let department: String?
    let job: String?

    enum CodingKeys: String, CodingKey {
        case releaseDate = "release_date"
        case adult
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case video, title, popularity
        case genreIDS = "genre_ids"
        case originalLanguage = "original_language"
        case character
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case id
        case backdropPath = "backdrop_path"
        case overview
        case creditID = "credit_id"
        case department, job
    }
}

// MARK: - MovieCredits
struct MovieCredits: Codable {
    let cast, crew: [MediaElement]?
}

// MARK: - TaggedImages
struct TaggedImages: Codable {
    let results: [Profile]
    let page, totalResults, id, totalPages: Int?

    enum CodingKeys: String, CodingKey {
        case results, page
        case totalResults = "total_results"
        case id
        case totalPages = "total_pages"
    }
}

// MARK: - Translations
struct Translations: Codable {
    let translations: [Translation]
}

// MARK: - Translation
struct Translation: Codable {
    let iso639_1, iso3166_1, name: String?
    let data: DataClass?
    let englishName: String?

    enum CodingKeys: String, CodingKey {
        case iso639_1 = "iso_639_1"
        case iso3166_1 = "iso_3166_1"
        case name, data
        case englishName = "english_name"
    }
}

// MARK: - DataClass
struct DataClass: Codable {
    let biography: String
}

// MARK: - TvCredits
struct TvCredits: Codable {
    let cast, crew: [TvCreditsCast]
}

// MARK: - TvCreditsCast
struct TvCreditsCast: Codable {
    let originCountry: [String]?
    let originalName: String?
    let genreIDS: [Int]?
    let voteCount: Int?
    let backdropPath: String?
    let name, firstAirDate: String?
    let originalLanguage: String?
    let popularity: Double?
    let character: String?
    let episodeCount: Int?
    let id: Int
    let creditID: String?
    let voteAverage: Double?
    let overview: String?
    let posterPath: String?
    let department: String?
    let job: String?

    enum CodingKeys: String, CodingKey {
        case originCountry = "origin_country"
        case originalName = "original_name"
        case genreIDS = "genre_ids"
        case voteCount = "vote_count"
        case backdropPath = "backdrop_path"
        case name
        case firstAirDate = "first_air_date"
        case originalLanguage = "original_language"
        case popularity, character
        case episodeCount = "episode_count"
        case id
        case creditID = "credit_id"
        case voteAverage = "vote_average"
        case overview
        case posterPath = "poster_path"
        case department, job
    }
}

