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
    let images: PersonImages?
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
    let cast: [PersonCastCredit]
    let crew: [PersonCrewCredit]
}

// MARK: - Images
struct PersonImages: Codable {
    let profiles: [ImageProfile]
}

// MARK: - Profile
struct ImageProfile: Codable {
    let iso639_1: String?
    let aspectRatio: Double?
    let voteCount, height: Int?
    let voteAverage: Double?
    let filePath: String?
    let width: Int?

    enum CodingKeys: String, CodingKey {
        case iso639_1 = "iso_639_1"
        case aspectRatio = "aspect_ratio"
        case voteCount = "vote_count"
        case height
        case voteAverage = "vote_average"
        case filePath = "file_path"
        case width
    }
}

struct PersonCastCredit: Codable {
    let id: Int
    let originalLanguage: String?
    let episodeCount: Int?
    let overview: String?
    let originCountry: [String]?
    let originalName: String?
    let genreIDS: [Int]?
    let name: String?
    let mediaType: MediaType?
    let posterPath: String?
    let firstAirDate: String?
    let voteAverage: Double?
    let voteCount: Int?
    let character: String?
    let backdropPath: String?
    let popularity: Double?
    let creditID, originalTitle: String?
    let video: Bool?
    let releaseDate, title: String?
    let adult: Bool?

    enum CodingKeys: String, CodingKey {
        case id
        case originalLanguage = "original_language"
        case episodeCount = "episode_count"
        case overview
        case originCountry = "origin_country"
        case originalName = "original_name"
        case genreIDS = "genre_ids"
        case name
        case mediaType = "media_type"
        case posterPath = "poster_path"
        case firstAirDate = "first_air_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case character
        case backdropPath = "backdrop_path"
        case popularity
        case creditID = "credit_id"
        case originalTitle = "original_title"
        case video
        case releaseDate = "release_date"
        case title, adult
    }
}

struct PersonCrewCredit: Codable {
    let id: Int
    let department: String?
    let originalLanguage: String?
    let episodeCount: Int?
    let job: String?
    let overview: String?
    let originCountry: [String]?
    let originalName: String?
    let voteCount: Int?
    let name: String?
    let mediaType: MediaType?
    let popularity: Double?
    let creditID: String?
    let backdropPath: String?
    let firstAirDate: String?
    let voteAverage: Double?
    let genreIDS: [Int]?
    let posterPath: String?
    let originalTitle: String?
    let video: Bool?
    let title: String?
    let adult: Bool?
    let releaseDate: String?

    enum CodingKeys: String, CodingKey {
        case id, department
        case originalLanguage = "original_language"
        case episodeCount = "episode_count"
        case job, overview
        case originCountry = "origin_country"
        case originalName = "original_name"
        case voteCount = "vote_count"
        case name
        case mediaType = "media_type"
        case popularity
        case creditID = "credit_id"
        case backdropPath = "backdrop_path"
        case firstAirDate = "first_air_date"
        case voteAverage = "vote_average"
        case genreIDS = "genre_ids"
        case posterPath = "poster_path"
        case originalTitle = "original_title"
        case video, title, adult
        case releaseDate = "release_date"
    }
}


// MARK: - MovieCredits
struct MovieCredits: Codable {
    let cast: [PersonCastCredit]
    let crew: [PersonCrewCredit]
}

// MARK: - TaggedImages
struct TaggedImages: Codable {
    let results: [ImageProfile]
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
    
    struct DataClass: Codable {
        let biography: String
    }

    enum CodingKeys: String, CodingKey {
        case iso639_1 = "iso_639_1"
        case iso3166_1 = "iso_3166_1"
        case name, data
        case englishName = "english_name"
    }
}



// MARK: - TvCredits
struct TvCredits: Codable {
    let cast: [TvCreditsCast]
    let crew: [TvCreditsCrew]
}

// MARK: - TvCreditsCast
struct TvCreditsCast: Codable {
    let creditID, originalName: String?
    let id: Int
    let genreIDS: [Int]?
    let character, name, posterPath: String?
    let voteCount: Int?
    let voteAverage, popularity: Double?
    let episodeCount: Int?
    let originalLanguage, firstAirDate, backdropPath, overview: String?
    let originCountry: [String]?

    enum CodingKeys: String, CodingKey {
        case creditID = "credit_id"
        case originalName = "original_name"
        case id
        case genreIDS = "genre_ids"
        case character, name
        case posterPath = "poster_path"
        case voteCount = "vote_count"
        case voteAverage = "vote_average"
        case popularity
        case episodeCount = "episode_count"
        case originalLanguage = "original_language"
        case firstAirDate = "first_air_date"
        case backdropPath = "backdrop_path"
        case overview
        case originCountry = "origin_country"
    }
}

struct TvCreditsCrew: Codable {
    let id: Int
    let department, originalLanguage: String?
    let episodeCount: Int?
    let job, overview: String?
    let originCountry: [String]?
    let originalName: String?
    let genreIDS: [Int]?
    let name, firstAirDate, backdropPath: String?
    let popularity: Double?
    let voteCount: Int?
    let voteAverage: Double?
    let posterPath, creditID: String?

    enum CodingKeys: String, CodingKey {
        case id, department
        case originalLanguage = "original_language"
        case episodeCount = "episode_count"
        case job, overview
        case originCountry = "origin_country"
        case originalName = "original_name"
        case genreIDS = "genre_ids"
        case name
        case firstAirDate = "first_air_date"
        case backdropPath = "backdrop_path"
        case popularity
        case voteCount = "vote_count"
        case voteAverage = "vote_average"
        case posterPath = "poster_path"
        case creditID = "credit_id"
    }
}

