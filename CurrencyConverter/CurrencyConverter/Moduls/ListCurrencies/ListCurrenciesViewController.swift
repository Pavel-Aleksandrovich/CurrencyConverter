//
//  ListCurrenciesViewController.swift
//  CurrencyConverter
//
//  Created by pavel mishanin on 30.08.2022.
//

import UIKit

protocol IListCurrenciesViewController: AnyObject {
    var onFavoriteButtonTappedHandler: ((RequestFavoriteCurrencyModel) -> ())? { get set }
    func reloadData()
}

final class ListCurrenciesViewController: UIViewController {

    private let presenter: IListCurrenciesPresenter
    private let tableView = UITableView()
    
    var onFavoriteButtonTappedHandler: ((RequestFavoriteCurrencyModel) -> ())?
    
    init(presenter: IListCurrenciesPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.onViewAttached(controller: self)
        
        self.view.backgroundColor = .white
        
        self.tableView.separatorStyle = .none
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(ListCurrenciesCell.self,
                                        forCellReuseIdentifier: ListCurrenciesCell.id)
        
        self.view.addSubview(self.tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

extension ListCurrenciesViewController: IListCurrenciesViewController {
    
    func reloadData() {
        self.tableView.reloadData()
    }
}

extension ListCurrenciesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        self.presenter.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListCurrenciesCell.id,
                                                       for: indexPath) as? ListCurrenciesCell
        else { return UITableViewCell() }
        
        let model = self.presenter.getModelByIndex(indexPath.row)
        cell.setViewModel(model)
        
        cell.comple = {
            let model = self.presenter.getModelByIndex(indexPath.row)
            let request = RequestFavoriteCurrencyModel(id: model.id,
                                                       name: model.name,
                                                       isFavorite: !model.isFavorite,
                                                       charCode: model.charCode,
                                                       nominal: model.nominal,
                                                       valueRub: model.valueRub)
            self.onFavoriteButtonTappedHandler?(request)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
}
