//
//  RequestSender.swift
//  GitHubUsers
//
//  Created by Екатерина on 05.07.2022.
//

import Foundation

class RequestSender: RequestSenderProtocol {
   
   let session = URLSession.shared
   
   func send<Parser>(config: RequestConfig<Parser>,
                     competionHandler: @escaping (Result<Parser.Model, Error>) -> Void) {
       guard let urlRequest = config.request.urlRequest else {
           competionHandler(.failure(NetworkError.badURL))
           return
       }
       let task = session.dataTask(with: urlRequest) { (data: Data?, response: URLResponse?, error: Error?) in
           if let error = error {
               print(response.debugDescription)
               competionHandler(.failure(error))
               return
           }
           print(response.debugDescription)
           guard let data = data,
                 let parsedModel: Parser.Model = config.parser.parse(data: data) else {
                     competionHandler(.failure(NetworkError.parsingError))
                     return
                 }
           competionHandler(.success(parsedModel))
       }
       task.resume()
   }
   
}
