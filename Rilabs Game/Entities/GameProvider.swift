//
//  GameProvider.swift
//  Rilabs Game
//
//  Created by Ari Supriatna on 11/07/20.
//  Copyright © 2020 Ari Supriatna. All rights reserved.
//

import CoreData
import SwiftUI

class GameProvider {
  var viewContext: NSManagedObjectContext { persistentContainer.viewContext }
  
  private lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "RilabsGame")
    
    container.loadPersistentStores { (_, error) in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    }
    
    return container
  }()
  
  private func newTaskContext() -> NSManagedObjectContext {
    let taskContext = persistentContainer.viewContext
    taskContext.undoManager = nil
    
    taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    return taskContext
  }
  
  func addToFavorite(_ data: Game, completion: @escaping() -> ()) {
    let taskContext = newTaskContext()
    taskContext.performAndWait {
      if let entity = NSEntityDescription.entity(forEntityName: "Favorite", in: taskContext) {
        let favorite = NSManagedObject(entity: entity, insertInto: taskContext)
        favorite.setValue(Int32(data.id), forKey: "id")
        favorite.setValue(data.name, forKey: "name")
        favorite.setValue(data.released, forKey: "released")
        favorite.setValue(data.backgroundImage, forKey: "backgroundImage")
        
        do {
          try taskContext.save()
          completion()
        } catch let error as NSError {
          print("Could not save. \(error), \(error.userInfo)")
        }
      }
    }
  }
  
  func getAllFavorite(completion: @escaping(_ favorites: [Game]) -> ()) {
    let context = newTaskContext()
    context.perform {
      let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorite")
      
      do {
        let results = try context.fetch(fetchRequest)
        var favorites: [Game] = []
        
        for result in results {
          let gameFavorite = Game(
            id: result.value(forKeyPath: "id") as! Int,
            name: result.value(forKeyPath: "name") as! String,
            released: result.value(forKeyPath: "released") as? String,
            backgroundImage: result.value(forKeyPath: "backgroundImage") as? String
          )
          favorites.append(gameFavorite)
        }
        completion(favorites)
      } catch let error as NSError {
        print("Could not fetch. \(error), \(error.userInfo)")
      }
    }
  }
  
  func getFavoriteById(_ id: Int, completion: @escaping(_ favorite: Game) -> ()) {
    let taskContext = newTaskContext()
    taskContext.perform {
      let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorite")
      fetchRequest.fetchLimit = 1
      fetchRequest.predicate = NSPredicate(format: "id == \(Int32(id))")
      
      do {
        if let result = try taskContext.fetch(fetchRequest).first {
          let favorite = Game(
            id: result.value(forKeyPath: "id") as! Int,
            name: result.value(forKeyPath: "name") as! String,
            released: result.value(forKeyPath: "released") as? String,
            backgroundImage: result.value(forKeyPath: "backgroundImage") as? String
          )
          completion(favorite)
        }
      } catch let error as NSError {
        print("Could not fetch. \(error), \(error.userInfo)")
      }
    }
  }
  
  func deleteFavorite(_ id: Int, completion: @escaping() -> ()) {
    let taskContext = newTaskContext()
    taskContext.performAndWait {
      let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorite")
      fetchRequest.fetchLimit = 1
      fetchRequest.predicate = NSPredicate(format: "id == \(Int32(id))")
      let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
      batchDeleteRequest.resultType = .resultTypeCount
      if let batchDeleteResult = try? taskContext.execute(batchDeleteRequest) as? NSBatchDeleteResult, batchDeleteResult.result != nil {
        completion()
      }
    }
  }
}
