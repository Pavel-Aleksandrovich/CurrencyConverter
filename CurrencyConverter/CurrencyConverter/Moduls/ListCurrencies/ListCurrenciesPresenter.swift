//
//  ListCurrenciesPresenter.swift
//  CurrencyConverter
//
//  Created by pavel mishanin on 30.08.2022.
//

import Foundation

protocol IListCurrenciesPresenter: AnyObject {
    func onViewAttached(controller: IListCurrenciesViewController)
    func numberOfRowsInSection() -> Int
    func getModelByIndex(_ index: Int) -> ResponseCurrencyModel
}

final class ListCurrenciesPresenter {
    
    private let interactor: IListCurrenciesInteractor
    private weak var controller: IListCurrenciesViewController?
    private var array: [ResponseCurrencyModel] = []
    private var type: TypeCurrencies = .list
    
    init(interactor: IListCurrenciesInteractor) {
        self.interactor = interactor
    }
}

extension ListCurrenciesPresenter: IListCurrenciesPresenter {
    
    func onViewAttached(controller: IListCurrenciesViewController) {
        self.controller = controller
        
        self.loadCurrenciesFromNetwork()
        self.setOnCollectionCellTappedHandler()
        self.setOnFavoriteButtonTappedHandler()
    }
    
    func numberOfRowsInSection() -> Int {
        self.array.count
    }
    
    func getModelByIndex(_ index: Int) -> ResponseCurrencyModel {
        self.array[index]
    }
}

private extension ListCurrenciesPresenter {
    
    func setOnCollectionCellTappedHandler() {
        self.controller?.onCollectionCellTappedHandler = { index in
            self.type = TypeCurrencies.allCases[index]
            self.loadCurrencies()
        }
    }
    
    func setOnFavoriteButtonTappedHandler() {
        self.controller?.onFavoriteButtonTappedHandler = { [ weak self ] model in
            guard let self = self else { return }
            
            self.updateCurrency(model: model)
            self.loadCurrencies()
        }
    }
    
    func loadCurrenciesFromNetwork() {
        self.interactor.loadCurrenciesFromNetwork { result in
            switch result {
            case .success(let array):
                DispatchQueue.main.async {
                    self.saveCurrencies(array: array)
                    self.loadCurrencies()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func saveCurrencies(array: [CurrencyDTO]) {
        let request = array.map { RequestCurrencyModel(model: $0)}
        
        request.forEach { model in
            self.interactor.createCurrency(model: model) { error in
                print(error.localizedDescription)
            }
        }
    }
    
    func updateCurrency(model: RequestFavoriteCurrencyModel) {
        self.interactor.updateCurrency(model: model) { error in
            print(error.localizedDescription)
        }
    }
    
    func loadCurrencies() {
        switch self.type {
        case .list:
            self.loadListCurrencies()
        case .favorite:
            self.loadFavoriteCurrencies()
        }
        
        self.controller?.reloadData()
    }
    
    func loadListCurrencies() {
        self.interactor.getListCurrencies { [ weak self ] result in
            switch result {
            case .success(let array):
                self?.array = array
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func loadFavoriteCurrencies() {
        self.interactor.getFavoriteCurrencies { [ weak self ] result in
            switch result {
            case .success(let array):
                self?.array = array
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
