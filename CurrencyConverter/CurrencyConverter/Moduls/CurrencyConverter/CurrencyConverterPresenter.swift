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
    
    init(router: ICurrencyConverterRouter,
         converter: ICurrencyConverter) {
        self.router = router
        self.converter = converter
    }
}

extension CurrencyConverterPresenter: CurrencySelectionPresenterDelegate {
    
    func didSelectCurrency(_ model: ResponseCurrencyModel) {
        self.converter.setCurrencyModel(model)
        self.controller?.reloadData()
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
        self.converter.getCurrencyValueByIndex(index)
    }
    
    func getCurrencyModelByIndex(_ index: Int) -> CurrencyConverterViewModel? {
        self.converter.getCurrencyModelByIndex(index)
    }
}

private extension CurrencyConverterPresenter {
    
    func setOnCellTappedHandler() {
        self.controller?.onCellTappedHandler = { [ weak self ] index in
            self?.converter.setTableIndex(index)
        }
    }
    
    func setOnSelectCurrencyTappedHandler() {
        self.controller?.onSelectCurrencyTappedHandler = { [ weak self ] index in
            guard let self = self else { return }
            self.converter.setIndex(index)
            self.router.pushToSelectCurrencyModul(delegate: self)
        }
    }
    
    func setOnCalculatorCellTappedHandler() {
        self.controller?.onCalculatorCellTappedHandler = { [ weak self ] index in
            guard let self = self else { return }
            self.converter.onCalculatorCellTappedByIndex(index)
            self.controller?.reloadData()
        }
    }
}
