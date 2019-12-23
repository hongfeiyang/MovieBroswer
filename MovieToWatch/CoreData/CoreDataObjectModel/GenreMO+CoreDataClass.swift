//
//  GenreMO+CoreDataClass.swift
//  MovieToWatch
//
//  Created by Clark on 24/12/19.
//  Copyright © 2019 Hongfei Yang. All rights reserved.
//
//

import Foundation
import CoreData

@objc(GenreMO)
public class GenreMO: NSManagedObject, Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }

    required convenience public init(from decoder: Decoder) throws {
        
        let managedObjectContext = CoreDataManager.shared.persistentContainer.viewContext

        guard let entity = NSEntityDescription.entity(forEntityName: "Genre", in: managedObjectContext) else {
            fatalError("failed to create entity")
        }

        self.init(entity: entity, insertInto: managedObjectContext)

        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(Int64.self, forKey: .id)
        self.name = try values.decode(String.self, forKey: .name)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(id, forKey: .id)
    }
}
