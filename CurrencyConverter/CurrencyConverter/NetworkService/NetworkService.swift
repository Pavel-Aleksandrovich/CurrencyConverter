//
//  RequestSender.swift
//  CurrencyConverter
//
//  Created by pavel mishanin on 31.08.2022.
//

import Foundation

protocol INetworkService {
    func loadData(completion: @escaping(Result<Data, NetworkError>) -> ())
}

final class NetworkService {
    
    private let session = URLSession.shared
}

extension NetworkService: INetworkService {
    
    func loadData(completion: @escaping(Result<Data, NetworkError>) -> ()) {
        
        guard let url = URL(string: "http://www.cbr.ru/scripts/XML_daily.asp") else {
            completion(.failure(.invalidURL))
            return }
        
        let request = URLRequest(url: url, timeoutInterval: 30)
        
        self.session.dataTask(with: request) { data, response, error in
            
            if error != nil {
                completion(.failure(.networkError))
                return
            }
            
            if let data = data {
                completion(.success(data))
            } else {
                completion(.failure(.dataError))
            }
        }.resume()
    }
}
