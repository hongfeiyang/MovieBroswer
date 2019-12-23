//
//  GenreMO+CoreDataProperties.swift
//  MovieToWatch
//
//  Created by Clark on 24/12/19.
//  Copyright © 2019 Hongfei Yang. All rights reserved.
//
//

import Foundation
import CoreData


extension GenreMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GenreMO> {
        return NSFetchRequest<GenreMO>(entityName: "Genre")
    }

    @NSManaged public var id: Int64
    @NSManaged public var name: String?

}
