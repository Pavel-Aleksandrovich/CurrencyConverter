//
//  NetworkError.swift
//  CurrencyConverter
//
//  Created by pavel mishanin on 31.08.2022.
//

import Foundation

enum NetworkError: String, Error {
    case invalidURL = "Неправильно указан URL"
    case dataError = "Data nil"
    case networkError = "Ошибка сети"
}
