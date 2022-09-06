//
//  CurrencySelectionAssembly.swift
//  CurrencyConverter
//
//  Created by pavel mishanin on 02.09.2022.
//

import UIKit

enum CurrencySelectionAssembly {
    
    static func build(delegate: CurrencyConverterPresenter) -> UIViewController {
        
        let storageService = CoreDataStorage()
        let router = CurrencySelectionRouter()
        let presenter = CurrencySelectionPresenter(storageService: storageService,
                                                   router: router,
                                                   delegate: delegate)
        let controller = CurrencySelectionViewController(presenter: presenter)
        router.controller = controller
        
        return controller
    }
}
