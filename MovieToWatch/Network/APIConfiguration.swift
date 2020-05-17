//
//  File.swift
//  MovieToWatch
//
//  Created by Clark on 16/12/19.
//  Copyright © 2019 Hongfei Yang. All rights reserved.
//

import Foundation

let API_KEY = "8bb40fd6bdda6cfcc5397a96da82609d"
let OMDB_KEY = "85c26d5f"


struct APIConfiguration {
    
    struct Images {
        
        static let base_url = "http://image.tmdb.org/t/p/"
        static let secure_base_url = "https://image.tmdb.org/t/p/"
        
        enum Backdrop_sizes: String {
            case w300 = "w300"
            case w780 = "w780"
            case w1280 = "w1280"
            case original = "original"
        }
        
        enum Logo_sizes: String {
            case w45 = "w45"
            case w92 = "w92"
            case w154 = "w154"
            case w185 = "w185"
            case w300 = "w300"
            case w500 = "w500"
            case original = "original"
        }
        
        enum Poster_sizes: String {
            case w92 = "w92"
            case w154 = "w154"
            case w185 = "w185"
            case w342 = "w342"
            case w500 = "w500"
            case w780 = "w780"
            case original = "original"
        }
        
        enum Profile_sizes: String {
            case w45 = "w45"
            case w185 = "w185"
            case h632 = "h632"
            case original = "original"
        }
        
        enum Still_sizes: String {
            case w92 = "w92"
            case w185 = "w185"
            case w300 = "w300"
            case original = "original"
        }
    }
    
    static func parsePosterURL(file_path: String?, size: APIConfiguration.Images.Poster_sizes) -> URL? {
        if let file_path = file_path {
            return URL(string: "\(APIConfiguration.Images.secure_base_url)\(size.rawValue)\(file_path)")
        }
        return nil
    }
}
