//
//  NowPlayingQuery.swift
//  MovieToWatch
//
//  Created by Clark on 8/1/20.
//  Copyright © 2020 Hongfei Yang. All rights reserved.
//

import Foundation

struct NowPlayingQuery: Codable {
    let api_key = API_KEY
    var language: String?
    var page: Int? = 1
    var region: String?
}
