//
//  CurrencyConverterRouter.swift
//  CurrencyConverter
//
//  Created by pavel mishanin on 02.09.2022.
//

import UIKit

protocol ICurrencyConverterRouter: AnyObject {
    func pushToSelectCurrencyModul()
}

final class CurrencyConverterRouter {
    
    weak var controller: UIViewController?
}

extension CurrencyConverterRouter: ICurrencyConverterRouter {
    
    func pushToSelectCurrencyModul() {
        let vc = CurrencySelectionAssembly.build()
        self.controller?.navigationController?.pushViewController(vc, animated: true)
    }
}
