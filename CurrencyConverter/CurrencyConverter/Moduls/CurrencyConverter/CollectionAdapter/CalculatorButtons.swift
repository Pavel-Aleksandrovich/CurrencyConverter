//
//  CalculatorButtons.swift
//  CurrencyConverter
//
//  Created by pavel mishanin on 08.09.2022.
//

import UIKit

enum CalculatorButtons: String, CaseIterable {
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case removeLast = "←"
    case four = "4"
    case five = "5"
    case six = "6"
    case rotation = "↑↓"
    case one = "1"
    case two = "2"
    case three = "3"
    case removeAll = "C"
    case zero = "0"
    case comma = ","
    
    var color: UIColor {
        switch self {
        case .removeLast: return UIColor.orange
        case .rotation: return UIColor.orange
        case .removeAll: return UIColor.orange
        case .comma: return UIColor.orange
        default : return UIColor.systemGray
        }
    }
}
