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
    
    private let selectView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .magenta
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
