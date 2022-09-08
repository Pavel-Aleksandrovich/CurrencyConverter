//
//  ResponseCurrencyModel.swift
//  CurrencyConverter
//
//  Created by pavel mishanin on 08.09.2022.
//

import Foundation

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
