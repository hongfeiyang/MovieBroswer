//
//  ProductionCompanyMO+CoreDataClass.swift
//  MovieToWatch
//
//  Created by Clark on 24/12/19.
//  Copyright © 2019 Hongfei Yang. All rights reserved.
//
//

import Foundation
import CoreData

@objc(ProductionCompanyMO)
public class ProductionCompanyMO: NSManagedObject, Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }


    required convenience public init(from decoder: Decoder) throws {
        let managedObjectContext = CoreDataManager.shared.persistentContainer.viewContext

        guard let entity = NSEntityDescription.entity(forEntityName: "ProductionCompany", in: managedObjectContext) else {
            fatalError("failed to create entity")
        }

        self.init(entity: entity, insertInto: managedObjectContext)

        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(Int64.self, forKey: .id)
        self.logoPath = try values.decode(String?.self, forKey: .logoPath)
        self.originCountry = try values.decode(String.self, forKey: .originCountry)
        self.name = try values.decode(String.self, forKey: .name)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(originCountry, forKey: .originCountry)
        try container.encode(name, forKey: .name)
        try container.encode(id, forKey: .id)
        try container.encode(logoPath, forKey: .logoPath)
    }
}
