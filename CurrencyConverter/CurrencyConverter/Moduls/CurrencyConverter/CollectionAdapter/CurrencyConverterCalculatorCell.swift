//
//  CalculatorCollectionCell.swift
//  CurrencyConverter
//
//  Created by pavel mishanin on 05.09.2022.
//

import UIKit

final class CurrencyConverterCalculatorCell: UICollectionViewCell {
    
    static let id = String(describing: CurrencyConverterCalculatorCell.self)
    
    private let numberLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configAppearance()
        self.makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CurrencyConverterCalculatorCell {
    
    func setData(_ data: CalculatorButtons) {
        self.numberLabel.text = data.rawValue
        self.numberLabel.backgroundColor = data.color
    }
}

// MARK: - Config Appearance
private extension CurrencyConverterCalculatorCell {
    
    func configAppearance() {
        self.configNumberLabel()
    }
    
    func configNumberLabel() {
        self.numberLabel.textAlignment = .center
        self.numberLabel.font = UIFont.boldSystemFont(ofSize: 35)
        self.numberLabel.textColor = .white
    }
}

// MARK: - Make Constraints
private extension CurrencyConverterCalculatorCell {
    
    func makeConstraints() {
        self.makeNumberLabelConstraints()
    }
    
    func makeNumberLabelConstraints() {
        self.addSubview(self.numberLabel)
        self.numberLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.numberLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            self.numberLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            self.numberLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.numberLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}
