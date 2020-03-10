//
//  MultiSearchQuery.swift
//  MovieToWatch
//
//  Created by Clark on 9/3/20.
//  Copyright © 2020 Hongfei Yang. All rights reserved.
//

import Foundation

struct MultiSearchQuery: Codable {
    var api_key = API_KEY
    var language: String?
    var query: String
    var page: Int?
    var include_adult: Bool?
    var region: String?
    
    init(query: String, language: String? = nil, page: Int? = nil, include_adult: Bool? = nil, region: String? = nil) {
        self.query = query
        self.language = language
        self.page = page
        self.include_adult = include_adult
        self.region = region
    }
}
