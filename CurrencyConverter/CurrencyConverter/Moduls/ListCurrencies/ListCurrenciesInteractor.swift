//
//  ListCurrenciesInteractor.swift
//  CurrencyConverter
//
//  Created by pavel mishanin on 31.08.2022.
//

import Foundation

protocol IListCurrenciesInteractor: AnyObject {
    func loadCurrenciesFromNetwork(completion: @escaping(Result<[CRBApiModel], NetworkError>) -> ())
    func createCurrency(model: RequestCurrencyModel,
                        completion: @escaping((Error) -> ()))
    func getListCurrencies(completion: @escaping((Result<[ResponseCurrencyModel],
                                                  Error>) -> ()))
    func updateCurrency(model: RequestFavoriteCurrencyModel,
                        completion: @escaping((Error) -> ()))
    func getFavoriteCurrencies(completion: @escaping((Result<[ResponseCurrencyModel],
                                                      Error>) -> ()))
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
    
    func loadCurrenciesFromNetwork(completion: @escaping(Result<[CRBApiModel], NetworkError>) -> ()) {
        let requestConfig = RequestFactory.CBRCurrencyRequest.modelConfig()
        
        self.networkService.send(config: requestConfig, completionHandler: completion)
    }
    
    func createCurrency(model: RequestCurrencyModel,
                        completion: @escaping((Error) -> ())) {
        do {
            try self.storageService.createCurrency(model: model)
        } catch {
            completion(error)
        }
    }
    
    func getListCurrencies(completion: @escaping((Result<[ResponseCurrencyModel],
                                                  Error>) -> ())) {
        do {
           let success = try self.storageService.getListCurrencies()
            completion(.success(success))
        } catch {
            completion(.failure(error))
        }
    }
    
    func updateCurrency(model: RequestFavoriteCurrencyModel,
                        completion: @escaping((Error) -> ())) {
        do {
            try self.storageService.updateCurrency(model: model)
        } catch {
            completion(error)
        }
    }
    
    func getFavoriteCurrencies(completion: @escaping((Result<[ResponseCurrencyModel],
                                                      Error>) -> ())) {
        do {
           let success = try self.storageService.getFavoriteCurrencies()
            completion(.success(success))
        } catch {
            completion(.failure(error))
        }
    }
}
