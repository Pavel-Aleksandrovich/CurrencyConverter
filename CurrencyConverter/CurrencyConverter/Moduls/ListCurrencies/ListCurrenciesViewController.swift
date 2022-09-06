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

enum TypeCurrencies: String, CaseIterable {
    case list = "List"
    case favorite = "Favorite"
}

final class ListCurrenciesViewController: UIViewController {

    private let presenter: IListCurrenciesPresenter
    private let tableView = UITableView()
    private let layout = UICollectionViewFlowLayout()
    private lazy var collectionView = UICollectionView(frame: .zero,
                                                       collectionViewLayout: self.layout)
    
    var onFavoriteButtonTappedHandler: ((RequestFavoriteCurrencyModel) -> ())?
    var onCollectionCellTappedHandler: ((Int) -> ())?
    
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
        
        self.view.addSubview(self.collectionView)
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        self.layout.minimumInteritemSpacing = 0
        self.layout.minimumLineSpacing = 0
    
        self.collectionView.backgroundColor = .clear
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.register(CollectionCell.self,
                                     forCellWithReuseIdentifier: CollectionCell.id)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.selectItem(at: [0, 0],
                                       animated: true,
                                       scrollPosition: [])
        
        NSLayoutConstraint.activate([
            self.collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.collectionView.heightAnchor.constraint(equalToConstant: 50),
        ])
        
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
            self.tableView.topAnchor.constraint(equalTo: self.collectionView.bottomAnchor,constant: 10),
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListCurrenciesCell.id,
                                                       for: indexPath) as? ListCurrenciesCell
        else { return UITableViewCell() }
        
        let model = self.presenter.getModelByIndex(indexPath.row)
        cell.setViewModel(model)
        
        cell.onFavoriteImageTappedHandler = {
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
}

extension ListCurrenciesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2,
                      height: collectionView.frame.height)
    }
}

extension ListCurrenciesViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        self.onCollectionCellTappedHandler?(indexPath.row)
    }
}

extension ListCurrenciesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return TypeCurrencies.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CollectionCell.id,
            for: indexPath) as? CollectionCell
        else { return UICollectionViewCell() }
        
        let type = TypeCurrencies.allCases[indexPath.row]
        cell.setData(type)
        
        return cell
    }
}
