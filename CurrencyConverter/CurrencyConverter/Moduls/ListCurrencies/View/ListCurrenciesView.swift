//
//  ListCurrenciesView.swift
//  CurrencyConverter
//
//  Created by pavel mishanin on 07.09.2022.
//

import UIKit

final class ListCurrenciesView: UIView {
    
    private let tableView = UITableView()
    private let layout = UICollectionViewFlowLayout()
    private lazy var collectionView = UICollectionView(frame: .zero,
                                                       collectionViewLayout: self.layout)
    
    var tableViewDelegate: UITableViewDelegate? {
        get {
            nil
        }
        set {
            self.tableView.delegate = newValue
        }
    }
    
    var tableViewDataSource: UITableViewDataSource? {
        get {
            nil
        }
        set {
            self.tableView.dataSource = newValue
        }
    }
    
    var collectionViewDelegate: UICollectionViewDelegate? {
        get {
            nil
        }
        set {
            self.collectionView.delegate = newValue
        }
    }
    
    var collectionViewDataSource: UICollectionViewDataSource? {
        get {
            nil
        }
        set {
            self.collectionView.dataSource = newValue
        }
    }
    
    init() {
        super.init(frame: .zero)
        self.configAppearance()
        self.makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ListCurrenciesView {
    
    func reloadData() {
        self.tableView.reloadData()
    }
}

// MARK: - Config Appearance
private extension ListCurrenciesView {
    
    func configAppearance() {
        self.configView()
        self.configLayout()
        self.configCollectionView()
        self.configTableView()
    }
    
    func configView() {
        self.backgroundColor = .white
    }
    
    func configLayout() {
        self.layout.minimumInteritemSpacing = 0
        self.layout.minimumLineSpacing = 0
    }
    
    func configCollectionView() {
        self.collectionView.backgroundColor = .clear
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.register(ListCurrenciesCollectionCell.self,
                                     forCellWithReuseIdentifier: ListCurrenciesCollectionCell.id)
        self.collectionView.accessibilityIdentifier = "ListCurrenciesCollectionView"
    }
    
    func configTableView() {
        self.tableView.backgroundColor = .clear
        self.tableView.separatorStyle = .none
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.register(ListCurrenciesTableCell.self,
                                forCellReuseIdentifier: ListCurrenciesTableCell.id)
        self.tableView.accessibilityIdentifier = "ListCurrenciesTableView"
    }
}

// MARK: - Make Constraints
private extension ListCurrenciesView {
    
    func makeConstraints() {
        self.makeCollectionViewConstraints()
        self.makeTableViewConstraints()
    }
    
    func makeCollectionViewConstraints() {
        self.addSubview(self.collectionView)
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.collectionView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            self.collectionView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.collectionView.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    func makeTableViewConstraints() {
        self.addSubview(self.tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.tableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            self.tableView.topAnchor.constraint(equalTo: self.collectionView.bottomAnchor,constant: 10),
            self.tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
