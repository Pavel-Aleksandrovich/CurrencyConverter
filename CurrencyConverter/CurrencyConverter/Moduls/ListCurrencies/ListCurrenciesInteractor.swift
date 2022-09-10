//
//  ListCurrenciesInteractor.swift
//  CurrencyConverter
//
//  Created by pavel mishanin on 31.08.2022.
//

import Foundation

protocol IListCurrenciesInteractor: AnyObject {
    func loadCurrenciesFromNetwork(completion: @escaping(Result<[CurrencyDTO], NetworkError>) -> ())
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
    
    private let networkService: INetworkService
    private let storageService: ICoreDataStorage
    private let parser: ICurrencyXMLParser
    
    init(networkService: INetworkService,
         storageService: ICoreDataStorage,
         parser: ICurrencyXMLParser) {
        self.networkService = networkService
        self.storageService = storageService
        self.parser = parser
    }
}

extension ListCurrenciesInteractor: IListCurrenciesInteractor {
    
    func loadCurrenciesFromNetwork(completion: @escaping(Result<[CurrencyDTO],
                                                         NetworkError>) -> ()) {
        
        self.networkService.loadData { [ weak self ] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                let model = self.parser.parse(data: data)
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
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
