//
//  NetworkError.swift
//  CurrencyConverter
//
//  Created by pavel mishanin on 31.08.2022.
//

import Foundation

enum NetworkError: String, Error {
    case invalidURL = "Неправильно указан URL"
    case parseError = "Ошибка парсинга данных"
    case networkError = "Ошибка сети"
    case statusCodeError = "Ошибка получения кода статуса"
    case serverError = "Сервер недоступен или используется неправильный адрес"
    case requestError = "Ссылка устарела или произошла ошибка запроса данных"
    case unownedError = "Неизвестная ошибка"
}
