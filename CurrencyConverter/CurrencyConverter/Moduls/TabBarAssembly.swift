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
                                self.createCurrencyConverterViewController(),
                                self.createCurrencySelectionViewController(),
                                self.createFavoriteCurrenciesViewController()]
//        self.tabBar.tintColor = .systemGray5
    }
}

private extension TabBarAssembly {
    
    func createListCurrenciesViewController() -> UIViewController {
        let vc = ListCurrenciesViewController()
        let image = UIImage(systemName: "dollarsign.arrow.circlepath")
        vc.tabBarItem = UITabBarItem(title: "List",
                                     image: image,
                                     tag: 0)
        
        return UINavigationController(rootViewController: vc)
    }
    
    func createCurrencyConverterViewController() -> UIViewController {
        let vc = CurrencyConverterViewController()
        let image = UIImage(systemName: "arrow.triangle.2.circlepath.circle")
        vc.tabBarItem = UITabBarItem(title: "Exchange",
                                     image: image,
                                     tag: 1)
        
        return UINavigationController(rootViewController: vc)
    }
    
    func createCurrencySelectionViewController() -> UIViewController {
        let vc = CurrencySelectionViewController()
        let image = UIImage(systemName: "arrow.triangle.2.circlepath.circle")
        vc.tabBarItem = UITabBarItem(title: "exchange",
                                     image: image,
                                     tag: 2)
        
        return UINavigationController(rootViewController: vc)
    }
    
    func createFavoriteCurrenciesViewController() -> UIViewController {
        let vc = FavoriteCurrenciesViewController()
        let image = UIImage(systemName: "heart")
        vc.tabBarItem = UITabBarItem(title: "Favorite",
                                     image: image,
                                     tag: 3)
        
        return UINavigationController(rootViewController: vc)
    }
}
