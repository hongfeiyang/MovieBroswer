//
//  BelongsToCollectionMO+CoreDataClass.swift
//  MovieToWatch
//
//  Created by Clark on 24/12/19.
//  Copyright © 2019 Hongfei Yang. All rights reserved.
//
//

import Foundation
import CoreData

@objc(BelongsToCollectionMO)
public class BelongsToCollectionMO: NSManagedObject, Codable {
    enum CodingKeys: String, CodingKey {
        case id, name
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }

    required convenience public init(from decoder: Decoder) throws {
        
        let managedObjectContext = CoreDataManager.shared.persistentContainer.viewContext

        guard let entity = NSEntityDescription.entity(forEntityName: "BelongsToCollection", in: managedObjectContext) else {
            fatalError("failed to create entity")
        }

        self.init(entity: entity, insertInto: managedObjectContext)

        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(Int64.self, forKey: .id)
        self.name = try values.decode(String.self, forKey: .name)
        self.posterPath = try values.decode(String.self, forKey: .posterPath)
        self.backdropPath = try values.decode(String.self, forKey: .backdropPath)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(id, forKey: .id)
        try container.encode(posterPath, forKey: .posterPath)
        try container.encode(backdropPath, forKey: .backdropPath)
    }
}
