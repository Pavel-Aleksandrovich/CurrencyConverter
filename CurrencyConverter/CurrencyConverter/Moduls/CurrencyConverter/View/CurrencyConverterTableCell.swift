//
//  CurrencyConverterCell.swift
//  CurrencyConverter
//
//  Created by pavel mishanin on 30.08.2022.
//

import UIKit

final class CurrencyConverterTableCell: UITableViewCell {
    
    static let id = String(describing: CurrencyConverterTableCell.self)
    
    private let numberLabel = UILabel()
    private let currencyImageView = UIImageView()
    private let charCodeLabel = UILabel()
    
    var onSelectCurrencyTappedHandler: (() -> ())?
    
    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.makeConstraints()
        self.configAppearance()
    }
}

extension CurrencyConverterTableCell {
    
    func setViewModel(_ model: CurrencyConverterViewModel?) {
        if let model = model {
            self.charCodeLabel.text = model.charCode
            self.currencyImageView.image = UIImage(named: model.charCode)
        } else {
            self.currencyImageView.image = UIImage(systemName: "flag.slash.fill")
            self.charCodeLabel.text = ""
        }
    }
    
    func setTextFieldValue(_ value: String) {
        self.numberLabel.text = value
        self.numberLabel.font = UIFont.boldSystemFont(ofSize: 60)
        self.checkWhenLabelIsFull()
    }
}

// MARK: - Config Appearance
private extension CurrencyConverterTableCell {
    
    func configAppearance() {
        self.configTapGestureRecognizer()
        self.configNumberLabel()
        self.configCharCodeLabel()
        self.configcurrencyImageView()
    }
    
    func configTapGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer()
        self.currencyImageView.addGestureRecognizer(tapGesture)
        tapGesture.addTarget(self,
                             action: #selector
                             (self.onCurrencyImageViewTapped))
    }
    
    @objc func onCurrencyImageViewTapped() {
        self.onSelectCurrencyTappedHandler?()
    }
    
    func configNumberLabel() {
        self.numberLabel.textAlignment = .right
        self.numberLabel.textColor = .darkGray
    }
    
    func configCharCodeLabel() {
        self.charCodeLabel.textAlignment = .center
        self.charCodeLabel.font = UIFont(name: Fonts.bold.rawValue, size: 18)
        self.charCodeLabel.textColor = .systemGray
    }
    
    func configcurrencyImageView() {
        self.currencyImageView.clipsToBounds = true
        self.currencyImageView.layer.borderWidth = 1
        self.currencyImageView.layer.borderColor = UIColor.darkGray.cgColor
        self.currencyImageView.contentMode = .scaleAspectFill
        self.currencyImageView.isUserInteractionEnabled = true
        self.currencyImageView.layer.cornerRadius = (self.bounds.height/1.7)/2
        self.currencyImageView.accessibilityIdentifier = "Image"
    }
}

// MARK: - Make Constraints
private extension CurrencyConverterTableCell {
    
    func makeConstraints() {
        self.makeCurrencyImageViewConstraints()
        self.makeCharCodeLabelConstraints()
        self.makeNumberLabelConstraints()
    }
    
    func makeCurrencyImageViewConstraints() {
        self.contentView.addSubview(self.currencyImageView)
        self.currencyImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.currencyImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            self.currencyImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 2),
            self.currencyImageView.heightAnchor.constraint(equalToConstant: self.bounds.height/1.7),
            self.currencyImageView.widthAnchor.constraint(equalToConstant: self.bounds.height/1.7)
        ])
    }
    
    func makeCharCodeLabelConstraints() {
        self.addSubview(self.charCodeLabel)
        self.charCodeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.charCodeLabel.centerXAnchor.constraint(equalTo: self.currencyImageView.centerXAnchor),
            self.charCodeLabel.topAnchor.constraint(equalTo: self.currencyImageView.bottomAnchor, constant: 2),
            self.charCodeLabel.widthAnchor.constraint(equalToConstant: 70)
        ])
    }
    
    func makeNumberLabelConstraints() {
        self.addSubview(self.numberLabel)
        self.numberLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.numberLabel.leadingAnchor.constraint(equalTo: self.currencyImageView.trailingAnchor, constant: 5),
            self.numberLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            self.numberLabel.topAnchor.constraint(equalTo: self.topAnchor),
            self.numberLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}

private extension CurrencyConverterTableCell {
    
    func checkWhenLabelIsFull() {
        if self.numberLabel.frame.width < self.numberLabel.intrinsicContentSize.width {
            self.numberLabel.font = UIFont.boldSystemFont(ofSize: 25)
        }
    }
}
