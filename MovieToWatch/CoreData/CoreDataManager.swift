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
    
    func fetchRecordForEntity(_ entityName: String, _ predicate: NSPredicate?) -> [NSManagedObject] {
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
    
    func readImage(url: String, completion: ((String, UIImage?) -> Void)?) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ImageCache")
        
        let predicate = NSPredicate(format: "url == %@", url)
        fetchRequest.predicate = predicate
        
        do {
            let records = try managedObjectContext.fetch(fetchRequest)
            
            if let records = records as? [NSManagedObject], let imageData = records.first as? ImageCacheMO, let image = UIImage(data: imageData.data!) {

                completion?(url, image)
            } else {
                saveImage(urlString: url, completion: completion)
            }
            
        } catch let error {
            print(error.localizedDescription)
        }
        

    }
    
    func saveImage(urlString: String, completion: ((String, UIImage?) -> Void)?) {
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { print("failed to get image data"); return}
            
            let entity = NSEntityDescription.entity(forEntityName: "ImageCache", in: self.managedObjectContext)
            
            if let entity = entity {
                let object = ImageCacheMO(entity: entity, insertInto: self.managedObjectContext)
                object.data = data
                object.url = urlString
                
                //self.saveContext()
                
                // compress image to prevent low memory warning
                guard let image = UIImage(data: data) else {return}
                let screenWidth = UIScreen.main.bounds.width
                let height = screenWidth * 3/2
                let size = CGSize(width: screenWidth, height: height)
                let newImage = image.resizeImage(targetSize: size)
                completion?(urlString, newImage)
            }
            
            
//
//
//            // compress image to prevent low memory warning
//            let screenWidth = UIScreen.main.bounds.width
//            let height = screenWidth * 3/2
//            let size = CGSize(width: screenWidth, height: height)
//            let newImage = image.resizeImage(targetSize: size)
//
//
//
            
            
        }.resume()
    }
}

