//
//  BelongsToCollectionMO+CoreDataProperties.swift
//  MovieToWatch
//
//  Created by Clark on 24/12/19.
//  Copyright © 2019 Hongfei Yang. All rights reserved.
//
//

import Foundation
import CoreData


extension BelongsToCollectionMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BelongsToCollectionMO> {
        return NSFetchRequest<BelongsToCollectionMO>(entityName: "BelongsToCollection")
    }

    @NSManaged public var backdropPath: String?
    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var posterPath: String?

}
