//
//  Favorites.swift
//  Book Shop
//
//  Created by Momeks on 12/24/21.
//

import UIKit
import CoreData

class CoreDataService  {
    
    static let shared = CoreDataService()
 
    //Save
    func addToBookmark(book: Book) {
        
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let newEntity = NSEntityDescription.entity (forEntityName: "Entity", in: managedContext)!
        let favorites = NSManagedObject (entity: newEntity, insertInto: managedContext)
        favorites.setValue(book.id, forKey: "id")
        favorites.setValue(book.coverURL, forKey: "coverURL")
        
        do {
            try managedContext.save ()
            print("saving successful")
        
        } catch let error as NSError {
            print ("Could not save. \(error)")
        }
    }
    
    
    //Load
    func loadFavoriteData() -> [NSManagedObject] {
     
        var objects: [NSManagedObject] = []
        
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Entity")
          
          do {
              objects = try managedContext.fetch(fetchRequest)
          } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
          }
        return objects
    }
    
    
    //Delete
    func deleteBookWith(id:Int) {
        
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Entity")
        fetchRequest.predicate = NSPredicate.init(format: "id==\(id)")

        do {
            let objects = try managedContext.fetch(fetchRequest)
            for object in objects {
                managedContext.delete(object)
            }
            try managedContext.save()
        } catch let error as NSError {
            print ("Could not delete. \(error)")
        }
    }
    
    
    
    //Checks if user saved a book
    func bookmarkContainsBook(id:Int) -> Bool {
        
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Entity")
        fetchRequest.predicate = NSPredicate.init(format: "id==\(id)")

        do {
               let count = try managedContext.count(for: fetchRequest)
               if count > 0 {
                   return true
               }else {
                   return false
               }
           } catch let error as NSError {
               print("Could not fetch. \(error), \(error.userInfo)")
               return false
           }
    }
    
    
}


