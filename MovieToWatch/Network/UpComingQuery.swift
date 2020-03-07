//
//  UpComingQuery.swift
//  MovieToWatch
//
//  Created by Clark on 7/3/20.
//  Copyright © 2020 Hongfei Yang. All rights reserved.
//

import Foundation

struct UpcomingQuery: Codable {
    var api_key = API_KEY
    var language: String?
    var page: Int?
    var region: String?
}
