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
    
    enum CoreDataError: Error {
        case notFoundError
        case failToSaveError
    }

    private init() {}
    
    var managedObjectContext: NSManagedObjectContext {
        return CoreDataManager.shared.persistentContainer.viewContext
    }
    
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
    
    func fetchRecordForEntity(_ entityName: String, _ predicate: NSPredicate? = nil) -> [NSManagedObject] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.predicate = predicate
        var result = [NSManagedObject]()
        
        do {
            let records = try managedObjectContext.fetch(fetchRequest)
            
            if let records = records as? [NSManagedObject] {
                result = records
            }
        } catch let error {
            print("unable to fetch record for entity: \(entityName), error: \(error.localizedDescription)")
        }
        return result
    }
    
    func createRecordForEntity(_ entityName: String) -> NSManagedObject? {
        
        var result: NSManagedObject?
        
        let entityDescription = NSEntityDescription.entity(forEntityName: entityName, in: managedObjectContext)
        
        if let entityDescription = entityDescription {
            result = NSManagedObject(entity: entityDescription, insertInto: managedObjectContext)
        }
        
        return result
    }
    
    func deleteMovie(id: Int) {
        readMovie(id: id) { (result) in
            switch result {
            case .success(let movie):
                self.managedObjectContext.delete(movie)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        saveContext()
    }
    
    func readMovie(id: Int, completion: ((Result<MovieMO, Error>) -> Void)?) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Movie")
        
        let predicate = NSPredicate(format: "id == %d", id)
        fetchRequest.predicate = predicate
        
        do {
            let records = try managedObjectContext.fetch(fetchRequest)
            
            if let records = records as? [NSManagedObject], let movie = records.first as? MovieMO {
                completion?(.success(movie))
            } else {
                completion?(.failure(CoreDataError.notFoundError))
            }
            
        } catch let error {
            print(error.localizedDescription)
        }
        

    }
    
    func saveMovie(movieDetail: MovieDetail) {
        if let entity = createRecordForEntity("Movie") as? MovieMO {
            entity.id = Int64(movieDetail.id)
            entity.title = movieDetail.title
            entity.releaseDate = movieDetail.releaseDate
            entity.posterPath = movieDetail.posterPath
            self.saveContext()
        } else {
            fatalError("unable to save this Movie entity")
        }
    }
    
}


