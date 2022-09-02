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
    func getCurrencyTypeByIndex(_ index: Int) -> CurrencyType
    func firstCurrencyDidChange(value: String?)
    func getTextFieldValue() -> String
}

final class CurrencyConverterPresenter {
    
    private weak var controller: ICurrencyConverterViewController?
    private let storageService: ICoreDataStorage
    private let router: ICurrencyConverterRouter
    
    var val: String? {
        didSet {
            self.controller?.reloadData()
        }
    }
    
    init(storageService: ICoreDataStorage,
         router: ICurrencyConverterRouter) {
        self.storageService = storageService
        self.router = router
    }
}

extension CurrencyConverterPresenter: ICurrencyConverterPresenter {
    
    func onViewAttached(controller: ICurrencyConverterViewController) {
        self.controller = controller
        
        print(try? self.storageService.getListCurrencies().count)
        
        self.controller?.onSelectCurrencyTappedHandler = {
            self.router.pushToSelectCurrencyModul()
            print("46")
        }
    }
    
    func numberOfRowsInSection() -> Int {
        CurrencyType.allCases.count
    }
    
    func getCurrencyTypeByIndex(_ index: Int) -> CurrencyType {
        CurrencyType.allCases[index]
    }
    
    func firstCurrencyDidChange(value: String?) {
        self.val = value
        print(value)
    }
    
    func getTextFieldValue() -> String {
        return val ?? ""
    }
}
