//
//  CurrencySelectionPresenter.swift
//  CurrencyConverter
//
//  Created by pavel mishanin on 02.09.2022.
//

import Foundation

protocol CurrencySelectionPresenterDelegate: AnyObject {
    func didSelectModel(_ model: ResponseCurrencyModel)
}

protocol ICurrencySelectionPresenter: AnyObject {
    func onViewAttached(controller: ICurrencySelectionViewController)
    func numberOfRowsInSection() -> Int
    func getModelByIndex(_ index: Int) -> ResponseCurrencyModel
}

final class CurrencySelectionPresenter {
    
    private weak var controller: ICurrencySelectionViewController?
    private weak var delegate: CurrencySelectionPresenterDelegate?
    private let storageService: ICoreDataStorage
    private var array: [ResponseCurrencyModel] = []
    
    init(storageService: ICoreDataStorage,
         delegate: CurrencyConverterPresenter) {
        self.storageService = storageService
        self.delegate = delegate
    }
}

extension CurrencySelectionPresenter: ICurrencySelectionPresenter {
    
    func onViewAttached(controller: ICurrencySelectionViewController) {
        self.controller = controller
        
        self.array = try! self.storageService.getListCurrencies()
        
        self.controller?.onCellTappedHandler = { model in
            self.delegate?.didSelectModel(model)
        }
    }
    
    func numberOfRowsInSection() -> Int {
        self.array.count
    }
    
    func getModelByIndex(_ index: Int) -> ResponseCurrencyModel {
        self.array[index]
    }
}
