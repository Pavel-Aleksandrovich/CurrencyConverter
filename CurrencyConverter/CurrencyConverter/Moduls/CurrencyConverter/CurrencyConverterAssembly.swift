//
//  CurrencyConverterAssembly.swift
//  CurrencyConverter
//
//  Created by pavel mishanin on 30.08.2022.
//

import UIKit

enum CurrencyConverterAssembly {
    
    static func build() -> UIViewController {
        
        let storageService = CoreDataStorage()
        let router = CurrencyConverterRouter()
        let presenter = CurrencyConverterPresenter(storageService: storageService,
                                                   router: router)
        let controller = CurrencyConverterViewController(presenter: presenter)
        router.controller = controller
        
        return controller
    }
}
