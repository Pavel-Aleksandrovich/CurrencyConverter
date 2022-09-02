//
//  CurrencySelectionPresenter.swift
//  CurrencyConverter
//
//  Created by pavel mishanin on 02.09.2022.
//

import Foundation

protocol ICurrencySelectionPresenter: AnyObject {
    func onViewAttached(controller: ICurrencySelectionViewController)
    func numberOfRowsInSection() -> Int
    func getModelByIndex(_ index: Int) -> ResponseCurrencyModel
}

final class CurrencySelectionPresenter {
    
    private weak var controller: ICurrencySelectionViewController?
    private let storageService: ICoreDataStorage
    private var array: [ResponseCurrencyModel] = []
    
    init(storageService: ICoreDataStorage) {
        self.storageService = storageService
    }
}

extension CurrencySelectionPresenter: ICurrencySelectionPresenter {
    
    func onViewAttached(controller: ICurrencySelectionViewController) {
        self.controller = controller
        
        self.array = try! self.storageService.getListCurrencies()
    }
    
    func numberOfRowsInSection() -> Int {
        self.array.count
    }
    
    func getModelByIndex(_ index: Int) -> ResponseCurrencyModel {
        self.array[index]
    }
}
