//
//  CurrencyConverterCell.swift
//  CurrencyConverter
//
//  Created by pavel mishanin on 30.08.2022.
//

import UIKit

final class CurrencyConverterCell: UITableViewCell {
    
    static let id = String(describing: CurrencyConverterCell.self)
    
    private let numberTextField = UITextField()
    private let currencyImageView = UIImageView()
    private let charCodeLabel = UILabel()
    var textFieldHandler: ((String?) -> ())?
    var onSelectCurrencyTappedHandler: (() -> ())?
    
    var textField = "" {
        didSet {
            if self.textField != oldValue {
                self.textFieldHandler?(self.numberTextField.text)
            }
            
        }
    }
    
    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.currencyImageView.layer.cornerRadius = 25
        self.currencyImageView.clipsToBounds = true
        self.currencyImageView.layer.borderWidth = 1
        self.currencyImageView.layer.borderColor = UIColor.red.cgColor
        self.currencyImageView.contentMode = .scaleAspectFill
        
        self.contentView.addSubview(self.currencyImageView)
        self.currencyImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.currencyImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.currencyImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            self.currencyImageView.heightAnchor.constraint(equalToConstant: 50),
            self.currencyImageView.widthAnchor.constraint(equalToConstant: 50 )
        ])
        
        self.charCodeLabel.textAlignment = .center
        
        self.addSubview(self.charCodeLabel)
        self.charCodeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.charCodeLabel.centerXAnchor.constraint(equalTo: self.currencyImageView.centerXAnchor),
            self.charCodeLabel.topAnchor.constraint(equalTo: self.currencyImageView.bottomAnchor, constant: 5),
            self.charCodeLabel.widthAnchor.constraint(equalToConstant: 70)
        ])
        
        self.numberTextField.textAlignment = .right
        
        self.addSubview(self.numberTextField)
        self.numberTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.numberTextField.leadingAnchor.constraint(equalTo: self.currencyImageView.trailingAnchor, constant: 10),
            self.numberTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.numberTextField.topAnchor.constraint(equalTo: self.topAnchor),
            self.numberTextField.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
        
        self.currencyImageView.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer()
        self.currencyImageView.addGestureRecognizer(tapGesture)
        tapGesture.addTarget(self,
                             action: #selector
                             (self.tap))
        
        self.configAppearance()
        
        self.currencyImageView.contentMode = .scaleAspectFill
        
        self.numberTextField.becomeFirstResponder()
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
        self.numberTextField.text = value
        self.textField = value
    }
}

private extension CurrencyConverterCell {
    
    func configAppearance() {
        self.configTextField()
        self.configTapGesture()
    }
    
    func configTapGesture() {
        let tapGesture = UITapGestureRecognizer()
        self.addGestureRecognizer(tapGesture)
        tapGesture.addTarget(self,
                             action: #selector
                             (self.textFieldDidChange))
    }
    
    func configTextField() {
        self.numberTextField.placeholder = "Tap"
        self.numberTextField.keyboardType = .numberPad
        self.numberTextField.addTarget(self,
                                 action: #selector
                                 (self.textFieldEditingChanged),
                                 for: .editingChanged)
    }
    
    @objc func textFieldEditingChanged() {
        self.textFieldHandler?(self.numberTextField.text)
    }
    
    @objc func textFieldDidChange() {
        self.numberTextField.becomeFirstResponder()
    }
}

