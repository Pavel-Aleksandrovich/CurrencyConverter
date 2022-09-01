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
        let presenter = CurrencyConverterPresenter(storageService: storageService)
        let controller = CurrencyConverterViewController(presenter: presenter)
        
        return controller
    }
}
