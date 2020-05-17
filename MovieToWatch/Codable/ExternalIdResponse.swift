//
//  ExternalIdResponse.swift
//  MovieToWatch
//
//  Created by Clark on 17/5/20.
//  Copyright © 2020 Hongfei Yang. All rights reserved.
//

import Foundation

struct ExternalIdResponse: Codable {
    let id: Int
    let imdbID: String?
    let facebookID, instagramID, twitterID: String?

    enum CodingKeys: String, CodingKey {
        case id
        case imdbID = "imdb_id"
        case facebookID = "facebook_id"
        case instagramID = "instagram_id"
        case twitterID = "twitter_id"
    }
}
