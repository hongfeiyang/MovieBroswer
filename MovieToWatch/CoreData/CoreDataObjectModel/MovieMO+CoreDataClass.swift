//
//  MovieMO+CoreDataClass.swift
//  MovieToWatch
//
//  Created by Clark on 24/12/19.
//  Copyright © 2019 Hongfei Yang. All rights reserved.
//
//

import Foundation
import CoreData

@objc(MovieMO)
public class MovieMO: NSManagedObject, Codable {
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case belongsToCollection = "belongs_to_collection"
        case budget, genres, homepage, id
        case imdbID = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case revenue, runtime
        case spokenLanguages = "spoken_languages"
        case status, tagline, title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }

    required convenience public init(from decoder: Decoder) throws {

        let managedObjectContext = CoreDataManager.shared.persistentContainer.viewContext

        guard let entity = NSEntityDescription.entity(forEntityName: "Movie", in: managedObjectContext) else {
            fatalError("failed to create entity")
        }

        self.init(entity: entity, insertInto: managedObjectContext)

        let values = try decoder.container(keyedBy: CodingKeys.self)
        adult = try values.decode(Bool.self, forKey: .adult)
        backdropPath = try values.decode(String?.self, forKey: .backdropPath)
        belongsToCollection = try values.decode(BelongsToCollectionMO?.self, forKey: .belongsToCollection)
        budget = try values.decode(Int64.self, forKey: .budget)
        genres = NSSet(array: try values.decode([GenreMO].self, forKey: .genres))
        homepage = try values.decode(String?.self, forKey: .homepage)
        id = try values.decode(Int64.self, forKey: .id)
        imdbID = try values.decode(String?.self, forKey: .imdbID)
        originalLanguage = try values.decode(String.self, forKey: .originalLanguage)
        originalTitle = try values.decode(String.self, forKey: .originalTitle)
        overview = try values.decode(String?.self, forKey: .overview)
        popularity = try values.decode(Double.self, forKey: .popularity)
        posterPath = try values.decode(String?.self, forKey: .posterPath)
        productionCompanies = NSSet(array: try values.decode([ProductionCompanyMO].self, forKey: .productionCompanies))
        productionCountries = NSSet(array: try values.decode([ProductionCountryMO].self, forKey: .productionCountries))
        releaseDate = try values.decode(Date.self, forKey: .releaseDate)
        revenue = try values.decode(Int64.self, forKey: .revenue)
        runtime = try (values.decode(Int16?.self, forKey: .runtime) ?? 0)
        spokenLanguages = NSSet(array: try values.decode([SpokenLanguageMO].self, forKey: .spokenLanguages))
        status = try values.decode(String.self, forKey: .status)
        tagline = try values.decode(String?.self, forKey: .tagline)
        title = try values.decode(String.self, forKey: .title)
        video = try values.decode(Bool.self, forKey: .video)
        voteAverage = try values.decode(Double.self, forKey: .voteAverage)
        voteCount = try values.decode(Int64.self, forKey: .voteCount)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(adult, forKey: .adult)
        try container.encode(backdropPath, forKey: .backdropPath)
        //try container.encode(belongsToCollection, forKey: .belongsToCollection)
        try container.encode(budget, forKey: .budget)
        //try container.encode(genres, forKey: .genres)
        try container.encode(homepage, forKey: .homepage)
        try container.encode(id, forKey: .id)
        try container.encode(imdbID, forKey: .imdbID)
        try container.encode(originalLanguage, forKey: .originalLanguage)
        try container.encode(originalTitle, forKey: .originalTitle)
        try container.encode(overview, forKey: .overview)
        try container.encode(popularity, forKey: .popularity)
        try container.encode(posterPath, forKey: .posterPath)
        //try container.encode(productionCompanies, forKey: .productionCompanies)
        //try container.encode(productionCountries, forKey: .productionCountries)
        try container.encode(releaseDate, forKey: .releaseDate)
        try container.encode(revenue, forKey: .revenue)
        try container.encode(runtime, forKey: .runtime)
        //try container.encode(spokenLanguages, forKey: .spokenLanguages)
        try container.encode(status, forKey: .status)
        try container.encode(tagline, forKey: .tagline)
        try container.encode(title, forKey: .title)
        try container.encode(video, forKey: .video)
        try container.encode(voteAverage, forKey: .voteAverage)
        try container.encode(voteCount, forKey: .voteCount)
    }
}
