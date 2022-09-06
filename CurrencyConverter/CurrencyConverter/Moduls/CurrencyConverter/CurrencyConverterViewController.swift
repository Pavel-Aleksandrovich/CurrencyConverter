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

enum CalculatorType: String, CaseIterable {
    case one = "1"
    case o2ne = "2"
    case o3ne = "3"
    case o4ne = "←"
    case o5ne = "4"
    case o6ne = "5"
    case o7ne = "6"
    case o8ne = "↑↓"
    case o9ne = "7"
    case o10ne = "8"
    case o11ne = "9"
    case o12ne = "C"
    case o13ne = "0"
    case o14ne = ","
    
    var color: UIColor {
        switch self {
        case .o4ne: return UIColor.orange
        case .o8ne: return UIColor.orange
        case .o12ne: return UIColor.orange
        case .o14ne: return UIColor.orange
        default : return UIColor.systemGray
        }
    }
}

protocol ICurrencyConverterViewController: AnyObject {
    var onCellTappedHandler: ((Int) -> ())? { get set }
    var currencyTextFieldDidChangeHandler: ((Int, _ text: String?) -> ())? { get set }
    var onSelectCurrencyTappedHandler: ((Int) -> ())? { get set }
    var onCalculatorCellTappedHandler: ((Int) -> ())? { get set }
    func reloadData()
}

final class CurrencyConverterViewController: UIViewController {
    
    private let presenter: ICurrencyConverterPresenter
    private let tableView = UITableView()
    private let layout = UICollectionViewFlowLayout()
    private lazy var collectionView = UICollectionView(frame: .zero,
                                                       collectionViewLayout: self.layout)
    
    var currencyTextFieldDidChangeHandler: ((Int, _ text: String?) -> ())?
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.onViewAttached(controller: self)
        
        self.view.backgroundColor = .white
        
        self.tableView.backgroundColor = .darkGray
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(CurrencyConverterCell.self,
                                forCellReuseIdentifier: CurrencyConverterCell.id)
        
        
        
        self.view.addSubview(self.collectionView)
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        self.layout.minimumInteritemSpacing = 1
        self.layout.minimumLineSpacing = 1
    
        self.collectionView.backgroundColor = .clear
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.register(CalculatorCollectionCell.self,
                                     forCellWithReuseIdentifier: CalculatorCollectionCell.id)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        NSLayoutConstraint.activate([
            self.collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
//            self.collectionView.topAnchor.constraint(equalTo: self.tableView.bottomAnchor),
            self.collectionView.heightAnchor.constraint(equalToConstant: self.view.frame.width),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        self.view.addSubview(self.tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.collectionView.topAnchor)
//            self.tableView.heightAnchor.constraint(equalToConstant: 180),
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
        tableView.frame.height/2
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
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.onCellTappedHandler?(indexPath.row)
    }
}

extension CurrencyConverterViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if CalculatorType.allCases[indexPath.item] == .o13ne || CalculatorType.allCases[indexPath.item] == .o14ne {
            return CGSize(width: collectionView.frame.width/2 - 1,
                          height: collectionView.frame.height/4 - 1)
        }
        
        return CGSize(width: collectionView.frame.width/4 - 1,
                      height: collectionView.frame.height/4 - 1)
    }
}

extension CurrencyConverterViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        self.onCalculatorCellTappedHandler?(indexPath.item)
    }
}

extension CurrencyConverterViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return CalculatorType.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CalculatorCollectionCell.id,
            for: indexPath) as? CalculatorCollectionCell
        else { return UICollectionViewCell() }
        
        let type = CalculatorType.allCases[indexPath.row]
        cell.setData(type)
        return cell
    }
}
