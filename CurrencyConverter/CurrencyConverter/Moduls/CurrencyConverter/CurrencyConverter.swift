//
//  CurrencyConverter.swift
//  CurrencyConverter
//
//  Created by pavel mishanin on 07.09.2022.
//

import Foundation

protocol ICurrencyConverter: AnyObject {
    func removeLast(_ string: String) -> String
    func addValue(_ value: String, toString: String) -> String
    func addСomma(_ comma: String, toString: String) -> String
    func getNominal(x: Double, y: Double) -> Double
    func getFirstValue(value: Double, first: Double, second: Double) -> Double
    func getSecondValue(value: Double, first: Double, second: Double) -> Double
}

final class CurrencyConverter {}

extension CurrencyConverter: ICurrencyConverter {
    
    func removeLast(_ string: String) -> String {
        var string = string
        
        if string == "0,00" {
            return string
        }
        
        if string.isEmpty == false {
            string.removeLast()
        }
        
        return string
    }
    
    func addValue(_ value: String, toString: String) -> String {
        var toString = toString
        
        if toString == "0,00" {
            toString = ""
        }
        toString += value
        
        return toString
    }
    
    func addСomma(_ comma: String, toString: String) -> String {
        var toString = toString
        
        if toString.contains(comma) == false {
            toString += comma
        }
        
        return toString
    }
    
    func getNominal(x: Double, y: Double) -> Double {
        x / y
    }
    
    func getFirstValue(value: Double, first: Double, second: Double) -> Double {
        value * second / first
    }
    
    func getSecondValue(value: Double, first: Double, second: Double) -> Double {
        value * first / second
    }
}
