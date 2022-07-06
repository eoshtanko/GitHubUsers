//
//  GetAllUsersRequest.swift
//  GitHubUsers
//
//  Created by Екатерина on 05.07.2022.
//

import Foundation

struct GetUsersRequest: RequestProtocol {
    
    let since: Int
    
    init(since: Int) {
        self.since = since
    }
    
    var urlRequest: URLRequest? {
        let parametrs = ["since": "\(since)",
                         "per_page": "\(Const.usersPerPage)"]
        
        guard let stringUrl = URLProvider.imagesApiStringURL,
              let url = URL(string: stringUrl + paramsToString(params: parametrs)) else {
                  return nil
              }
        
        let request = URLRequest(url: url)
        return request
    }
    
    private enum Const {
        static let usersPerPage = 70
    }
}
