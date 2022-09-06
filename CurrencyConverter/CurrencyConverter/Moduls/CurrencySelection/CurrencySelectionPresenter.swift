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
    private let router: ICurrencySelectionRouter
    private var array: [ResponseCurrencyModel] = []
    
    init(storageService: ICoreDataStorage,
         router: ICurrencySelectionRouter,
         delegate: CurrencyConverterPresenter) {
        self.storageService = storageService
        self.router = router
        self.delegate = delegate
    }
}

extension CurrencySelectionPresenter: ICurrencySelectionPresenter {
    
    func onViewAttached(controller: ICurrencySelectionViewController) {
        self.controller = controller
        
        self.array = try! self.storageService.getListCurrencies()
        
        self.controller?.onCellTappedHandler = { [ weak self ] model in
            self?.delegate?.didSelectModel(model)
            self?.router.popViewController()
        }
    }
    
    func numberOfRowsInSection() -> Int {
        self.array.count
    }
    
    func getModelByIndex(_ index: Int) -> ResponseCurrencyModel {
        self.array[index]
    }
}
