//
//  GetEmojisRequest.swift
//  GitHubUsers
//
//  Created by Екатерина on 05.07.2022.
//

import Foundation

struct GetEmojisRequest: RequestProtocol {
    
    var urlRequest: URLRequest? {
        guard let stringUrl = URLProvider.gitHubEmojisApiPath,
              let url = URL(string: stringUrl + "?") else {
                  return nil
              }
        
        let request = URLRequest(url: url)
        return request
    }
}
