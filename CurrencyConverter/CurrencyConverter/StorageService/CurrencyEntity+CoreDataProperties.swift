//
//  CurrencyEntity+CoreDataProperties.swift
//  CurrencyConverter
//
//  Created by pavel mishanin on 01.09.2022.
//
//

import Foundation
import CoreData


extension CurrencyEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CurrencyEntity> {
        return NSFetchRequest<CurrencyEntity>(entityName: "CurrencyEntity")
    }

    @NSManaged public var id: UUID
    @NSManaged public var name: String
    @NSManaged public var isFavorite: Bool
    @NSManaged public var charCode: String
    @NSManaged public var nominal: String
    @NSManaged public var valueRub: String
}

extension CurrencyEntity : Identifiable {

}

extension CurrencyEntity {
    
    func setRequestModel(from model: RequestCurrencyModel) {
        self.id = model.id
        self.name = model.name
        self.isFavorite = model.isFavorite
        self.charCode = model.charCode
        self.nominal = model.nominal
        self.valueRub = model.valueRub
    }
    
    func setRequestFavoriteModel(from model: RequestFavoriteCurrencyModel) {
        self.isFavorite = model.isFavorite
    }
}

struct RequestFavoriteCurrencyModel {
    let id: UUID
    let name: String
    let isFavorite: Bool
    let charCode: String
    let nominal: String
    let valueRub: String
}

struct RequestCurrencyModel {
    let id: UUID
    let name: String
    let isFavorite: Bool
    let charCode: String
    let nominal: String
    let valueRub: String
    
    init(model: CRBApiModel) {
        self.id = UUID()
        self.name = model.name
        self.isFavorite = false
        self.charCode = model.charCode
        self.nominal = model.nominal
        self.valueRub = model.valueRub
    }
}

struct ResponseCurrencyModel {
    let id: UUID
    let name: String
    let isFavorite: Bool
    let charCode: String
    let nominal: String
    let valueRub: String
    
    init(model: CurrencyEntity) {
        self.id = model.id
        self.name = model.name
        self.isFavorite = model.isFavorite
        self.charCode = model.charCode
        self.nominal = model.nominal
        self.valueRub = model.valueRub
    }
}