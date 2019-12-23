//
//  ProductionCompanyMO+CoreDataProperties.swift
//  MovieToWatch
//
//  Created by Clark on 24/12/19.
//  Copyright © 2019 Hongfei Yang. All rights reserved.
//
//

import Foundation
import CoreData


extension ProductionCompanyMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductionCompanyMO> {
        return NSFetchRequest<ProductionCompanyMO>(entityName: "ProductionCompany")
    }

    @NSManaged public var id: Int64
    @NSManaged public var logoPath: String?
    @NSManaged public var name: String?
    @NSManaged public var originCountry: String?

}
