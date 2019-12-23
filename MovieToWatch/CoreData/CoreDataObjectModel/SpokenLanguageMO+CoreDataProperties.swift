//
//  SpokenLanguageMO+CoreDataProperties.swift
//  MovieToWatch
//
//  Created by Clark on 24/12/19.
//  Copyright © 2019 Hongfei Yang. All rights reserved.
//
//

import Foundation
import CoreData


extension SpokenLanguageMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SpokenLanguageMO> {
        return NSFetchRequest<SpokenLanguageMO>(entityName: "SpokenLanguage")
    }

    @NSManaged public var iso639_1: String?
    @NSManaged public var name: String?

}
