//
//  TabBarAssembly.swift
//  CurrencyConverter
//
//  Created by pavel mishanin on 30.08.2022.
//

import UIKit

final class TabBarAssembly: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewControllers = [self.createListCurrenciesViewController(),
                                self.createCurrencyConverterViewController()]
        
        self.tabBar.tintColor = .black
    }
}

private extension TabBarAssembly {
    
    func createListCurrenciesViewController() -> UIViewController {
        let vc = ListCurrenciesAssembly.build()
        let image = UIImage(systemName: "dollarsign.circle")
        vc.tabBarItem = UITabBarItem(title: "List",
                                     image: image,
                                     tag: 0)
        
        return UINavigationController(rootViewController: vc)
    }
    
    func createCurrencyConverterViewController() -> UIViewController {
        let vc = CurrencyConverterAssembly.build()
        let image = UIImage(systemName: "arrow.triangle.2.circlepath.circle")
        vc.tabBarItem = UITabBarItem(title: "Converter",
                                     image: image,
                                     tag: 1)
        
        return UINavigationController(rootViewController: vc)
    }
}
