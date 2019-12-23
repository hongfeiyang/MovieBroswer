//
//  ProductionCountryMO+CoreDataClass.swift
//  MovieToWatch
//
//  Created by Clark on 24/12/19.
//  Copyright © 2019 Hongfei Yang. All rights reserved.
//
//

import Foundation
import CoreData

@objc(ProductionCountryMO)
public class ProductionCountryMO: NSManagedObject, Codable {
    enum CodingKeys: String, CodingKey {
        case iso3166_1 = "iso_3166_1"
        case name
    }

    required convenience public init(from decoder: Decoder) throws {
        let managedObjectContext = CoreDataManager.shared.persistentContainer.viewContext

        guard let entity = NSEntityDescription.entity(forEntityName: "ProductionCountry", in: managedObjectContext) else {
            fatalError("failed to create entity")
        }

        self.init(entity: entity, insertInto: managedObjectContext)

        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.iso3166_1 = try values.decode(String.self, forKey: .iso3166_1)
        self.name = try values.decode(String.self, forKey: .name)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(iso3166_1, forKey: .iso3166_1)
        try container.encode(name, forKey: .name)
    }
}
