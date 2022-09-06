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
    
    var type: TypeCurrencies = .list {
        didSet {
            self.loadCurrencies()
        }
    }
    
    init(interactor: IListCurrenciesInteractor) {
        self.interactor = interactor
    }
}

extension ListCurrenciesPresenter: IListCurrenciesPresenter {
    
    func onViewAttached(controller: IListCurrenciesViewController) {
        self.controller = controller
        self.loadListCurrenciesAndSave()
        
        
        self.controller?.onCollectionCellTappedHandler = { index in
            self.type = TypeCurrencies.allCases[index]
        }
        
        self.setOnFavoriteButtonTappedHandler()
    }
    
    func numberOfRowsInSection() -> Int {
        self.array.count
    }
    
    func getModelByIndex(_ index: Int) -> ResponseCurrencyModel {
        self.array[index]
    }
    
    func loadListCurrenciesAndSave() {
        self.interactor.loadData { result in
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    let request = model.map( { RequestCurrencyModel(model: $0)})
                    
                    request.forEach { model in
                        try? self.interactor.createCurrency(model: model)
                    }
                    
                    self.loadListCurrencies()
                    
                    self.controller?.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func loadListCurrencies() {
        self.array = try! self.interactor.getListCurrencies()
    }
    
    func loadFavoriteCurrencies() {
        self.array = try! self.interactor.getFavoriteCurrencies()
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
}

private extension ListCurrenciesPresenter {
    
    func setOnFavoriteButtonTappedHandler() {
        self.controller?.onFavoriteButtonTappedHandler = { [ weak self ] model in
            guard let self = self else { return }
            try? self.interactor.updateCurrency(model: model)
            
            self.loadCurrencies()
        }
    }
}
