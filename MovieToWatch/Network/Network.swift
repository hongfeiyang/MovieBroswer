//
//  Network.swift
//  MovieToWatch
//
//  Created by Clark on 20/12/19.
//  Copyright © 2019 Hongfei Yang. All rights reserved.
//

import Foundation


class Network {
    
    static func getMovieSearchResults(query: MovieSearchQuery, completion: ((MovieSearchResults) -> Void)?) {
        guard let url = URL(string: query.description) else {return}
        URLSession.shared.movieSearchResultsTask(with: url) {(data, response, error) in
            guard let movieSearchResults = data else {print("movieSearchResultsTask returned nil"); return}
            completion?(movieSearchResults)
        }.resume()
    }
    
    static func getMovieDetail(query: MovieDetailQuery, completion: ((MovieDetail) -> Void)?) {
        guard let url = URL(string: query.description) else {return}
        URLSession.shared.movieDetailTask(with: url) {(data, response, error) in
            //NSLog("response received")
            guard let movieDetail = data else {print("movieDetailTask returned nil"); return}
            //NSLog("response parsed")
            completion?(movieDetail)
            
        }.resume()
    }
    
    static func getDiscoverMovieResults(query: DiscoverMovieQuery, completion: (([DiscoverMovieResult]) -> Void)?) {
        guard let url = URL(string: query.description) else {return}
        URLSession.shared.discoverMovieTask(with: url) {(data, response, error) in
            //NSLog("response received")
            guard let data = data else {print("fail to parse DiscoverMovie"); return}
            //NSLog("response parsed")
            completion?(data.results)

        }.resume()
        //NSLog("Query send: \(query.description)")
    }
    
    static func getNowPlaying(query: NowPlayingQuery, completion: ((NowPlaying) -> Void)?) {
        guard let url = URL(string: query.description) else {return}
        URLSession.shared.nowPlayingTask(with: url) {(data, response, error) in
            //NSLog("response received")
            guard let data = data else {print("fail to parse NowPlaying"); return}
            //NSLog("response parsed")
            completion?(data)
            
        }.resume()
        //NSLog("Query send: \(query.description)")
    }
}
