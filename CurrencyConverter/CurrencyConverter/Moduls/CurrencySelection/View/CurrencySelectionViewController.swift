//
//  CurrencySelectionViewController.swift
//  CurrencyConverter
//
//  Created by pavel mishanin on 30.08.2022.
//

import UIKit

protocol ICurrencySelectionViewController: AnyObject {
    var onCellTappedHandler: ((ListCurrencyViewModel) -> ())? { get set }
    func reloadData()
}

final class CurrencySelectionViewController: UIViewController {
    
    private let presenter: ICurrencySelectionPresenter
    private let mainView = CurrencySelectionView()
    
    var onCellTappedHandler: ((ListCurrencyViewModel) -> ())?
    
    init(presenter: ICurrencySelectionPresenter) {
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
        self.mainView.tableViewDelegate = self
        self.mainView.tableViewDataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
}

extension CurrencySelectionViewController: ICurrencySelectionViewController {
    
    func reloadData() {
        self.mainView.reloadData()
    }
}

extension CurrencySelectionViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
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
        cell.favoriteImageView.isHidden = true
        cell.setViewModel(model)
        
        cell.accessibilityIdentifier = "\(indexPath.row)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = self.presenter.getModelByIndex(indexPath.row)
        self.onCellTappedHandler?(model)
    }
}
