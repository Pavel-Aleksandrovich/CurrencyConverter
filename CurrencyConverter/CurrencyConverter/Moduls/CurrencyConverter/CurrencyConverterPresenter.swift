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
    
    var val: String = ""
    
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
        
        self.controller?.onSelectCurrencyTappedHandler = { [ weak self ] index in
            guard let self = self else { return }
            self.index = index
            self.router.pushToSelectCurrencyModul(delegate: self)
        }
        
        self.controller?.currencyTextFieldDidChangeHandler = { index, text in
            switch self.getCurrencyTypeByIndex(index) {
            case .first:
                self.val = text ?? ""
            case .second:
                self.secondCurrencyEnteredValue = text ?? ""
            }
            
            self.controller?.reloadData()
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
    
    func getCurrencyTypeByIndex(_ index: Int) -> CurrencyType {
        CurrencyType.allCases[index]
    }
    
    func getFirstTextFieldValue() -> String {
        guard let firstCurrency = self.firstCurrency,
              let secondCurrency = self.secondCurrency,
              let value = Double(self.secondCurrencyEnteredValue) else { return self.val }
        
        return "\(value / Double(secondCurrency.valueRub)! * Double(firstCurrency.valueRub)!)"
    }
    
    func getSecondTextFieldValue() -> String {
        guard let firstCurrency = self.firstCurrency,
              let secondCurrency = self.secondCurrency,
              let value = Double(self.val) else { return self.secondCurrencyEnteredValue }
        
        return "\(value * Double(secondCurrency.valueRub)! / Double(firstCurrency.valueRub)!)"
    }
}
