//
//  getExternalIdQuery.swift
//  MovieToWatch
//
//  Created by Clark on 17/5/20.
//  Copyright © 2020 Hongfei Yang. All rights reserved.
//

import Foundation

struct ExternalIdQuery: Codable{
    var api_key = API_KEY
    var movie_id: Int
}
