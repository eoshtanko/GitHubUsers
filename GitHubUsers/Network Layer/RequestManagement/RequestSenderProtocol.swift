//
//  RequestSenderProtocol.swift
//  GitHubUsers
//
//  Created by Екатерина on 05.07.2022.
//

import Foundation

protocol RequestSenderProtocol {
    func send<Parser>(config: RequestConfig<Parser>, competionHandler: @escaping (Result<Parser.Model, Error>) -> Void)
}
