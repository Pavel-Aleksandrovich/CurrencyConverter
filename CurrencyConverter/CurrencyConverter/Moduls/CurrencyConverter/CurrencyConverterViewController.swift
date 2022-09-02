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
    var onSelectCurrencyTappedHandler: (() -> ())? { get set }
    func reloadData()
}

final class CurrencyConverterViewController: UIViewController {
    
    private let presenter: ICurrencyConverterPresenter
    private let tableView = UITableView()
    
    var onSelectCurrencyTappedHandler: (() -> ())?
    
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
        
        switch self.presenter.getCurrencyTypeByIndex(indexPath.row) {
        case .first:
            cell.setViewModel(.red)
            
            cell.textFieldHandler = { [ weak self ] number in
                self?.presenter.firstCurrencyDidChange(value: number)
            }
        case .second:
            cell.setViewModel(.blue)
            let value = self.presenter.getTextFieldValue()
            cell.setTextFieldValue(value)
            cell.textFieldHandler = { number in
                
                print(number)
            }
        }
        
        
        cell.onSelectCurrencyTappedHandler = {
            self.onSelectCurrencyTappedHandler?()
            print(indexPath.row)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch self.presenter.getCurrencyTypeByIndex(indexPath.row) {
        case .first:
            print("first")
        case .second:
            print("second")
        }
    }
}
