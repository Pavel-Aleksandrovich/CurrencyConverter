////
////  NetworkService.swift
////  CurrencyConverter
////
////  Created by pavel mishanin on 30.08.2022.
////
//
//import Foundation
//
//
//protocol INetworkService: AnyObject {
//    func loadData(complition: @escaping (Result<CurrencyDTO, Error>) -> ())
//}
//
//final class NetworkService {}
//
//extension NetworkService: INetworkService {
//
//    func loadData(complition: @escaping (Result<CurrencyDTO, Error>) -> ()) {
//        guard let url = URL(string: "https://www.cbr.ru/scripts/XML_daily.asp") else { assert(false)}
//        let request = URLRequest(url: url)
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            if let error = error {
//                complition(.failure(error))
//            }
//            guard let data = data else { return }
//            do {
//                
////                let newData = try XMLDecoder().decode(CurrencyDTO.self, from: data)
////                complition(.success(newData))
//            }
//            catch let error {
//                complition(.failure(error))
//            }
//        }.resume()
//    }
//}
//
//struct CurrencyDTO: Codable {
//    let valute: [Valute]
//    
//    enum CodingKeys: String, CodingKey {
//        case valute = "Valute"
//    }
//}
//
//struct Valute: Codable {
//    let numCode, charCode, nominal, name: String
//    let value, id: String
//    
//    enum CodingKeys: String, CodingKey {
//        case numCode = "NumCode"
//        case charCode = "CharCode"
//        case nominal = "Nominal"
//        case name = "Name"
//        case value = "Value"
//        case id = "ID"
//    }
//}
//
//class CurrencyXMLParser : NSObject, XMLParserDelegate {
//    
//    // Private Properties:
//    private let xmlURL = "www.cbr.ru/scripts/XML_daily.asp"
////    private var exchangeRates : [CurrencyDTO : Double] = [
////        .EUR : 1.0 // Base currency
////    ]
////
////    // Public Methods:
////    public func getExchangeRates() -> [CurrencyDTO : Double] {
////        return exchangeRates
////    }
//    
//    public func parse(completion : @escaping () -> Void, errorCompletion : @escaping () -> Void) {
//        guard let url = URL(string: xmlURL) else { return }
//        let task = URLSession.shared.dataTask(with: url) { data, response, error in
//            guard let data = data, error == nil else {
//                print("Failed to parse the XML!")
//                print(error ?? "Unknown error")
//                errorCompletion()
//                return
//            }
//            let parser = XMLParser(data: data)
//            parser.delegate = self
//            if parser.parse() {
//                completion()
//            } else {
//                errorCompletion()
//            }
//        }
//        task.resume()
//    }
//    
//    // Private Methods:
////    private func makeExchangeRate(currency : String, rate : String) -> (currency : Currency, rate : Double)? {
////        guard let currency = Currency(rawValue: currency) else { return nil }
////        guard let rate = Double(rate) else { return nil }
////        return (currency, rate)
////    }
//    
//    // XML Parse Methods (from XMLParserDelegate):
////    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
////        if elementName == "Cube"{
////            guard let currency = attributeDict["currency"] else { return }
////            guard let rate = attributeDict["rate"] else { return }
////            guard let exchangeRate = makeExchangeRate(currency: currency, rate: rate) else { return }
////            exchangeRates.updateValue(exchangeRate.rate, forKey: exchangeRate.currency)
////        }
////    }
//    
//}
