//
//  ListCurrencyViewModel.swift
//  CurrencyConverter
//
//  Created by pavel mishanin on 30.08.2022.
//

import Foundation

struct ListCurrencyViewModel {
    let id: UUID
    let name: String
    let isFavorite: Bool
    let charCode: String
    let nominal: String
    let valueRub: String
    
    init(model: ResponseCurrencyModel) {
        self.id = model.id
        self.name = model.name
        self.isFavorite = model.isFavorite
        self.charCode = model.charCode
        self.nominal = model.nominal
        self.valueRub = model.valueRub
    }
}
