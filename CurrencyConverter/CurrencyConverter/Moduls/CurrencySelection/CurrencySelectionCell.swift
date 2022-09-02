//
//  CurrencySelectionCell.swift
//  CurrencyConverter
//
//  Created by pavel mishanin on 02.09.2022.
//

import UIKit

final class CurrencySelectionCell: UITableViewCell {
    
    static let id = String(describing: CurrencySelectionCell.self)
    
    private let currencyNameLabel = UILabel()
    private let charCodeLabel = UILabel()
    private let flagImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        
        self.flagImageView.clipsToBounds = true
        self.flagImageView.layer.borderWidth = 1
        self.flagImageView.layer.borderColor = UIColor.red.cgColor
        self.flagImageView.contentMode = .scaleAspectFill
        
        self.addSubview(self.flagImageView)
        self.flagImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.flagImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            self.flagImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            self.flagImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            self.flagImageView.widthAnchor.constraint(equalToConstant: self.bounds.height )
        ])
        
        self.addSubview(self.charCodeLabel)
        self.charCodeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.charCodeLabel.leadingAnchor.constraint(equalTo: self.flagImageView.trailingAnchor, constant: 5),
            self.charCodeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.charCodeLabel.topAnchor.constraint(equalTo: self.topAnchor),
            self.charCodeLabel.bottomAnchor.constraint(equalTo: self.centerYAnchor),
        ])
        
        self.addSubview(self.currencyNameLabel)
        self.currencyNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.currencyNameLabel.leadingAnchor.constraint(equalTo: self.flagImageView.trailingAnchor, constant: 5),
            self.currencyNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.currencyNameLabel.topAnchor.constraint(equalTo: self.centerYAnchor),
            self.currencyNameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.flagImageView.layer.cornerRadius = self.bounds.height/2 - 5
    }
}

extension CurrencySelectionCell {
    
    func setViewModel(_ model: ResponseCurrencyModel) {
        self.currencyNameLabel.text = model.name
        self.flagImageView.image = UIImage(named: model.charCode)
        self.charCodeLabel.text = model.charCode
    }
}

private extension CurrencySelectionCell {
    
}
