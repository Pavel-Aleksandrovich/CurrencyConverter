//
//  ListCurrenciesCell.swift
//  CurrencyConverter
//
//  Created by pavel mishanin on 30.08.2022.
//

import UIKit

final class ListCurrenciesCell: UITableViewCell {
    
    static let id = String(describing: ListCurrenciesCell.self)
    
    private let currencyNameLabel = UILabel()
    private let charCodeLabel = UILabel()
    private let flagImageView = UIImageView()
    private let favoriteImageView = UIImageView()
    
    var onFavoriteImageTappedHandler: (() -> ())?
    
    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        
        self.flagImageView.clipsToBounds = true
        self.flagImageView.layer.borderWidth = 1
        self.flagImageView.layer.cornerRadius = 25
        self.flagImageView.layer.borderColor = UIColor.darkGray.cgColor
        self.flagImageView.contentMode = .scaleAspectFill
        
        self.addSubview(self.flagImageView)
        self.flagImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.flagImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            self.flagImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            self.flagImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            self.flagImageView.widthAnchor.constraint(equalToConstant: 55 )
        ])
        
        self.favoriteImageView.tintColor = .darkGray
        self.favoriteImageView.contentMode = .scaleAspectFill
        
        self.contentView.addSubview(self.favoriteImageView)
        self.favoriteImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.favoriteImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            self.favoriteImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            self.favoriteImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15),
            self.favoriteImageView.widthAnchor.constraint(equalToConstant: self.bounds.height - 10)
        ])
        
        self.charCodeLabel.font = UIFont(name: Fonts.bold.rawValue, size: 18)
        self.charCodeLabel.textColor = .systemGray
        
        self.addSubview(self.charCodeLabel)
        self.charCodeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.charCodeLabel.leadingAnchor.constraint(equalTo: self.flagImageView.trailingAnchor, constant: 5),
            self.charCodeLabel.trailingAnchor.constraint(equalTo: self.favoriteImageView.leadingAnchor),
            self.charCodeLabel.topAnchor.constraint(equalTo: self.topAnchor),
            self.charCodeLabel.bottomAnchor.constraint(equalTo: self.centerYAnchor),
        ])
        
        self.currencyNameLabel.font = UIFont.boldSystemFont(ofSize: 19)
        
        self.addSubview(self.currencyNameLabel)
        self.currencyNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.currencyNameLabel.leadingAnchor.constraint(equalTo: self.flagImageView.trailingAnchor, constant: 5),
            self.currencyNameLabel.trailingAnchor.constraint(equalTo: self.favoriteImageView.leadingAnchor),
            self.currencyNameLabel.topAnchor.constraint(equalTo: self.centerYAnchor),
            self.currencyNameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
        
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector
                                                (self.onFavoriteImageTapped))
        self.favoriteImageView.addGestureRecognizer(tapGesture)
        self.favoriteImageView.isUserInteractionEnabled = true
    }
    
    @objc func onFavoriteImageTapped() {
        self.onFavoriteImageTappedHandler?()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ListCurrenciesCell {
    
    func setViewModel(_ model: ResponseCurrencyModel) {
        self.currencyNameLabel.text = model.name
        self.flagImageView.image = UIImage(named: model.charCode)
        self.charCodeLabel.text = model.charCode
        
        if model.isFavorite {
            self.favoriteImageView.image = UIImage(systemName: "heart.fill")
        } else {
            self.favoriteImageView.image = UIImage(systemName: "heart")
        }
    }
}

private extension ListCurrenciesCell {
    
}


