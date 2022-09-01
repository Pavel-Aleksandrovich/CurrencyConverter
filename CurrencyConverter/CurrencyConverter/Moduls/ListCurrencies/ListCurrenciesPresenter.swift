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
    
    init(interactor: IListCurrenciesInteractor) {
        self.interactor = interactor
    }
}

extension ListCurrenciesPresenter: IListCurrenciesPresenter {
    
    func onViewAttached(controller: IListCurrenciesViewController) {
        self.controller = controller
        
        self.interactor.loadData { result in
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    let request = model.map( { RequestCurrencyModel(model: $0)})
                    
                    request.forEach { model in
                        try? self.interactor.createCurrency(model: model)
                    }
                    
                    self.array = try! self.interactor.getListCurrencies()
                    
                    self.controller?.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
        
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
    
    func setOnFavoriteButtonTappedHandler() {
        self.controller?.onFavoriteButtonTappedHandler = { [ weak self ] model in
            guard let self = self else { return }
            try? self.interactor.updateCurrency(model: model)
            
            self.array = try! self.interactor.getListCurrencies()
            
            self.controller?.reloadData()
            
            print(try? self.interactor.getFavoriteCurrencies().count)
        }
    }
}
