//
//  CoreDataStorage.swift
//  CurrencyConverter
//
//  Created by pavel mishanin on 01.09.2022.
//

import Foundation
import CoreData

protocol ICoreDataStorage: AnyObject {
    func getListCurrencies() throws -> [ResponseCurrencyModel]
    func createCurrency(model: RequestCurrencyModel) throws
    func updateCurrency(model: RequestFavoriteCurrencyModel) throws
    func getFavoriteCurrencies() throws -> [ResponseCurrencyModel]
}

final class CoreDataStorage {
    
    private lazy var context: NSManagedObjectContext = persistentContainer.viewContext
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CurrencyConverter")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func getListCurrencies() throws -> [ResponseCurrencyModel] {
        let fetchRequest = CurrencyEntity.fetchRequest()
        let currencies = try self.context.fetch(fetchRequest)
        
        return currencies.compactMap { ResponseCurrencyModel(model: $0) }
    }
    
//    func delete(news: RequestFavoriteCurrencyModel) throws {
//
//        let fetchRequest = CurrencyEntity.fetchRequest()
//        fetchRequest.predicate = NSPredicate(format: "id = %@",
//                                             news.id.description)
//
//        let news = try self.context.fetch(fetchRequest)
//        if let newsForDelete = news.first {
//            context.delete(newsForDelete)
//            self.saveContext()
//        }
//    }
   
    func updateCurrency(model: RequestFavoriteCurrencyModel) throws {
        let fetchRequest = CurrencyEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id = %@",
                                             model.id.description)
        
        let currencies = try self.context.fetch(fetchRequest)
        
        if let currencyForDelete = currencies.first {
            currencyForDelete.setRequestFavoriteModel(from: model)
            self.saveContext()
        }
    }
    
    func createCurrency(model: RequestCurrencyModel) throws {
       
        guard let entity = NSEntityDescription.entity(forEntityName: "CurrencyEntity",
                                                      in: self.context)
        else { return }
        
        let savedCurrencies = try self.getListCurrencies()
        
        if savedCurrencies.contains(where: { $0.name == model.name}) == false {
            let currencyEntity = CurrencyEntity(entity: entity, insertInto: self.context)
            currencyEntity.setRequestModel(from: model)
            
        }
        
        self.saveContext()
    }
    
    func getFavoriteCurrencies() throws -> [ResponseCurrencyModel] {
        let fetchRequest = CurrencyEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "isFavorite = %@",
                                             true as NSNumber)
        
        let favoriteCurrencies = try self.context.fetch(fetchRequest)
        
        return favoriteCurrencies.compactMap { ResponseCurrencyModel(model: $0) }
    }
}

extension CoreDataStorage: ICoreDataStorage {
    
}

private extension CoreDataStorage {
    
    func saveContext () {
        if self.context.hasChanges {
            do {
                try self.context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
