//
//  RequestFavoriteCurrencyModel.swift
//  CurrencyConverter
//
//  Created by pavel mishanin on 07.09.2022.
//

import Foundation

struct RequestFavoriteCurrencyModel {
    let id: UUID
    let name: String
    let isFavorite: Bool
    let charCode: String
    let nominal: String
    let valueRub: String
    
    init(model: ListCurrencyViewModel) {
        self.id = model.id
        self.name = model.name
        self.isFavorite = !model.isFavorite
        self.charCode = model.charCode
        self.nominal = model.nominal
        self.valueRub = model.valueRub
    }
}
