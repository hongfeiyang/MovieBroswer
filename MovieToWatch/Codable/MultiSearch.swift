//
//  MultiSearch.swift
//  MovieToWatch
//
//  Created by Clark on 9/3/20.
//  Copyright © 2020 Hongfei Yang. All rights reserved.
//

import Foundation


struct MultiSearchResults: Decodable {
    let page: Int
    let total_results: Int
    let total_pages: Int
    let results: [IMultiSearchResult]
    
    enum CodingKeys: CodingKey {
        case page
        case total_results
        case total_pages
        case results
    }

    enum ResultsTypeKey: CodingKey {
        case media_type
    }

    enum ResultTypes: String, Decodable {
        case movie = "movie"
        case tv = "tv"
        case person = "person"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.page = try container.decode(Int.self, forKey: .page)
        self.total_results = try container.decode(Int.self, forKey: .total_results)
        self.total_pages = try container.decode(Int.self, forKey: .total_pages)
        
        var unkeyedContainer = try container.nestedUnkeyedContainer(forKey: CodingKeys.results)
        var results = [IMultiSearchResult]()

        while(!unkeyedContainer.isAtEnd) {
            let keyedContainer = try unkeyedContainer.nestedContainer(keyedBy: ResultsTypeKey.self)
            let mediaType = try keyedContainer.decode(ResultTypes.self, forKey: ResultsTypeKey.media_type)
            switch mediaType {
            case .tv:
                results.append(try unkeyedContainer.decode(TvMultiSearchResult.self))
            case .person:
                results.append(try unkeyedContainer.decode(PersonMultiSearchResult.self))
            case .movie:
                results.append(try unkeyedContainer.decode(MovieMultiSearchResult.self))
            }
        }
        self.results = results
    }
}


protocol IMultiSearchResult: Decodable {
    var media_type: String { get set }
}

struct MovieMultiSearchResult: IMultiSearchResult {
    var media_type: String
    
    var posterPath: String?
    var popularity: Double?
    var voteCount: Int?
    var video: Bool?
    var id: Int?
    var adult: Bool?
    var backdropPath, originalLanguage, originalTitle: String?
    var genreIDS: [Int]
    var title: String?
    var voteAverage: Double?
    var overview, releaseDate: String?

    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case popularity
        case voteCount = "vote_count"
        case video
        case media_type
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

struct PersonMultiSearchResult: IMultiSearchResult {
    var media_type: String
    
    var knownForDepartment: String?
    var id: Int?
    var name: String?
    var knownFor: [KnownFor]?
    var popularity: Double?
    var profilePath: String?
    var gender: Int?
    var adult: Bool?

    enum CodingKeys: String, CodingKey {
        case knownForDepartment = "known_for_department"
        case id, name
        case knownFor = "known_for"
        case popularity
        case profilePath = "profile_path"
        case gender
        case media_type
        case adult
    }
    
    struct KnownFor: Codable {
        let releaseDate: String?
        let id, voteCount: Int?
        let video: Bool?
        let mediaType: String
        let voteAverage: Double?
        let title: String?
        let genreIDS: [Int]?
        let originalTitle, originalLanguage: String?
        let adult: Bool?
        let backdropPath, overview, posterPath: String?

        enum CodingKeys: String, CodingKey {
            case releaseDate = "release_date"
            case id
            case voteCount = "vote_count"
            case video
            case mediaType = "media_type"
            case voteAverage = "vote_average"
            case title
            case genreIDS = "genre_ids"
            case originalTitle = "original_title"
            case originalLanguage = "original_language"
            case adult
            case backdropPath = "backdrop_path"
            case overview
            case posterPath = "poster_path"
        }
    }
}

struct TvMultiSearchResult: IMultiSearchResult {
    var media_type: String
    
    var originalName: String?
    var genreIDS: [Int]?
    var name: String?
    var popularity: Double?
    var originCountry: [String]?
    var voteCount: Int?
    var firstAirDate, backdropPath, originalLanguage: String?
    var id: Int?
    var voteAverage: Double?
    var overview, posterPath: String?

    enum CodingKeys: String, CodingKey {
        case originalName = "original_name"
        case genreIDS = "genre_ids"
        case media_type
        case name, popularity
        case originCountry = "origin_country"
        case voteCount = "vote_count"
        case firstAirDate = "first_air_date"
        case backdropPath = "backdrop_path"
        case originalLanguage = "original_language"
        case id
        case voteAverage = "vote_average"
        case overview
        case posterPath = "poster_path"
    }
}
