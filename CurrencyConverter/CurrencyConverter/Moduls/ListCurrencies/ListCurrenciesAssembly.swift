//
//  ListCurrenciesAssembly.swift
//  CurrencyConverter
//
//  Created by pavel mishanin on 30.08.2022.
//

import UIKit

enum ListCurrenciesAssembly {
    
    static func build() -> UIViewController {
        
        let storageService = CoreDataStorage()
        let networkService = NetworkService()
        let parser = CurrencyXMLParser()
        let interactor = ListCurrenciesInteractor(networkService: networkService,
                                                  storageService: storageService,
                                                  parser: parser)
        let presenter = ListCurrenciesPresenter(interactor: interactor)
        let controller = ListCurrenciesViewController(presenter: presenter)
        
        return controller
    }
}
