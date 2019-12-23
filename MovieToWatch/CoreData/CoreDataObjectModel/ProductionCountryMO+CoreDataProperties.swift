//
//  ProductionCountryMO+CoreDataProperties.swift
//  MovieToWatch
//
//  Created by Clark on 24/12/19.
//  Copyright © 2019 Hongfei Yang. All rights reserved.
//
//

import Foundation
import CoreData


extension ProductionCountryMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductionCountryMO> {
        return NSFetchRequest<ProductionCountryMO>(entityName: "ProductionCountry")
    }

    @NSManaged public var iso3166_1: String?
    @NSManaged public var name: String?

}
