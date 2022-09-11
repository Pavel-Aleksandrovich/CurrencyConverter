//
//  CurrencyConverterViewModel.swift
//  CurrencyConverter
//
//  Created by pavel mishanin on 05.09.2022.
//

import Foundation

struct CurrencyConverterViewModel {
    let id: UUID
    let name: String
    let isFavorite: Bool
    let charCode: String
    let valueRub: String
    let nominal: String
    
    init() {
        self.id = UUID()
        self.name = String()
        self.isFavorite = Bool()
        self.charCode = "FLAG"
        self.valueRub = String()
        self.nominal = String()
    }
    
    init(model: ListCurrencyViewModel) {
        self.id = model.id
        self.name = model.name
        self.isFavorite = model.isFavorite
        self.charCode = model.charCode
        self.valueRub = model.valueRub
        self.nominal = model.nominal
    }
}
