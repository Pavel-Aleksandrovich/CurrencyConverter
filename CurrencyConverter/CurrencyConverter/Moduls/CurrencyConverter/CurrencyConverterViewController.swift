//
//  CurrencyConverterViewController.swift
//  CurrencyConverter
//
//  Created by pavel mishanin on 30.08.2022.
//

import UIKit

enum CurrencyType: Int, CaseIterable {
    case first
    case second
}

protocol ICurrencyConverterViewController: AnyObject {
    var currencyTextFieldDidChangeHandler: ((Int, _ text: String?) -> ())? { get set }
    var onSelectCurrencyTappedHandler: ((Int) -> ())? { get set }
    func reloadData()
}

final class CurrencyConverterViewController: UIViewController {
    
    private let presenter: ICurrencyConverterPresenter
    private let tableView = UITableView()
    
    var currencyTextFieldDidChangeHandler: ((Int, _ text: String?) -> ())?
    var onSelectCurrencyTappedHandler: ((Int) -> ())?
    
    init(presenter: ICurrencyConverterPresenter) {
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
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(CurrencyConverterCell.self,
                                forCellReuseIdentifier: CurrencyConverterCell.id)
        
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

extension CurrencyConverterViewController: ICurrencyConverterViewController {
    
    func reloadData() {
        self.tableView.reloadData()
    }
}

extension CurrencyConverterViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        90
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        self.presenter.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyConverterCell.id,
                                                       for: indexPath) as? CurrencyConverterCell
        else { return UITableViewCell() }
        
        let value = self.presenter.foo(index: indexPath.row)
        cell.setTextFieldValue(value)
        
        let model = self.presenter.getCurrencyModelByIndex(indexPath.row)
        cell.setViewModel(model)
        
        cell.textFieldHandler = { text in
            self.currencyTextFieldDidChangeHandler?(indexPath.row, text)
        }
        
        cell.onSelectCurrencyTappedHandler = {
            self.onSelectCurrencyTappedHandler?(indexPath.row)
        }
        
        return cell
    }
}
