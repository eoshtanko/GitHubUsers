//
//  GetUserRequest.swift
//  GitHubUsers
//
//  Created by Екатерина on 05.07.2022.
//

import Foundation

struct GetUserRequest: RequestProtocol {
    
    let username: String
    
    init(username: String) {
        self.username = username
    }
    
    var urlRequest: URLRequest? {
        guard let stringUrl = URLProvider.gitHubUsersApiPath,
              let url = URL(string: stringUrl + "/" + username) else {
                  return nil
              }
        
        let request = URLRequest(url: url)
        return request
    }
}
