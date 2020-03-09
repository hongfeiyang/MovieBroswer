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
    }
    
    static func getNowPlaying(query: NowPlayingQuery, completion: ((NowPlaying?) -> Void)?) {
        guard let url = URL(string: query.description) else {return}
        URLSession.shared.nowPlayingTask(with: url) {(data, response, error) in
            completion?(data)
        }.resume()
        
    }

    static func getTopRated(query: TopRatedQuery, completion: ((TopRated?) -> Void)?) {
        guard let url = URL(string: query.description) else {return}
        URLSession.shared.topRatedTask(with: url) {(data, response, error) in
            completion?(data)
        }.resume()
    }
    
    static func getUpcoming(query: UpcomingQuery, completion: ((Upcoming?) -> Void)? ) {
        var components = URLComponents(string: "https://api.themoviedb.org/3/movie/upcoming")
        components?.queryItems = query.URLQueryItems
        guard let url = components?.url else {fatalError("Error parse query items for upcoming")}
        URLSession.shared.upcomingTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                completion?(nil)
                return
            }
            completion?(data)
        }.resume()
    }
    
    static func getPopular(query: PopularQuery, completion: ((Popular?) -> Void)? ) {
        var components = URLComponents(string: "https://api.themoviedb.org/3/movie/popular")
        components?.queryItems = query.URLQueryItems
        guard let url = components?.url else {fatalError("Error parse query items for popular")}
        URLSession.shared.popularTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                completion?(nil)
                return
            }
            completion?(data)
        }.resume()
    }
    
    static func getMultiSearch(query: MultiSearchQuery, completion: ((MultiSearchResults?) -> Void)?) {
        var components = URLComponents(string: "https://api.themoviedb.org/3/search/multi?")
        components?.queryItems = query.URLQueryItems
        guard let url = components?.url else {fatalError("Error parse query items for multi search")}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error)
                completion?(nil)
                return
            }
            guard let data = data else {print("no data"); return}
            
            let decoder = JSONDecoder()
            do {
//                let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
//                let jsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
//                let string = String(data: jsonData, encoding: .utf8)!
//                print(string)
                
                let multiSearchResults = try decoder.decode(MultiSearchResults.self, from: data)
                completion?(multiSearchResults)
            } catch let error {
                print("MULTISEARCH", error)
                completion?(nil)
            }
            
        }.resume()
    }
}
