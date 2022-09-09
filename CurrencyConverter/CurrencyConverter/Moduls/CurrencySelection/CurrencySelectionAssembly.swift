//
//  CurrencySelectionAssembly.swift
//  CurrencyConverter
//
//  Created by pavel mishanin on 02.09.2022.
//

import UIKit

enum CurrencySelectionAssembly {
    
    static func build(completion: @escaping(ResponseCurrencyModel) -> ()) -> UIViewController {
        
        let storageService = CoreDataStorage()
        let router = CurrencySelectionRouter()
        let presenter = CurrencySelectionPresenter(storageService: storageService,
                                                   router: router,
                                                   completion: completion)
        let controller = CurrencySelectionViewController(presenter: presenter)
        router.controller = controller
        
        return controller
    }
}
