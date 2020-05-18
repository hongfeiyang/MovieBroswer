//
//  MovieDetailQuery.swift
//  MovieToWatch
//
//  Created by Clark on 8/1/20.
//  Copyright © 2020 Hongfei Yang. All rights reserved.
//

import Foundation

struct MovieDetailQuery: CustomStringConvertible {

    let baseURL = "https://api.themoviedb.org/3/movie/"
    
    let movieID: Int
    var language: String?
    var append_to_response: String? = "videos,images,reviews,keywords,popular,release_dates,similar_movies,recommendations,lists,credits"
    
    var include_image_language: String? = "en,null"
    
    init(movieID: Int) {
        self.movieID = movieID
    }
    
    init(movieID: Int, language: String) {
        self.movieID = movieID
        self.language = language
    }
    
    init(movieID: Int, language: String, append_to_response: String) {
        self.movieID = movieID
        self.language = language
        self.append_to_response = append_to_response
    }
    
    var description: String {
        var result = baseURL + "\(movieID)" + "?" + "api_key=\(API_KEY)"
        
        if let language = language {
            result += "&language=\(language)"
        }
        
        if let append_to_response = append_to_response {
            result += "&append_to_response=\(append_to_response.replacingOccurrences(of: ",", with: "%2C"))"
        }
        
        if let include_image_language = include_image_language {
            result += "&include_image_language=\(include_image_language.replacingOccurrences(of: ",", with: "%2C"))"
        }
        
        return result
    }
}
