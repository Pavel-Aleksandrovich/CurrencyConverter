//
//  CurrencyConverter.swift
//  CurrencyConverter
//
//  Created by pavel mishanin on 07.09.2022.
//

import Foundation

protocol ICurrencyConverter: AnyObject {
    func setCurrencyModel(_ model: ResponseCurrencyModel)
    func getCurrencyValueByIndex(_ index: Int) -> String
    func getCurrencyModelByIndex(_ index: Int) -> CurrencyConverterViewModel?
    func onCalculatorCellTappedByIndex(_ index: Int)
    func setIndex(_ index: Int)
    func setTableIndex(_ index: Int)
}

final class CurrencyConverter {
    
    private let formatter = NumberFormatter()
    
    private var firstCurrencyModel: CurrencyConverterViewModel?
    private var secondCurrencyModel: CurrencyConverterViewModel?
    
    private var firstCurrencyEnteredValue = String()
    private var secondCurrencyEnteredValue = String()
    
    private var index = Int()
    private var didSelectCellAtIndex = Int()
    
    init() {
        self.configNumberFormatter()
    }
}

extension CurrencyConverter: ICurrencyConverter {
    
    func getCurrencyModelByIndex(_ index: Int) -> CurrencyConverterViewModel? {
        switch CurrencyType.allCases[index] {
        case .first:
            return self.firstCurrencyModel
        case .second:
            return self.secondCurrencyModel
        }
    }
    
    func getCurrencyValueByIndex(_ index: Int) -> String {
        switch CurrencyType.allCases[index] {
        case .first:
            return self.firstCurrencyEnteredValue
        case .second:
            return self.secondCurrencyEnteredValue
        }
    }
    
    func setIndex(_ index: Int) {
        self.index = index
    }
    
    func setTableIndex(_ index: Int) {
        self.didSelectCellAtIndex = index
    }
    
    func setCurrencyModel(_ model: ResponseCurrencyModel) {
        switch CurrencyType.allCases[self.index] {
        case .first:
            self.firstCurrencyModel = CurrencyConverterViewModel(model: model)
        case .second:
            self.secondCurrencyModel = CurrencyConverterViewModel(model: model)
        }
    }
    
    func onCalculatorCellTappedByIndex(_ index: Int) {
        let type = CalculatorButtons.allCases[index]
        
        switch CurrencyType.allCases[self.didSelectCellAtIndex] {
        case .first:
            self.onCalculatorCellTappedFirstCurrency(type: type)
            self.secondCurrencyEnteredValue = self.getSecondCurrencyEnteredValue()
        case .second:
            self.onCalculatorCellTappedSecondCurrency(type: type)
            self.firstCurrencyEnteredValue = self.getFirstCurrencyEnteredValue()
        }
    }
}

private extension CurrencyConverter {
    
    func onCalculatorCellTappedFirstCurrency(type: CalculatorButtons) {
        switch type {
        case .o4ne:
            if self.firstCurrencyEnteredValue.isEmpty == false {
                self.firstCurrencyEnteredValue.removeLast()
            }
        case .o8ne:
            self.rotationCurrencies()
        case .o12ne:
            self.firstCurrencyEnteredValue.removeAll()
        case .o14ne:
            if self.firstCurrencyEnteredValue.contains(type.rawValue) == false {
                self.firstCurrencyEnteredValue += type.rawValue
            }
        default:
            if self.firstCurrencyEnteredValue == "0" {
                self.firstCurrencyEnteredValue.removeFirst()
            }
            self.firstCurrencyEnteredValue += type.rawValue
        }
    }
    
    func onCalculatorCellTappedSecondCurrency(type: CalculatorButtons) {
        switch type {
        case .o4ne:
            if self.secondCurrencyEnteredValue.isEmpty == false {
                self.secondCurrencyEnteredValue.removeLast()
            }
        case .o8ne:
            self.rotationCurrencies()
        case .o12ne:
            self.secondCurrencyEnteredValue.removeAll()
        case .o14ne:
            if self.secondCurrencyEnteredValue.contains(type.rawValue) == false {
                self.secondCurrencyEnteredValue += type.rawValue
            }
        default:
            if self.secondCurrencyEnteredValue == "0" {
                self.secondCurrencyEnteredValue.removeFirst()
            }
            self.secondCurrencyEnteredValue += type.rawValue
        }
    }
    
    func rotationCurrencies() {
        guard let first = self.firstCurrencyModel,
              let second = self.secondCurrencyModel else { return }
        
        self.secondCurrencyModel = first
        self.firstCurrencyModel = second
        
        let const = self.firstCurrencyEnteredValue
        self.firstCurrencyEnteredValue = self.secondCurrencyEnteredValue
        self.secondCurrencyEnteredValue = const
    }
    
    func getFirstCurrencyEnteredValue() -> String {
        guard let firstCurrency = self.firstCurrencyModel,
              let secondCurrency = self.secondCurrencyModel else { return "0" }
        
        let value = self.toDoubleFromString(self.secondCurrencyEnteredValue)
        let first = self.toDoubleFromString(firstCurrency.valueRub) / self.toDoubleFromString(firstCurrency.nominal)
        let second = self.toDoubleFromString(secondCurrency.valueRub) / self.toDoubleFromString(secondCurrency.nominal)
        
        let result = value * second / first
        
        return self.toStringFromDouble(result)
    }
    
    func getSecondCurrencyEnteredValue() -> String {
        guard let firstCurrency = self.firstCurrencyModel,
              let secondCurrency = self.secondCurrencyModel else { return "0" }
        
        let value = self.toDoubleFromString(self.firstCurrencyEnteredValue)
        let first = self.toDoubleFromString(firstCurrency.valueRub) / self.toDoubleFromString(firstCurrency.nominal)
        let second = self.toDoubleFromString(secondCurrency.valueRub) / self.toDoubleFromString(secondCurrency.nominal)
        
        let result = value * first / second
                      
        return self.toStringFromDouble(result)
    }
    
    func toStringFromDouble(_ double: Double) -> String {
        if let result = self.formatter.string(from: NSNumber(value: double)) {
            return result
        }
        
        return ""
    }
    
    func toDoubleFromString(_ string: String) -> Double {
        if let result = self.formatter.number(from: string) {
            return result.doubleValue
        }
        
        return 0
    }
    
    func configNumberFormatter() {
        self.formatter.numberStyle = .currency
        self.formatter.currencySymbol = ""
        self.formatter.currencyDecimalSeparator = ","
        self.formatter.currencyGroupingSeparator = " "
    }
}
