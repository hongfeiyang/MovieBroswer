//
//  PersonDetailQuery.swift
//  MovieToWatch
//
//  Created by Clark on 13/3/20.
//  Copyright © 2020 Hongfei Yang. All rights reserved.
//

import Foundation

struct PersonDetailQuery: Codable {
    let api_key = API_KEY
    var person_id: Int
    var language: String?
    var append_to_response: [PersonResponseAppendix]?
    
    init(person_id: Int, language: String? = nil, append_to_response: [PersonResponseAppendix]? = nil) {
        self.person_id = person_id
        self.language = language
        self.append_to_response = append_to_response
    }
    
    enum PersonResponseAppendix: String, Codable {
        case movie_credits
        case tv_credits
        case combined_credits
        case images
        case tagged_images
        case translations
        case latest
        case popular
    }
    
    var URLQueryItems: [URLQueryItem]? {
        let coder = JSONEncoder()
        do {
            let jsonData = try coder.encode(self)
            let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [.allowFragments])
            guard let dict = jsonObject as? [String: Any?] else { print("cannot convert jsonObject to dictionary"); return nil }
            
            var items = [URLQueryItem]()
            for (key, value) in dict {
                
                if value != nil {
                    if key == "person_id" {
                        continue
                    }
                    
                    if let string = value as? String {
                        items.append(URLQueryItem(name: key, value: string))
                    } else if let val = value as? Bool {
                        items.append(URLQueryItem(name: key, value: String(val)))
                    } else if let val = value as? Int {
                        items.append(URLQueryItem(name: key, value: String(val)))
                    } else if key == "append_to_response", let appendix = value as? [String] {
                        
                        let appendixString = appendix.joined(separator: ",")
                        items.append(URLQueryItem(name: key, value: appendixString))
                    } else {
                        fatalError("Not implemented")
                    }
                }
            }
            return items
        } catch let err {
            print(err)
            return nil
        }
    }
}
