//
//  Network.swift
//  MovieToWatch
//
//  Created by Clark on 20/12/19.
//  Copyright © 2019 Hongfei Yang. All rights reserved.
//

import Foundation


class Network {
    
    enum NetworkError: String, Error {
        case NoDataError = "No Data Error"
    }
    
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
        var components = URLComponents(string: "https://api.themoviedb.org/3/movie/now_playing")
        components?.queryItems = query.URLQueryItems
        guard let url = components?.url else {fatalError("Error parse query items for now playing")}
        URLSession.shared.nowPlayingTask(with: url) {(data, response, error) in
            completion?(data)
        }.resume()
        
    }

    static func getTopRated(query: TopRatedQuery, completion: ((TopRated?) -> Void)?) {
        var components = URLComponents(string: "https://api.themoviedb.org/3/movie/top_rated")
        components?.queryItems = query.URLQueryItems
        guard let url = components?.url else {fatalError("Error parse query items for top rated")}
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
    
    static func getMultiSearch(query: MultiSearchQuery, completion: @escaping (Result<MultiSearchResults, Error>) -> Void) {
        var components = URLComponents(string: "https://api.themoviedb.org/3/search/multi?")
        components?.queryItems = query.URLQueryItems
        guard let url = components?.url else {fatalError("Error parse query items for multi search")}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {completion(.failure(NetworkError.NoDataError)); return}
            let decoder = JSONDecoder()
            do {
                let multiSearchResults = try decoder.decode(MultiSearchResults.self, from: data)
                completion(.success(multiSearchResults))
            } catch let error {
                completion(.failure(error))
            }
        }.resume()
    }
    
    static func getTrending(query: TrendingQuery, completion: @escaping (Result<MultiSearchResults?, Error>)->Void) {
        var components = URLComponents(string: "https://api.themoviedb.org/3/trending/")
        // this query only needs a single 'api_key' query from the query object
        let queryItem = query.URLQueryItems?.first(where: { (item) -> Bool in
            item.name == "api_key"
        })
        components?.queryItems = [queryItem!]
      
        let additionalPath = "\(query.media_type)/\(query.time_window)"
        guard let url = components?.url?.appendingPathComponent(additionalPath) else {fatalError("Error parse query items for trending")}
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            //Interceptor.shared.intercept(data: data)
            guard let data = data else {completion(.failure(NetworkError.NoDataError)); return}
            let decoder = JSONDecoder()
            do {
                let multiSearchResults = try decoder.decode(MultiSearchResults.self, from: data)
                completion(.success(multiSearchResults))
            } catch let error {
                completion(.failure(error))
            }
            
        }.resume()
    }
    
    static func getPersonDetail(query: PersonDetailQuery, completion: @escaping (Result<PersonDetail, Error>) -> Void) {
        var components = URLComponents(string: "https://api.themoviedb.org/3/person/\(query.person_id)")
        components?.queryItems = query.URLQueryItems

        guard let url = components?.url else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {completion(.failure(NetworkError.NoDataError)); return}
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "y-MM-d"
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .custom({ decoder -> Date in
                let dateString = try decoder.singleValueContainer().decode(String.self)
                //let dateKey = decoder.codingPath.last as! PersonDetail.CodingKeys
                return dateFormatter.date(from: dateString) ?? Date.distantPast
            })
            do {
                let results = try decoder.decode(PersonDetail.self, from: data)
                completion(.success(results))
            } catch let error {
                completion(.failure(error))
            }
        }.resume()
    }
    
    static func getOMDBDetail(query: OMDB_Query, completion: @escaping (Result<OMDBResponse, Error>) -> Void) {
        var components = URLComponents(string: "https://www.omdbapi.com/")
        components?.queryItems = query.URLQueryItems
        
        guard let url = components?.url else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            //Interceptor.shared.intercept(data: data)
            guard let data = data else {completion(.failure(NetworkError.NoDataError)); return}
            let decoder = JSONDecoder()
            do {
                let results = try decoder.decode(OMDBResponse.self, from: data)
                completion(.success(results))
            } catch let error {
                completion(.failure(error))
            }
        }.resume()
    }
    
    static func getExternalId(query: ExternalIdQuery, completion: @escaping (Result<ExternalIdResponse, Error>) -> Void) {
        var components = URLComponents(string: "https://api.themoviedb.org/3/movie/\(query.movie_id)/external_ids")
        components?.queryItems = [URLQueryItem(name: "api_key", value: query.api_key)]
        
        guard let url = components?.url else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            //Interceptor.shared.intercept(data: data)
            guard let data = data else {completion(.failure(NetworkError.NoDataError)); return}
            let decoder = JSONDecoder()
            do {
                let results = try decoder.decode(ExternalIdResponse.self, from: data)
                completion(.success(results))
            } catch let error {
                completion(.failure(error))
            }
        }.resume()
    }
}

