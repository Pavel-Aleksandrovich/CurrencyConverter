//
//  CurrencyConverterCell.swift
//  CurrencyConverter
//
//  Created by pavel mishanin on 30.08.2022.
//

import UIKit

enum Fonts: String {
    case bold = "HelveticaNeue-Bold"
}
final class CurrencyConverterCell: UITableViewCell {
    
    static let id = String(describing: CurrencyConverterCell.self)
    
    private let numberLabel = UILabel()
    private let currencyImageView = UIImageView()
    private let charCodeLabel = UILabel()
    var textFieldHandler: ((String?) -> ())?
    var onSelectCurrencyTappedHandler: (() -> ())?
    
    var textField = "" {
        didSet {
            if self.textField != oldValue {
//                self.textFieldHandler?(self.numberLabel.text)
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.currencyImageView.layer.cornerRadius = 30
        self.currencyImageView.clipsToBounds = true
        self.currencyImageView.layer.borderWidth = 1
        self.currencyImageView.layer.borderColor = UIColor.darkGray.cgColor
        self.currencyImageView.contentMode = .scaleAspectFill
        
        self.contentView.addSubview(self.currencyImageView)
        self.currencyImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.currencyImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            self.currencyImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            self.currencyImageView.heightAnchor.constraint(equalToConstant: 60),
            self.currencyImageView.widthAnchor.constraint(equalToConstant: 60 )
        ])
        
        self.charCodeLabel.textAlignment = .center
        self.charCodeLabel.font = UIFont(name: Fonts.bold.rawValue, size: 18)
        self.charCodeLabel.textColor = .systemGray
        
        self.addSubview(self.charCodeLabel)
        self.charCodeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.charCodeLabel.centerXAnchor.constraint(equalTo: self.currencyImageView.centerXAnchor),
            self.charCodeLabel.topAnchor.constraint(equalTo: self.currencyImageView.bottomAnchor, constant: 2),
            self.charCodeLabel.widthAnchor.constraint(equalToConstant: 70)
        ])
        
        self.numberLabel.textAlignment = .right
        self.numberLabel.textColor = .darkGray
        
        self.addSubview(self.numberLabel)
        self.numberLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.numberLabel.leadingAnchor.constraint(equalTo: self.currencyImageView.trailingAnchor, constant: 5),
            self.numberLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            self.numberLabel.topAnchor.constraint(equalTo: self.topAnchor),
            self.numberLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
        
        self.currencyImageView.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer()
        self.currencyImageView.addGestureRecognizer(tapGesture)
        tapGesture.addTarget(self,
                             action: #selector
                             (self.tap))
        
        self.configAppearance()
        
        self.currencyImageView.contentMode = .scaleAspectFill
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func tap() {
        self.onSelectCurrencyTappedHandler?()
    }
}

extension CurrencyConverterCell {
    
    func setViewModel(_ model: CurrencyConverterViewModel?) {
        if let model = model {
            self.charCodeLabel.text = model.charCode
            self.currencyImageView.image = UIImage(named: model.charCode)
        } else {
            self.currencyImageView.image = UIImage(systemName: "flag.slash.fill")
        }
    }
    
    func setTextFieldValue(_ value: String) {
        self.numberLabel.text = value
        self.textField = value
        
        self.numberLabel.font = UIFont.boldSystemFont(ofSize: 55)
        
        if numberLabel.frame.width < numberLabel.intrinsicContentSize.width {
            self.numberLabel.font = UIFont.boldSystemFont(ofSize: 30)
        }
    }
}

private extension CurrencyConverterCell {
    
    func configAppearance() {
    }
    
}

