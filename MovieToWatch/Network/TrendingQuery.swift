//
//  TrendingQuery.swift
//  MovieToWatch
//
//  Created by Clark on 9/3/20.
//  Copyright © 2020 Hongfei Yang. All rights reserved.
//

import Foundation

struct TrendingQuery: Codable {
    let api_key = API_KEY
    let media_type: TrendingMediaType
    let time_window: TimeWindow
}

enum TimeWindow: String, Codable {
    case day = "day"
    case week = "week"
}

enum TrendingMediaType: String, Codable {
    case all = "all"
    case movie = "movie"
    case person = "person"
    case tv = "tv"
}
