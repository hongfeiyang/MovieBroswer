//
//  OMDB_Query.swift
//  MovieToWatch
//
//  Created by Clark on 17/5/20.
//  Copyright © 2020 Hongfei Yang. All rights reserved.
//

import Foundation

struct OMDB_Query: Codable {
    var apikey = OMDB_KEY
    var i: String
}
