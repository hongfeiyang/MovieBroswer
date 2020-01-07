//
//  NowPlayingQuery.swift
//  MovieToWatch
//
//  Created by Clark on 8/1/20.
//  Copyright © 2020 Hongfei Yang. All rights reserved.
//

import Foundation

struct NowPlayingQuery: CustomStringConvertible {
    let baseURL = "https://api.themoviedb.org/3/movie/now_playing"
    
    var language: String?
    var page: Int? = 1
    var region: String?
    
    init() {}
    
    init(page: Int) {
        self.page = page
    }
    
    init(language: String?, page: Int?, region: String?) {
        self.language = language
        self.page = page
        self.region = region
    }
    
    var description: String {
        var result = baseURL + "?" + "api_key=\(API_KEY)"
        
        if let language = language {
            result += "&language=\(language)"
        }
        
        if let page = page {
            result += "&page=\(page)"
        }
        
        if let region = region {
            result += "&region=\(region)"
        }
        
        return result
    }
}
