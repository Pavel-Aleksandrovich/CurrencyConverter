//
//  Formatter.swift
//  CurrencyConverter
//
//  Created by pavel mishanin on 08.09.2022.
//

import Foundation

final class Formatter: NumberFormatter {
    
    override init() {
        super.init()
        self.numberStyle = .currency
        self.currencySymbol = ""
        self.currencyDecimalSeparator = ","
        self.currencyGroupingSeparator = " "
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func string(from number: Double) -> String {
        if let result = self.string(from: NSNumber(value: number)) {
            return result
        }
        
        return ""
    }
    
    func number(_ string: String) -> Double {
        if let result = self.number(from: string) {
            return result.doubleValue
        }
        
        return 0
    }
}
