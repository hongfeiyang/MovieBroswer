//
//  MovieMO+CoreDataClass.swift
//  MovieToWatch
//
//  Created by Clark on 25/12/19.
//  Copyright © 2019 Hongfei Yang. All rights reserved.
//
//

import Foundation
import CoreData

@objc(MovieMO)
public class MovieMO: NSManagedObject {
    convenience init(data: MovieDetail) {
        
        let context = CoreDataManager.shared.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "Movie", in: context) else {
            fatalError("no Movie entity")
        }
        
        self.init(entity: entity, insertInto: context)
        
        
        self.adult = data.adult ?? false
        self.backdropPath = data.backdropPath
        self.budget = Int64(data.budget ?? 0)
        self.homepage = data.homepage
        self.id = Int64(data.id)
        self.imdbID = data.imdbID
        self.originalLanguage = data.originalLanguage
        self.originalTitle = data.originalTitle
        self.overview = data.overview
        self.popularity = data.popularity ?? 0
        self.posterPath = data.posterPath
        self.releaseDate = data.releaseDate
        self.revenue = Int64(data.revenue ?? 0)
        self.runtime = Int16(data.runtime ?? 0)
        self.status = data.status
        self.tagline = data.tagline
        self.title = data.title
        self.video = data.video ?? false
        self.voteAverage = data.voteAverage ?? 0
        self.voteCount = Int64(data.voteCount ?? 0)
        
        if let d = data.belongsToCollection {
            
            let dict: NSDictionary = [
                "id" : d.id,
                "name" : d.name ?? "",
                "posterPath" : d.posterPath ?? "",
                "backdropPath" : d.backdropPath ?? "",
            ]
            
            self.belongsToCollection = dict
        }
        
        if let d = data.genres {
            
            let array = NSMutableArray()
            
            for item in d {
                let dict: NSDictionary = [
                    "id" : item.id,
                    "name" : item.name ?? ""
                ]
                array.add(dict)
            }

            self.genres = array
        }
        
        if let d = data.productionCompanies {
            let array = NSMutableArray()
            
            for item in d {
                let dict: NSDictionary = [
                    "id" : item.id,
                    "name" : item.name ?? "",
                    "logoPath" : item.logoPath ?? "",
                    "originCountry" : item.originCountry ?? ""
                ]
                array.add(dict)
            }

            self.productionCompanies = array
        }
        

//        if let d = data.productionCountries {
//            let array = NSMutableArray()
//            for item in d {
//                let dict: NSDictionary = [
//                    "iso3166_1" : item.iso3166_1 ?? "",
//                    "name" : item.name ?? "",
//                ]
//                array.add(dict)
//            }
//            self.productionCountries = array
//        }
//
        if let d = data.spokenLanguages {
            let array = NSMutableArray()
            for item in d {
                let dict: NSDictionary = [
                    "iso639_1" : item.iso639_1 ?? "",
                    "name" : item.name ?? "",
                ]
                array.add(dict)
            }
            self.spokenLanguages = array
        }
        
    }
}
//
//class BelongsToCollectionObject: NSObject, NSSecureCoding {
//    static var supportsSecureCoding: Bool {
//        return true
//    }
//    
//    
//    var id: Int
//    var name, posterPath, backdropPath: String?
//    
//    enum Keys: String {
//        case id = "id"
//        case name = "name"
//        case posterPath = "posterPath"
//        case backdropPath = "backdropPath"
//    }
//    
//    func encode(with coder: NSCoder) {
////        coder.encode(id, forKey: Keys.id.rawValue)
////        coder.encode(name, forKey: Keys.name.rawValue)
////        coder.encode(posterPath, forKey: Keys.posterPath.rawValue)
////        coder.encode(backdropPath, forKey: Keys.backdropPath.rawValue)
//        
//        coder.encode(name as NSString?, forKey: Keys.name.rawValue)
//        coder.encode(NSNumber(value: id), forKey: Keys.id.rawValue)
//        coder.encode(posterPath as NSString?, forKey: Keys.posterPath.rawValue)
//        coder.encode(backdropPath as NSString?, forKey: Keys.backdropPath.rawValue)
//    }
//    
//    init(id: Int, name: String?, posterPath: String?, backdropPath: String?) {
//        //super.init()
//        self.id = id
//        self.name = name
//        self.posterPath = posterPath
//        self.backdropPath = backdropPath
//    }
//    
//    required convenience init?(coder: NSCoder) {
//
//        let name = coder.decodeObject(of: NSString.self, forKey: Keys.name.rawValue) as String? ?? ""
//        let id = coder.decodeObject(of: NSNumber.self, forKey: Keys.id.rawValue)
//        let posterPath = coder.decodeObject(of: NSString.self, forKey: Keys.posterPath.rawValue) as String? ?? ""
//        let backdropPath = coder.decodeObject(of: NSString.self, forKey: Keys.backdropPath.rawValue) as String? ?? ""
//        
//        self.init(id: id as! Int, name: name, posterPath: posterPath, backdropPath: backdropPath)
//    }
//    
//    
//}
