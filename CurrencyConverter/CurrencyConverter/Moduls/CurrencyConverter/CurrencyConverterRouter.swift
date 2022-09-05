//
//  CurrencyConverterRouter.swift
//  CurrencyConverter
//
//  Created by pavel mishanin on 02.09.2022.
//

import UIKit

protocol ICurrencyConverterRouter: AnyObject {
    func pushToSelectCurrencyModul(delegate: CurrencyConverterPresenter)
}

final class CurrencyConverterRouter {
    
    weak var controller: UIViewController?
}

extension CurrencyConverterRouter: ICurrencyConverterRouter {
    
    func pushToSelectCurrencyModul(delegate: CurrencyConverterPresenter) {
        let vc = CurrencySelectionAssembly.build(delegate: delegate)
        self.controller?.navigationController?.pushViewController(vc, animated: true)
    }
}
