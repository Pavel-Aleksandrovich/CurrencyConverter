//
//  ListCurrenciesViewController.swift
//  CurrencyConverter
//
//  Created by pavel mishanin on 30.08.2022.
//

import UIKit

protocol IListCurrenciesViewController: AnyObject {
    var onCollectionCellTappedHandler: ((Int) -> ())? { get set }
    var onFavoriteButtonTappedHandler: ((RequestFavoriteCurrencyModel) -> ())? { get set }
    func reloadData()
}

final class ListCurrenciesViewController: UIViewController {

    private let presenter: IListCurrenciesPresenter
    private let mainView = ListCurrenciesView()
    
    private lazy var collectionAdapter = ListCurrenciesCollectionAdapter
    { [ weak self ] index in self?.onCollectionCellTappedHandler?(index) }
    
    var onFavoriteButtonTappedHandler: ((RequestFavoriteCurrencyModel) -> ())?
    var onCollectionCellTappedHandler: ((Int) -> ())?
    
    init(presenter: IListCurrenciesPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = self.mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.onViewAttached(controller: self)
        
        self.mainView.collectionViewDataSource = self.collectionAdapter
        self.mainView.collectionViewDelegate = self.collectionAdapter
        self.mainView.tableViewDelegate = self
        self.mainView.tableViewDataSource = self
    }
}

extension ListCurrenciesViewController: IListCurrenciesViewController {
    
    func reloadData() {
        self.mainView.reloadData()
    }
}

extension ListCurrenciesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        self.presenter.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ListCurrenciesTableCell.id,
            for: indexPath) as? ListCurrenciesTableCell
        else { return UITableViewCell() }
        
        let model = self.presenter.getModelByIndex(indexPath.row)
        cell.setViewModel(model)
        
        cell.onFavoriteImageTappedHandler = {
            let model = self.presenter.getModelByIndex(indexPath.row)
            let request = RequestFavoriteCurrencyModel(model: model)
            self.onFavoriteButtonTappedHandler?(request)
        }
        
        cell.accessibilityIdentifier = "\(indexPath.row)"
        
        return cell
    }
}
