//
//  CRBParser.swift
//  CurrencyConverter
//
//  Created by pavel mishanin on 31.08.2022.
//

import Foundation

protocol ICurrencyXMLParser {
    func parse(data: Data) -> [CurrencyDTO]
}

final class CurrencyXMLParser: NSObject {
    
    private var models: [CurrencyDTO] = []
    private var currency = String()
    private var charCode = String()
    private var nominal = String()
    private var name = String()
    private var value = String()
}

extension CurrencyXMLParser: ICurrencyXMLParser {
    
    func parse(data: Data) -> [CurrencyDTO] {
        let parser = XMLParser(data: data)
        parser.delegate = self
        parser.parse()
        
        return models
    }
}

extension CurrencyXMLParser: XMLParserDelegate {
    
    func parser(
        _ parser: XMLParser,
        didStartElement elementName: String,
        namespaceURI: String?,
        qualifiedName qName: String?,
        attributes attributeDict: [String : String] = [:]
    ) {
        currency = elementName
    }

    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        switch currency {
        case "CharCode":
            charCode = data
        case "Nominal":
            nominal = data
        case "Name":
            name = data
        case "Value":
            value = data
        default:
            break
        }
    }
    
    func parser(
        _ parser: XMLParser,
        didEndElement elementName: String,
        namespaceURI: String?,
        qualifiedName qName: String?
    ) {
        if elementName == "Valute" {
            let model = CurrencyDTO(
                charCode: charCode,
                nominal: nominal,
                name: name,
                valueRub: value
            )
            
            models.append(model)
        }
    }
}
