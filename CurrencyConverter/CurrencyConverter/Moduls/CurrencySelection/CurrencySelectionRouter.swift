//
//  CurrencySelectionRouter.swift
//  CurrencyConverter
//
//  Created by pavel mishanin on 06.09.2022.
//

import UIKit

protocol ICurrencySelectionRouter: AnyObject {
    func popViewController()
}

final class CurrencySelectionRouter {
    
    weak var controller: UIViewController?
}

extension CurrencySelectionRouter: ICurrencySelectionRouter {
    
    func popViewController() {
        self.controller?.navigationController?.popViewController(animated: true)
    }
}
