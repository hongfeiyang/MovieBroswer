//
//  Network.swift
//  MovieToWatch
//
//  Created by Clark on 20/12/19.
//  Copyright © 2019 Hongfei Yang. All rights reserved.
//

import Foundation

enum SortByOptions: String {
    case popularity = "popularity"
    case release_date = "release_date"
    case revenue = "revenue"
    case vote_average = "vote_average"
    case vote_count = "vote_count"
}

enum Order: String {
    case asc = ".asc"
    case desc = ".desc"
}

struct DiscoverMovieQuery: CustomStringConvertible {
    
    static let baseURL = "https://api.themoviedb.org/3/discover/movie"
    
    private var api_key: String = API_KEY
    private var language: String?
    private var region: String?
    private var sort_option: SortByOptions?
    private var order: Order?
    private var sort_by: String? {
        if let sort_option = sort_option, let order = order {
            return sort_option.rawValue + order.rawValue
        }
        return nil
    }
    private var include_adult: Bool?
    private var include_video: Bool?
    private var page: Int?
    
    var description: String {
        
        var result = DiscoverMovieQuery.baseURL + "?" + "api_key=\(api_key)"
        
        if let language = language {
            result += "&language=\(language)"
        }
        if let region = region {
            result += "&region=\(region)"
        }
        if let sort_by = sort_by {
            result += "&sort_by=\(sort_by)"
        }
        if let include_adult = include_adult {
            result += "&include_adult=\(include_adult)"
        }
        if let include_video = include_video {
            result += "&include_video=\(include_video)"
        }
        if let page = page {
            result += "&page=\(page)"
        }

        return result
    }
    
    init(language: String?, region: String?, sort_option: SortByOptions?, order: Order?, page: Int?, include_adult: Bool?, include_video: Bool?) {
        self.language = language
        self.region = region
        self.sort_option = sort_option
        self.order = order
        self.include_adult = include_adult
        self.include_video = include_video
        self.page = page
    }
    
    init() {}
}

struct MovieDetailQuery: CustomStringConvertible {

    let baseURL = "https://api.themoviedb.org/3/movie/"
    
    let movieID: Int
    var language: String?
    var append_to_response: String?
    
    init(movieID: Int) {
        self.movieID = movieID
    }
    
    init(movieID: Int, language: String) {
        self.movieID = movieID
        self.language = language
    }
    
    init(movieID: Int, language: String, append_to_response: String) {
        self.movieID = movieID
        self.language = language
        self.append_to_response = append_to_response
    }
    
    var description: String {
        var result = baseURL + "\(movieID)" + "?" + "api_key=\(API_KEY)"
        
        if let language = language {
            result += "&language=\(language)"
        }
        
        if let append_to_response = append_to_response {
            result += "&append_to_response=\(append_to_response)"
        }
        
        return result
    }
}


class Network {
    
    static func getMovieDetail(query: MovieDetailQuery, completion: ((MovieMO) -> Void)?) {
        guard let url = URL(string: query.description) else {return}
        URLSession.shared.movieDetailTask(with: url) {(data, response, error) in
            NSLog("response received")
            guard let data = data else {print("movieDetailTask returned nil"); return}
            NSLog("response parsed")
            completion?(data)
        }.resume()
        NSLog("Query send: \(query)")
    }
    
    static func getDiscoverMovieResults(query: DiscoverMovieQuery, completion: (([MovieResult]) -> Void)?) {
        guard let url = URL(string: query.description) else {return}
        URLSession.shared.discoverMovieTask(with: url) {(data, response, error) in
            NSLog("response received")
            guard let data = data else {print("fail to parse DiscoverMovie"); return}
            NSLog("response parsed")
            completion?(data.results)
        }.resume()
        NSLog("Query send: \(query.description)")
        
        
    }
}
