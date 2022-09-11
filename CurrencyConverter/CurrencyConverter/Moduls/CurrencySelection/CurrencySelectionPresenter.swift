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
    func getModelByIndex(_ index: Int) -> ListCurrencyViewModel
}

final class CurrencySelectionPresenter {
    
    private weak var controller: ICurrencySelectionViewController?
    private let storageService: ICoreDataStorage
    private let router: ICurrencySelectionRouter
    private var array: [ListCurrencyViewModel] = []
    
    private let didSelectCurrencyHandler: (ListCurrencyViewModel) -> ()
    
    init(storageService: ICoreDataStorage,
         router: ICurrencySelectionRouter,
         completion: @escaping(ListCurrencyViewModel) -> ()) {
        self.storageService = storageService
        self.router = router
        self.didSelectCurrencyHandler = completion
    }
}

extension CurrencySelectionPresenter: ICurrencySelectionPresenter {
    
    func onViewAttached(controller: ICurrencySelectionViewController) {
        self.controller = controller
        
        self.getAllCurrencies()
        self.setOnCellTappedHandler()
    }
    
    func numberOfRowsInSection() -> Int {
        self.array.count
    }
    
    func getModelByIndex(_ index: Int) -> ListCurrencyViewModel {
        self.array[index]
    }
}

private extension CurrencySelectionPresenter {
    
    func getAllCurrencies() {
        do {
            let array = try self.storageService.getAllCurrencies()
            
            self.array = array.map { ListCurrencyViewModel(model: $0) }
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
