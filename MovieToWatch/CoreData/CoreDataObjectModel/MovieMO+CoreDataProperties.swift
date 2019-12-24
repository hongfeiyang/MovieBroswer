//
//  MovieMO+CoreDataProperties.swift
//  MovieToWatch
//
//  Created by Clark on 25/12/19.
//  Copyright © 2019 Hongfei Yang. All rights reserved.
//
//

import Foundation
import CoreData


extension MovieMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieMO> {
        return NSFetchRequest<MovieMO>(entityName: "Movie")
    }

    @NSManaged public var adult: Bool
    @NSManaged public var backdropPath: String?
    @NSManaged public var budget: Int64
    @NSManaged public var homepage: String?
    @NSManaged public var id: Int64
    @NSManaged public var imdbID: String?
    @NSManaged public var originalLanguage: String?
    @NSManaged public var originalTitle: String?
    @NSManaged public var overview: String?
    @NSManaged public var popularity: Double
    @NSManaged public var posterPath: String?
    @NSManaged public var releaseDate: Date?
    @NSManaged public var revenue: Int64
    @NSManaged public var runtime: Int16
    @NSManaged public var status: String?
    @NSManaged public var tagline: String?
    @NSManaged public var title: String?
    @NSManaged public var video: Bool
    @NSManaged public var voteAverage: Double
    @NSManaged public var voteCount: Int64
    @NSManaged public var belongsToCollection: NSObject?
    @NSManaged public var genres: NSObject?
    @NSManaged public var productionCompanies: NSObject?
    @NSManaged public var productionCountries: NSObject?
    @NSManaged public var spokenLanguages: NSObject?

}
