//
//  CoreDataStorage.swift
//  CurrencyConverter
//
//  Created by pavel mishanin on 01.09.2022.
//

import Foundation
import CoreData

protocol ICoreDataStorage: AnyObject {
    func getAllCurrencies() throws -> [ResponseCurrencyModel]
    func getFavoriteCurrencies() throws -> [ResponseCurrencyModel]
    func createCurrency(model: RequestCurrencyModel)
    func getCurrencyById(_ id: UUID) throws -> CurrencyEntity?
    func updateCurrency(model: CurrencyEntity,
                        newModel: RequestFavoriteCurrencyModel)
}

final class CoreDataStorage {
    
    private lazy var context: NSManagedObjectContext = self.persistentContainer.viewContext
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CurrencyConverter")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
}

extension CoreDataStorage: ICoreDataStorage {
    
    func updateCurrency(model: CurrencyEntity,
                        newModel: RequestFavoriteCurrencyModel) {
        model.setRequestFavoriteModel(from: newModel)
        self.saveContext()
    }
    
    func getCurrencyById(_ id: UUID) throws -> CurrencyEntity? {
        let fetchRequest = CurrencyEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id = %@",
                                             id.description)
        
        return try self.context.fetch(fetchRequest).first
    }
    
    func getAllCurrencies() throws -> [ResponseCurrencyModel] {
        let fetchRequest = CurrencyEntity.fetchRequest()
        let currencies = try self.context.fetch(fetchRequest)
        
        return currencies.compactMap { ResponseCurrencyModel(model: $0) }
    }
    
    func createCurrency(model: RequestCurrencyModel) {
        guard let entity = NSEntityDescription.entity(forEntityName: "CurrencyEntity",
                                                      in: self.context)
        else { return }
        
        let currencyEntity = CurrencyEntity(entity: entity, insertInto: self.context)
        currencyEntity.setRequestModel(from: model)
        
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
