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
    
    init(model: ResponseCurrencyModel) {
        self.id = model.id
        self.name = model.name
        self.isFavorite = model.isFavorite
        self.charCode = model.charCode
        self.valueRub = Self.getValueRub(nominalValue: model.nominal, valueRub: model.valueRub)
    }
    
    static func getNominal(nominalValue: String) -> String {
        guard var value = Double(nominalValue) else { return "" }
        
        value /= value
        
        return "\(value)"
     }
    
    static func getValueRub(nominalValue: String, valueRub: String) -> String {
        var valueRub = Self.dsds(string: valueRub)
        guard let nominal = Double(nominalValue) else { return "" }
        valueRub /= nominal
        
        return "\(valueRub)"
     }
    
    static func dsds(string: String) -> Double {
        let numberFormatter = NumberFormatter()
        
        numberFormatter.decimalSeparator = "."
        if let result = numberFormatter.number(from: string) {
            return result.doubleValue
        } else {
            numberFormatter.decimalSeparator = ","
            if let result = numberFormatter.number(from: string) {
                return result.doubleValue
            }
        }
        return 0
    }
}

