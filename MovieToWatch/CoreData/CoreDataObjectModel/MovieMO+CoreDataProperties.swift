//
//  MovieMO+CoreDataProperties.swift
//  MovieToWatch
//
//  Created by Clark on 24/12/19.
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
    @NSManaged public var originalLanguage: String?
    @NSManaged public var belongsToCollection: BelongsToCollectionMO?
    @NSManaged public var genres: NSSet?
    @NSManaged public var productionCompanies: NSSet?
    @NSManaged public var productionCountries: NSSet?
    @NSManaged public var spokenLanguages: NSSet?

}

// MARK: Generated accessors for belongsToCollection
extension MovieMO {

    @objc(addBelongsToCollectionObject:)
    @NSManaged public func addToBelongsToCollection(_ value: BelongsToCollectionMO)

    @objc(removeBelongsToCollectionObject:)
    @NSManaged public func removeFromBelongsToCollection(_ value: BelongsToCollectionMO)

    @objc(addBelongsToCollection:)
    @NSManaged public func addToBelongsToCollection(_ values: NSSet)

    @objc(removeBelongsToCollection:)
    @NSManaged public func removeFromBelongsToCollection(_ values: NSSet)

}

// MARK: Generated accessors for genres
extension MovieMO {

    @objc(addGenresObject:)
    @NSManaged public func addToGenres(_ value: GenreMO)

    @objc(removeGenresObject:)
    @NSManaged public func removeFromGenres(_ value: GenreMO)

    @objc(addGenres:)
    @NSManaged public func addToGenres(_ values: NSSet)

    @objc(removeGenres:)
    @NSManaged public func removeFromGenres(_ values: NSSet)

}

// MARK: Generated accessors for productionCompanies
extension MovieMO {

    @objc(addProductionCompaniesObject:)
    @NSManaged public func addToProductionCompanies(_ value: ProductionCompanyMO)

    @objc(removeProductionCompaniesObject:)
    @NSManaged public func removeFromProductionCompanies(_ value: ProductionCompanyMO)

    @objc(addProductionCompanies:)
    @NSManaged public func addToProductionCompanies(_ values: NSSet)

    @objc(removeProductionCompanies:)
    @NSManaged public func removeFromProductionCompanies(_ values: NSSet)

}

// MARK: Generated accessors for productionCountries
extension MovieMO {

    @objc(addProductionCountriesObject:)
    @NSManaged public func addToProductionCountries(_ value: ProductionCountryMO)

    @objc(removeProductionCountriesObject:)
    @NSManaged public func removeFromProductionCountries(_ value: ProductionCountryMO)

    @objc(addProductionCountries:)
    @NSManaged public func addToProductionCountries(_ values: NSSet)

    @objc(removeProductionCountries:)
    @NSManaged public func removeFromProductionCountries(_ values: NSSet)

}

// MARK: Generated accessors for spokenLanguages
extension MovieMO {

    @objc(addSpokenLanguagesObject:)
    @NSManaged public func addToSpokenLanguages(_ value: SpokenLanguageMO)

    @objc(removeSpokenLanguagesObject:)
    @NSManaged public func removeFromSpokenLanguages(_ value: SpokenLanguageMO)

    @objc(addSpokenLanguages:)
    @NSManaged public func addToSpokenLanguages(_ values: NSSet)

    @objc(removeSpokenLanguages:)
    @NSManaged public func removeFromSpokenLanguages(_ values: NSSet)

}
