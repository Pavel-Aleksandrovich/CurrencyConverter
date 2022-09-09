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
    func getCurrencyValueByIndex(_ index: Int) -> String
}

final class CurrencyConverterPresenter {
    
    private weak var controller: ICurrencyConverterViewController?
    private let router: ICurrencyConverterRouter
    private let converter: ICurrencyConverter
    private let formatter = Formatter()
    
    private var firstModel = CurrencyConverterViewModel()
    private var secondModel = CurrencyConverterViewModel()
    
    private var firstValue = String()
    private var secondValue = String()
    
    private var index = Int()
    
    init(router: ICurrencyConverterRouter,
         converter: ICurrencyConverter) {
        self.router = router
        self.converter = converter
    }
}

extension CurrencyConverterPresenter: ICurrencyConverterPresenter {
    
    func onViewAttached(controller: ICurrencyConverterViewController) {
        self.controller = controller
        
        self.setOnSelectCurrencyTappedHandler()
        self.setOnCellTappedHandler()
        self.setOnCalculatorCellTappedHandler()
    }
    
    func numberOfRowsInSection() -> Int {
        CurrencyType.allCases.count
    }
    
    func getCurrencyValueByIndex(_ index: Int) -> String {
        switch CurrencyType.allCases[index] {
        case .first: return self.firstValue
        case .second: return self.secondValue
        }
    }
    
    func getCurrencyModelByIndex(_ index: Int) -> CurrencyConverterViewModel? {
        switch CurrencyType.allCases[index] {
        case .first: return self.firstModel
        case .second: return self.secondModel
        }
    }
}

private extension CurrencyConverterPresenter {
    
    func setOnCellTappedHandler() {
        self.controller?.onCellTappedHandler = { index in
            self.index = index
        }
    }
    
    func setOnSelectCurrencyTappedHandler() {
        self.controller?.onSelectCurrencyTappedHandler = { [ weak self ] index in
            guard let self = self else { return }
            
            self.router.pushToSelectCurrencyModul { [ weak self ] model in
                guard let self = self else { return }
                switch CurrencyType.allCases[index] {
                case .first:
                    self.firstModel = CurrencyConverterViewModel(model: model)
                case .second:
                    self.secondModel = CurrencyConverterViewModel(model: model)
                }
                self.controller?.reloadData()
            }
        }
    }
    
    func setOnCalculatorCellTappedHandler() {
        self.controller?.onCalculatorCellTappedHandler = { [ weak self ] index in
            guard let self = self else { return }
            
            let culculatorButton = CalculatorButtons.allCases[index]
            
            let first = self.converter.getNominal(x: self.formatter.number(self.firstModel.valueRub),
                                                  y: self.formatter.number(self.firstModel.nominal))
            
            let second = self.converter.getNominal(x: self.formatter.number(self.secondModel.valueRub),
                                                   y: self.formatter.number(self.secondModel.nominal))
            
            switch CurrencyType.allCases[self.index] {
            case .first:
                self.firstValue = self.onCalculatorCellTapped(type: culculatorButton,
                                                         string: self.firstValue)
                
                let value = self.formatter.number(self.firstValue)
                
                let number = self.converter.getSecondValue(value: value,
                                                                first: first,
                                                                second: second)
                
                self.secondValue = self.formatter.string(from: number)
            case .second:
                self.secondValue = self.onCalculatorCellTapped(type: culculatorButton,
                                                         string: self.secondValue)
                
                let value = self.formatter.number(self.secondValue)
                
                let number = self.converter.getFirstValue(value: value,
                                                               first: first,
                                                               second: second)
                
                self.firstValue = self.formatter.string(from: number)
            }
            
            self.controller?.reloadData()
        }
    }
}

private extension CurrencyConverterPresenter {
    
    func onCalculatorCellTapped(type: CalculatorButtons, string: String) -> String {
        var result = String()
        
        switch type {
        case .removeLast:
            result = self.converter.removeLast(string)
        case .rotation:
            self.rotationCurrencies()
        case .removeAll:
            result = self.formatter.string(from: Double(0))
        case .comma:
            result = self.converter.addСomma(type.rawValue,
                          toString: string)
        default:
            result = self.converter.addValue(type.rawValue,
                          toString: string)
        }
        
        return result
    }
    
    func rotationCurrencies() {
        let firstModel = self.firstModel
        self.firstModel = self.secondModel
        self.secondModel = firstModel
        
        let firstValue = self.firstValue
        self.firstValue = self.secondValue
        self.secondValue = firstValue
    }
}
