//
//  CurrencyConverterView.swift
//  CurrencyConverter
//
//  Created by pavel mishanin on 08.09.2022.
//

import UIKit

final class CurrencyConverterView: UIView {
    
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.makeConstraints()
    }
}

extension CurrencyConverterView {
    
    func reloadData() {
        self.tableView.reloadData()
    }
}

// MARK: - Config Appearance
private extension CurrencyConverterView {
    
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
        self.layout.minimumInteritemSpacing = 1
        self.layout.minimumLineSpacing = 1
    }
    
    func configCollectionView() {
        self.collectionView.backgroundColor = .white
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.register(CurrencyConverterCalculatorCell.self,
                                     forCellWithReuseIdentifier: CurrencyConverterCalculatorCell.id)
        self.collectionView.accessibilityIdentifier = "CurrencyConverterCollectionView"
    }
    
    func configTableView() {
        self.tableView.backgroundColor = .white
        self.tableView.register(CurrencyConverterTableCell.self,
                                forCellReuseIdentifier: CurrencyConverterTableCell.id)
        self.tableView.accessibilityIdentifier = "CurrencyConverterTableView"
    }
}

// MARK: - Make Constraints
private extension CurrencyConverterView {
    
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
            self.collectionView.heightAnchor.constraint(equalToConstant: self.frame.width),
            self.collectionView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    func makeTableViewConstraints() {
        self.addSubview(self.tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.tableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            self.tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.collectionView.topAnchor)
        ])
    }
}
