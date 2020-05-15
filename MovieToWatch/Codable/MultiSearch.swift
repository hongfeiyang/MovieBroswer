//
//  MultiSearch.swift
//  MovieToWatch
//
//  Created by Clark on 9/3/20.
//  Copyright © 2020 Hongfei Yang. All rights reserved.
//

import Foundation


struct MultiSearchResults: Codable {
    let page: Int
    let total_results: Int
    let total_pages: Int
    let results: [ISearchResult]
    
    enum CodingKeys: CodingKey {
        case page
        case total_results
        case total_pages
        case results
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(page, forKey: .page)
        try container.encode(total_pages, forKey: .total_pages)
        try container.encode(total_results, forKey: .total_results)
        try container.encode(results.map{AnyResult($0)}, forKey: .results)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.page = try container.decode(Int.self, forKey: .page)
        self.total_results = try container.decode(Int.self, forKey: .total_results)
        self.total_pages = try container.decode(Int.self, forKey: .total_pages)
        self.results = try container.decode([AnyResult].self, forKey: .results).map { $0.result }
    }
}


struct AnyResult: Codable {
    var result: ISearchResult
    
    init(_ result: ISearchResult) {
        self.result = result
    }
    
    private enum CodingKeys: CodingKey {
        case media_type
        case result
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type(of: result).staticType, forKey: .media_type)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(MediaType.self, forKey: .media_type)
        self.result = try type.metaType.init(from: decoder)
    }
}

enum MediaType: String, Codable {
    case movie
    case tv
    case person
    
    var metaType: ISearchResult.Type {
        switch self {
        case .movie:
            return MovieMultiSearchResult.self
        case .tv:
            return TvMultiSearchResult.self
        case .person:
            return PersonMultiSearchResult.self
        }
    }
}

protocol ISearchResult: Codable {
    static var staticType: MediaType {get} // type for interminent decoding class
    var media_type: MediaType { get set } // common type for subclasses
}


struct MovieMultiSearchResult: ISearchResult {
    static var staticType: MediaType = .movie

    var media_type: MediaType
    let posterPath: String?
    let popularity: Double?
    let voteCount: Int?
    let video: Bool?
    let id: Int?
    let adult: Bool?
    let backdropPath, originalLanguage, originalTitle: String?
    let genreIDS: [Int]?
    let title: String?
    let voteAverage: Double?
    let overview, releaseDate: String?

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

struct PersonMultiSearchResult: ISearchResult {
    static var staticType: MediaType = .person
    
    var media_type: MediaType
    
    let knownForDepartment: String?
    let id: Int?
    let name: String?
    let knownFor: [ISearchResult]?
    let popularity: Double?
    let profilePath: String?
    let adult: Bool?

    enum CodingKeys: String, CodingKey {
        case id, name
        case knownFor = "known_for"
        case popularity
        case profilePath = "profile_path"
        case media_type
        case adult
        case knownForDepartment = "known_for_department"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(popularity, forKey: .popularity)
        try container.encode(profilePath, forKey: .profilePath)
        try container.encode(adult, forKey: .adult)
        try container.encode(media_type, forKey: .media_type)
        try container.encode(knownForDepartment, forKey: .knownForDepartment)
        if let knownFor = knownFor {
            try container.encode(knownFor.map{AnyResult($0)}, forKey: .knownFor)
        }
        
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(Int?.self, forKey: .id)
        self.name = try container.decode(String?.self, forKey: .name)
        self.popularity = try container.decode(Double?.self, forKey: .popularity)
        self.profilePath = try container.decode(String?.self, forKey: .profilePath)
        self.media_type = try container.decode(MediaType.self, forKey: .media_type)
        self.adult = try container.decode(Bool?.self, forKey: .adult)
        self.knownForDepartment = try container.decode(String?.self, forKey: .knownForDepartment)
        self.knownFor = try container.decode([AnyResult].self, forKey: .knownFor).map { $0.result }
    }
    
    
}

struct TvMultiSearchResult: ISearchResult {
    static var staticType: MediaType = .tv
    
    var media_type: MediaType

    let originalName: String?
    let genreIDS: [Int]?
    let name: String?
    let popularity: Double?
    let originCountry: [String]?
    let voteCount: Int?
    let firstAirDate, backdropPath, originalLanguage: String?
    let id: Int?
    let voteAverage: Double?
    let overview, posterPath: String?

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
