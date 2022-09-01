//
//  ListCurrenciesInteractor.swift
//  CurrencyConverter
//
//  Created by pavel mishanin on 31.08.2022.
//

import Foundation

protocol IListCurrenciesInteractor: AnyObject {
    func loadData(completion: @escaping(Result<[CRBApiModel], Error>) -> ())
    func createCurrency(model: RequestCurrencyModel) throws
    func getListCurrencies() throws -> [ResponseCurrencyModel]
    func updateCurrency(model: RequestFavoriteCurrencyModel) throws
    func getFavoriteCurrencies() throws -> [ResponseCurrencyModel]
}

final class ListCurrenciesInteractor {
    
    private let networkService: IRequestSender
    private let storageService: ICoreDataStorage
    
    init(networkService: IRequestSender, storageService: ICoreDataStorage) {
        self.networkService = networkService
        self.storageService = storageService
    }
}

extension ListCurrenciesInteractor: IListCurrenciesInteractor {
    
    func loadData(completion: @escaping(Result<[CRBApiModel], Error>) -> ()) {
        let requestConfig = RequestFactory.CBRCurrencyRequest.modelConfig()
        
        self.networkService.send(config: requestConfig) { [weak self] result in
            switch result {
            case .success(let (models, _, _)):
                completion(.success(models))
            case .failure(let error):
                Logger.error(error.rawValue)
            }
        }
    }
    
    func createCurrency(model: RequestCurrencyModel) throws {
       
       try self.storageService.createCurrency(model: model)
    }
    
    func getListCurrencies() throws -> [ResponseCurrencyModel] {
        try self.storageService.getListCurrencies()
    }
    
    func updateCurrency(model: RequestFavoriteCurrencyModel) throws {
        try self.storageService.updateCurrency(model: model)
    }
    
    func getFavoriteCurrencies() throws -> [ResponseCurrencyModel] {
        try self.storageService.getFavoriteCurrencies()
    }
}
