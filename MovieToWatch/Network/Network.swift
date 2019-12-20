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

struct DiscoverMovieQuery {
    
    static let baseURL = "https://api.themoviedb.org/3/discover/movie"
    
    private var api_key: String = "8bb40fd6bdda6cfcc5397a96da82609d"
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
    
    init() {
        
    }
}


class Network {
    
    static func getDiscoverMovieResults(query: DiscoverMovieQuery, completion: (([MovieItem]) -> Void)?) {
        guard let url = URL(string: query.description) else {return}
        let session = URLSession.shared.discoverMovieTask(with: url) {(data, response, error) in
            NSLog("response received")
            guard let data = data else {print("fail to parse DiscoverMovie"); return}
            NSLog("response parsed")
            completion?(data.results)
        }
        session.resume()
        NSLog("Query send: \(query.description)")
        
        
    }
}
