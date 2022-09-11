//
//  CurrencyConverterRouter.swift
//  CurrencyConverter
//
//  Created by pavel mishanin on 02.09.2022.
//

import UIKit

protocol ICurrencyConverterRouter: AnyObject {
    func pushToSelectCurrencyModul(completion: @escaping(ListCurrencyViewModel) -> ())
}

final class CurrencyConverterRouter {
    
    weak var controller: UIViewController?
}

extension CurrencyConverterRouter: ICurrencyConverterRouter {
    
    func pushToSelectCurrencyModul(completion: @escaping(ListCurrencyViewModel) -> ()) {
        let vc = CurrencySelectionAssembly.build(completion: completion)
        self.controller?.navigationController?.pushViewController(vc, animated: true)
    }
}
