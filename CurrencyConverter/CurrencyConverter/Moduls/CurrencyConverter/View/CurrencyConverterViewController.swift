//
//  CurrencyConverterViewController.swift
//  CurrencyConverter
//
//  Created by pavel mishanin on 30.08.2022.
//

import UIKit

protocol ICurrencyConverterViewController: AnyObject {
    var onCellTappedHandler: ((Int) -> ())? { get set }
    var onSelectCurrencyTappedHandler: ((Int) -> ())? { get set }
    var onCalculatorCellTappedHandler: ((Int) -> ())? { get set }
    func reloadData()
}

final class CurrencyConverterViewController: UIViewController {
    
    private let presenter: ICurrencyConverterPresenter
    private let mainView = CurrencyConverterView()
    private lazy var collectionAdapter = CurrencyConverterCollectionAdapter
    { [ weak self ] index in self?.onCalculatorCellTappedHandler?(index) }
    
    var onSelectCurrencyTappedHandler: ((Int) -> ())?
    var onCalculatorCellTappedHandler: ((Int) -> ())?
    var onCellTappedHandler: ((Int) -> ())?
    
    init(presenter: ICurrencyConverterPresenter) {
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

extension CurrencyConverterViewController: ICurrencyConverterViewController {
    
    func reloadData() {
        self.mainView.reloadData()
    }
}

extension CurrencyConverterViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.frame.height/2
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        self.presenter.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyConverterTableCell.id,
                                                       for: indexPath) as? CurrencyConverterTableCell
        else { return UITableViewCell() }
        
        let value = self.presenter.getCurrencyValueByIndex(indexPath.row)
        cell.setTextFieldValue(value)
        
        let model = self.presenter.getCurrencyModelByIndex(indexPath.row)
        cell.setViewModel(model)
        
        cell.onSelectCurrencyTappedHandler = {
            self.onSelectCurrencyTappedHandler?(indexPath.row)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.onCellTappedHandler?(indexPath.row)
    }
}
