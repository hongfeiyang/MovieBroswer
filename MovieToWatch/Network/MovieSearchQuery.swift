//
//  SearchMovie.swift
//  MovieToWatch
//
//  Created by Clark on 26/12/19.
//  Copyright © 2019 Hongfei Yang. All rights reserved.
//

import Foundation


struct MovieSearchQuery: Codable {
    
    let baseURL = "https://api.themoviedb.org/3/search/movie"
    
    var api_key: String = API_KEY
    var language: String?
    var query: String = ""
    var page: Int?
    var include_adult: Bool?
    var region: String?
    var year: String?
    var primary_release_year: String?
    
    enum CodingKeys: String, CodingKey {
        case api_key = "api_key"
        case language = "language"
        case query = "query"
        case page = "page"
        case include_adult = "include_adult"
        case region = "region"
        case year = "year"
        case primary_release_year = "primary_release_year"
    }
    
    init(query: String) {
        self.query = query
    }
    
    init(query: String, language: String?, page: Int?, include_adult: Bool?, region: String?, year: String?, primary_release_year: String?) {
        self.query = query
        self.language = language
        self.page = page
        self.include_adult = include_adult
        self.region = region
        self.year = year
        self.primary_release_year = primary_release_year
    }
}
