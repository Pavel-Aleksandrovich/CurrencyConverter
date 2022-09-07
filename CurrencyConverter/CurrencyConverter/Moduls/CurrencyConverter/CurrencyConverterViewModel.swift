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
    
    init(model: ResponseCurrencyModel) {
        self.id = model.id
        self.name = model.name
        self.isFavorite = model.isFavorite
        self.charCode = model.charCode
        self.valueRub = model.valueRub
        self.nominal = model.nominal
    }
    
    static func getValueRub(nominalValue: String, valueRub: String) -> String {
        var valueRub = Self.toDoubleFromString(valueRub)
        guard let nominal = Double(nominalValue) else { return "" }
        valueRub /= nominal
        
        return "\(valueRub)"
     }
    
    static func toDoubleFromString(_ string: String) -> Double {
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

