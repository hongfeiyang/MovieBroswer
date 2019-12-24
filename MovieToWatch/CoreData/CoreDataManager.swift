//
//  CoreDataManager.swift
//  MovieToWatch
//
//  Created by Clark on 23/12/19.
//  Copyright © 2019 Hongfei Yang. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    static var shared = CoreDataManager()
    
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "DataModel")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        return container
    }()
    
    func saveContext(backgroundContext: NSManagedObjectContext? = nil) {
        let context = backgroundContext ?? CoreDataManager.shared.persistentContainer.viewContext
        context.mergePolicy = NSOverwriteMergePolicy
        guard context.hasChanges else { return }
        do {
            try context.save()
        } catch let error as NSError {
            print("Error: \(error), \(error.userInfo)")
        }
    }
}

