//
//  CalculatorButtons.swift
//  CurrencyConverter
//
//  Created by pavel mishanin on 08.09.2022.
//

import UIKit

enum CalculatorButtons: String, CaseIterable {
    case one = "1"
    case o2ne = "2"
    case o3ne = "3"
    case o4ne = "←"
    case o5ne = "4"
    case o6ne = "5"
    case o7ne = "6"
    case o8ne = "↑↓"
    case o9ne = "7"
    case o10ne = "8"
    case o11ne = "9"
    case o12ne = "C"
    case o13ne = "0"
    case o14ne = ","
    
    var color: UIColor {
        switch self {
        case .o4ne: return UIColor.orange
        case .o8ne: return UIColor.orange
        case .o12ne: return UIColor.orange
        case .o14ne: return UIColor.orange
        default : return UIColor.systemGray
        }
    }
}
