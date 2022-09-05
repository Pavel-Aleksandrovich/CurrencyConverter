//
//  CurrencySelectionViewController.swift
//  CurrencyConverter
//
//  Created by pavel mishanin on 30.08.2022.
//

import UIKit

protocol ICurrencySelectionViewController: AnyObject {
    var onCellTappedHandler: ((ResponseCurrencyModel) -> ())? { get set }
    func reloadData()
}

final class CurrencySelectionViewController: UIViewController {
    
    private let presenter: ICurrencySelectionPresenter
    private let tableView = UITableView()
    
    var onCellTappedHandler: ((ResponseCurrencyModel) -> ())?
    
    init(presenter: ICurrencySelectionPresenter) {
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
        self.tableView.register(CurrencySelectionCell.self,
                                        forCellReuseIdentifier: CurrencySelectionCell.id)
        
        self.view.addSubview(self.tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
        ])
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
        self.tableView.reloadData()
    }
}

extension CurrencySelectionViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        self.presenter.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrencySelectionCell.id,
                                                       for: indexPath) as? CurrencySelectionCell
        else { return UITableViewCell() }
        
        let model = self.presenter.getModelByIndex(indexPath.row)
        cell.setViewModel(model)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = self.presenter.getModelByIndex(indexPath.row)
        self.onCellTappedHandler?(model)
    }
}
