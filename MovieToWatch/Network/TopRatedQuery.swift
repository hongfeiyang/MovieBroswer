//
//  TopRatedQuery.swift
//  MovieToWatch
//
//  Created by Clark on 19/1/20.
//  Copyright © 2020 Hongfei Yang. All rights reserved.
//

import Foundation

struct TopRatedQuery: Codable {
    let api_key = API_KEY
    var language: String?
    var page: Int? = 1
    var region: String?
}
