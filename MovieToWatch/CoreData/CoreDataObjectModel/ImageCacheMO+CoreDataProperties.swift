//
//  ImageCacheMO+CoreDataProperties.swift
//  MovieToWatch
//
//  Created by Clark on 25/12/19.
//  Copyright © 2019 Hongfei Yang. All rights reserved.
//
//

import Foundation
import CoreData


extension ImageCacheMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ImageCacheMO> {
        return NSFetchRequest<ImageCacheMO>(entityName: "ImageCache")
    }

    @NSManaged public var data: Data?
    @NSManaged public var url: String?

}
