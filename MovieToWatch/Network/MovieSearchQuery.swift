//
//  SearchMovie.swift
//  MovieToWatch
//
//  Created by Clark on 26/12/19.
//  Copyright © 2019 Hongfei Yang. All rights reserved.
//

import Foundation


struct MovieSearchQuery: CustomStringConvertible {
    
    let baseURL = "https://api.themoviedb.org/3/search/movie"
    
    var language: String?
    var query: String
    var page: Int?
    var include_adult: Bool?
    var region: String?
    var year: String?
    var primary_release_year: String?
    
    
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
    
    var description: String {
        
        var result = baseURL + "?" + "api_key=\(API_KEY)"
        result += "&query=\(query.replacingOccurrences(of: " ", with: "%20"))"
        
        if let language = language {
            result += "&language=\(language)"
        }
        if let region = region {
            result += "&region=\(region)"
        }
        
        if let primary_release_year = primary_release_year {
            result += "&primary_release_year=\(primary_release_year)"
        }

        if let include_adult = include_adult {
            result += "&include_adult=\(include_adult)"
        }
        if let year = year {
            result += "&year=\(year)"
        }
        if let page = page {
            result += "&page=\(page)"
        }

        return result
    }
}
