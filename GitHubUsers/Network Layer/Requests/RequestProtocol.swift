//
//  RequestProtocol.swift
//  GitHubUsers
//
//  Created by Екатерина on 05.07.2022.
//

import Foundation

protocol RequestProtocol {
    var urlRequest: URLRequest? { get }
}

extension RequestProtocol {
    
    func paramsToString(params: [String: String]) -> String {
        let parameterArray = params.map { key, value in
            return "\(key)=\(value)"
        }
        
        return "?" + parameterArray.joined(separator: "&")
    }
}
