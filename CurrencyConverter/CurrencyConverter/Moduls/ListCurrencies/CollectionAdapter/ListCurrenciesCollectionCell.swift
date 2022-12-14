//
//  CollectionCell.swift
//  CurrencyConverter
//
//  Created by pavel mishanin on 06.09.2022.
//

import UIKit

final class ListCurrenciesCollectionCell: UICollectionViewCell {
    
    static let id = String(describing: ListCurrenciesCollectionCell.self)
    
    private let titleLabel = UILabel()
    private let indicatorView = UIView()
    
    override var isSelected: Bool {
        didSet {
            self.configIndicatorView()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configAppearance()
        self.makeConstraints()
        self.configIndicatorView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ListCurrenciesCollectionCell {
    
    func setData(_ data: TypeCurrencies) {
        self.titleLabel.text = data.rawValue
    }
}

// MARK: - Config Appearance
private extension ListCurrenciesCollectionCell {
    
    func configAppearance() {
        self.configTitleLabel()
    }
    
    func configTitleLabel() {
        self.titleLabel.textAlignment = .center
        self.titleLabel.font = UIFont(name: Fonts.bold.rawValue, size: 30)
    }
}

// MARK: - Make Constraints
private extension ListCurrenciesCollectionCell {
    
    func makeConstraints() {
        self.makeIndicatorViewConstraints()
        self.makeTitleLabelConstraints()
    }
    
    func makeIndicatorViewConstraints() {
        self.addSubview(self.indicatorView)
        self.indicatorView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.indicatorView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.indicatorView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.indicatorView.heightAnchor.constraint(equalToConstant: 3),
            self.indicatorView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    func makeTitleLabelConstraints() {
        self.addSubview(self.titleLabel)
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            self.titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}

private extension ListCurrenciesCollectionCell {
    
    func configIndicatorView() {
        if self.isSelected {
            self.indicatorView.backgroundColor = .black
            self.titleLabel.textColor = .black
        } else {
            self.indicatorView.backgroundColor = .systemGray6
            self.titleLabel.textColor = .systemGray2
        }
    }
}
