//
//  CurrencyConverterPresenter.swift
//  CurrencyConverter
//
//  Created by pavel mishanin on 30.08.2022.
//

import Foundation

protocol ICurrencyConverterPresenter: AnyObject {
    func onViewAttached(controller: ICurrencyConverterViewController)
    func numberOfRowsInSection() -> Int
    func getCurrencyModelByIndex(_ index: Int) -> CurrencyConverterViewModel?
    func foo(index: Int) -> String
}

final class CurrencyConverterPresenter {
    
    private weak var controller: ICurrencyConverterViewController?
    private let storageService: ICoreDataStorage
    private let router: ICurrencyConverterRouter
    
    let formatter = NumberFormatter()
    
    private var firstCurrency: CurrencyConverterViewModel?
    private var secondCurrency: CurrencyConverterViewModel?
    
    private var index = Int()
    
    var didSelectCellAtIndex = 0
    
    var firstCurrencyEnteredValue: String = ""
    
    var secondCurrencyEnteredValue = ""
    
    init(storageService: ICoreDataStorage,
         router: ICurrencyConverterRouter) {
        self.storageService = storageService
        self.router = router
    }
}

extension CurrencyConverterPresenter: CurrencySelectionPresenterDelegate {
    
    func didSelectModel(_ model: ResponseCurrencyModel) {
        switch self.getCurrencyTypeByIndex(self.index) {
        case .first:
            self.firstCurrency = CurrencyConverterViewModel(model: model)
        case .second:
            self.secondCurrency = CurrencyConverterViewModel(model: model)
        }
        
        self.controller?.reloadData()
    }
}

extension CurrencyConverterPresenter: ICurrencyConverterPresenter {
    
    func onViewAttached(controller: ICurrencyConverterViewController) {
        self.controller = controller
        
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 8
        formatter.currencyDecimalSeparator = ","
        
        self.controller?.onSelectCurrencyTappedHandler = { [ weak self ] index in
            guard let self = self else { return }
            self.index = index
            self.router.pushToSelectCurrencyModul(delegate: self)
        }
        
        self.controller?.currencyTextFieldDidChangeHandler = { index, text in
            switch self.getCurrencyTypeByIndex(index) {
            case .first:
                self.firstCurrencyEnteredValue = text ?? ""
            case .second:
                self.secondCurrencyEnteredValue = text ?? ""
            }
            
            self.controller?.reloadData()
        }
        
        self.controller?.onCalculatorCellTappedHandler = { index in
            let type = CalculatorType.allCases[index]
            
            switch self.getCurrencyTypeByIndex(self.didSelectCellAtIndex) {
            case .first:
                switch type {
                case .o4ne:
                    if self.firstCurrencyEnteredValue.isEmpty == false {
                        self.firstCurrencyEnteredValue.removeLast()
                    }
                case .o8ne:
                    self.rotationCurrencies()
                case .o12ne:
                    self.firstCurrencyEnteredValue = ""
                case .o14ne:
                    if self.firstCurrencyEnteredValue.contains(type.rawValue) == false {
                        self.firstCurrencyEnteredValue += type.rawValue
                    }
                default :
                    if self.firstCurrencyEnteredValue == "0" {
                        self.firstCurrencyEnteredValue.removeFirst()
                    }
                    self.firstCurrencyEnteredValue += type.rawValue
                }
            case .second:
                switch type {
                case .o4ne:
                    if self.secondCurrencyEnteredValue.isEmpty == false {
                        self.secondCurrencyEnteredValue.removeLast()
                    }
                case .o8ne:
                    self.rotationCurrencies()
                case .o12ne:
                    self.secondCurrencyEnteredValue = ""
                case .o14ne:
                    if self.secondCurrencyEnteredValue.contains(type.rawValue) == false {
                        self.secondCurrencyEnteredValue += type.rawValue
                    }
                default :
                    if self.secondCurrencyEnteredValue == "0" {
                        self.secondCurrencyEnteredValue.removeFirst()
                    }
                    self.secondCurrencyEnteredValue += type.rawValue
                }
                
            }
            
            self.controller?.reloadData()
        }
        
        self.controller?.onCellTappedHandler = { index in
            self.didSelectCellAtIndex = index
        }
    }
    
    func numberOfRowsInSection() -> Int {
        CurrencyType.allCases.count
    }
    
    func foo(index: Int) -> String {
        switch self.getCurrencyTypeByIndex(index) {
        case .first:
            return self.getFirstTextFieldValue()
        case .second:
            return self.getSecondTextFieldValue()
        }
    }
    
    func getCurrencyModelByIndex(_ index: Int) -> CurrencyConverterViewModel? {
        switch self.getCurrencyTypeByIndex(index) {
        case .first:
            return self.firstCurrency
        case .second:
            return self.secondCurrency
        }
    }
}

private extension CurrencyConverterPresenter {
    
    func rotationCurrencies() {
        guard let first = self.firstCurrency,
              let second = self.secondCurrency else { return }
        
        self.secondCurrency = first
        self.firstCurrency = second
    }
    
    func getCurrencyTypeByIndex(_ index: Int) -> CurrencyType {
        CurrencyType.allCases[index]
    }
    
    func getFirstTextFieldValue() -> String {
        guard let firstCurrency = self.firstCurrency,
              let secondCurrency = self.secondCurrency,
              let value = Double(self.secondCurrencyEnteredValue) else { return self.firstCurrencyEnteredValue }
        
        let result = value / Double(secondCurrency.valueRub)! * Double(firstCurrency.valueRub)!
        
        let res = self.formatter.string(from: NSNumber(value: result))!
        
        return res
    }
    
    func getSecondTextFieldValue() -> String {
        guard let firstCurrency = self.firstCurrency,
              let secondCurrency = self.secondCurrency,
              let value = Double(self.firstCurrencyEnteredValue) else { return self.secondCurrencyEnteredValue }
        
        return "\(value * Double(secondCurrency.valueRub)! / Double(firstCurrency.valueRub)!)"
    }
}
