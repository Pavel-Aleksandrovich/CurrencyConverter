//
//  RequestSender.swift
//  CurrencyConverter
//
//  Created by pavel mishanin on 31.08.2022.
//

import Foundation

protocol IRequestSender {
    func send<Parser>(
        config: RequestConfig<Parser>,
        completionHandler: @escaping (Result<([Parser.Model], Data?, URLResponse?), NetworkError>) -> Void
    )
}

struct RequestConfig<Parser> where Parser: IParser {
    let request: IRequest
    let parser: Parser?
}

class RequestSender: IRequestSender {
    
    func send<Parser>(
        config: RequestConfig<Parser>,
        completionHandler: @escaping (Result<([Parser.Model], Data?, URLResponse?), NetworkError>) -> Void
    ) where Parser: IParser {
        guard let urlRequest = config.request.urlRequest else {
            completionHandler(.failure(.invalidURL))
            return
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                Logger.error(error.localizedDescription)
                completionHandler(.failure(.networkError))
                return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                completionHandler(.failure(.statusCodeError))
                return
            }
            
            if !(200..<300).contains(statusCode) {
                switch statusCode {
                case 400:
                    completionHandler(.failure(.requestError))
                case 500...:
                    completionHandler(.failure(.serverError))
                default:
                    Logger.warning(statusCode.description)
                    completionHandler(.failure(.unownedError))
                }
            }
            
            if let data = data,
               let parseModel: [Parser.Model] = config.parser?.parse(data: data) {
                print(parseModel.first)
                completionHandler(.success((parseModel, nil, nil)))
            } else {
                completionHandler(.failure(.parseError))
            }
        }
        task.resume()
    }
}

struct RequestFactory {
    struct CBRCurrencyRequest {
        static func modelConfig() -> RequestConfig<CRBParser> {
            let urlString = "http://www.cbr.ru/scripts/XML_daily.asp"
            let request = CRBRequest(urlString: urlString)
            let parser = CRBParser()
            
            return RequestConfig<CRBParser>(request: request, parser: parser)
        }
    }
}
