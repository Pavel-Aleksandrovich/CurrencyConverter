//
//  RequestCurrencyModel.swift
//  CurrencyConverter
//
//  Created by pavel mishanin on 11.09.2022.
//

import Foundation

struct RequestCurrencyModel {
    let id: UUID
    let name: String
    let isFavorite: Bool
    let charCode: String
    let nominal: String
    let valueRub: String
    
    init(model: CurrencyDTO) {
        self.id = UUID()
        self.name = model.name
        self.isFavorite = false
        self.charCode = model.charCode
        self.nominal = model.nominal
        self.valueRub = model.valueRub
    }
}
