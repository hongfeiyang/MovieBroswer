//
//  Network.swift
//  MovieToWatch
//
//  Created by Clark on 20/12/19.
//  Copyright © 2019 Hongfei Yang. All rights reserved.
//

import Foundation


class Network {
    
    static func getMovieSearchResults(query: MovieSearchQuery, completion: ((MovieSearchResults?) -> Void)?) {

        var components = URLComponents(string: query.baseURL)
        components?.queryItems = query.URLQueryItems
        guard let url = components?.url else {return}
        URLSession.shared.movieSearchResultsTask(with: url) {(data, response, error) in
            completion?(data)
        }.resume()
    }
    
    static func getMovieDetail(query: MovieDetailQuery, completion: ((MovieDetail?) -> Void)?) {
        guard let url = URL(string: query.description) else {return}
        URLSession.shared.movieDetailTask(with: url) {(data, response, error) in
            completion?(data)
        }.resume()
    }
    
    static func getDiscoverMovieResults(query: DiscoverMovieQuery, completion: ((DiscoverMovie?) -> Void)?) {
        guard let url = URL(string: query.description) else {return}
        URLSession.shared.discoverMovieTask(with: url) {(data, response, error) in
            completion?(data)
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
    
    
    static func getTopRated(query: TopRatedQuery, completion: ((TopRated) -> Void)?) {
        guard let url = URL(string: query.description) else {return}
        URLSession.shared.topRatedTask(with: url) {(data, response, error) in
            //NSLog("response received")
            guard let data = data else {print("fail to parse TopRated"); return}
            //NSLog("response parsed")
            completion?(data)
            
        }.resume()
        //NSLog("Query send: \(query.description)")
    }
}
