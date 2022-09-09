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
    private let router: ICurrencySelectionRouter
    private var array: [ResponseCurrencyModel] = []
    
    private let didSelectCurrencyHandler: (ResponseCurrencyModel) -> ()
    
    init(storageService: ICoreDataStorage,
         router: ICurrencySelectionRouter,
         completion: @escaping(ResponseCurrencyModel) -> ()) {
        self.storageService = storageService
        self.router = router
        self.didSelectCurrencyHandler = completion
    }
}

extension CurrencySelectionPresenter: ICurrencySelectionPresenter {
    
    func onViewAttached(controller: ICurrencySelectionViewController) {
        self.controller = controller
        
        self.getListCurrencies()
        self.setOnCellTappedHandler()
    }
    
    func numberOfRowsInSection() -> Int {
        self.array.count
    }
    
    func getModelByIndex(_ index: Int) -> ResponseCurrencyModel {
        self.array[index]
    }
}

private extension CurrencySelectionPresenter {
    
    func getListCurrencies() {
        do {
            self.array = try self.storageService.getListCurrencies()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func setOnCellTappedHandler() {
        self.controller?.onCellTappedHandler = { [ weak self ] model in
            self?.didSelectCurrencyHandler(model)
            self?.router.popViewController()
        }
    }
}
