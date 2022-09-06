//
//  CalculatorCollectionCell.swift
//  CurrencyConverter
//
//  Created by pavel mishanin on 05.09.2022.
//

import UIKit

final class CalculatorCollectionCell: UICollectionViewCell {
    
    private enum Constants {
        static let cornerRadius: CGFloat = 5
    }
    
    static let id = String(describing: CalculatorCollectionCell.self)
    
    private let numberLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .magenta
        
        self.numberLabel.textAlignment = .center
        self.numberLabel.font = UIFont.boldSystemFont(ofSize: 30)
        self.numberLabel.textColor = .white
        
        self.addSubview(self.numberLabel)
        self.numberLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.numberLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            self.numberLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            self.numberLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.numberLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(_ data: CalculatorType) {
        self.numberLabel.text = data.rawValue
        self.numberLabel.backgroundColor = data.color
    }
}
