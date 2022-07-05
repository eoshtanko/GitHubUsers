//
//  GetImageRequest.swift
//  GitHubUsers
//
//  Created by Екатерина on 06.07.2022.
//

import Foundation

struct GetImageRequest: RequestProtocol {
    
    let urlString: String
    
    init(urlString: String) {
        self.urlString = urlString
    }
    
    var urlRequest: URLRequest? {
        guard let url = URL(string: urlString) else {
            return nil
        }
        let request = URLRequest(url: url)
        return request
    }
}

