//
//  CurrencySelectionAssembly.swift
//  CurrencyConverter
//
//  Created by pavel mishanin on 02.09.2022.
//

import UIKit

enum CurrencySelectionAssembly {
    
    static func build() -> UIViewController {
        
        let storageService = CoreDataStorage()
        let presenter = CurrencySelectionPresenter(storageService: storageService)
        let controller = CurrencySelectionViewController(presenter: presenter)
        
        return controller
    }
}
