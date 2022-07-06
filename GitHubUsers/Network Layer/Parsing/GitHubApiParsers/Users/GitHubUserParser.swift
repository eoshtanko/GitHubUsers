//
//  GitHubUserParser.swift
//  GitHubUsers
//
//  Created by Екатерина on 06.07.2022.
//

import Foundation

class GitHubUserParser: ParserProtocol {
    
    typealias Model = User
    
    func parse(data: Data) -> User? {
        guard let user = try? JSONDecoder().decode(User.self, from: data) else {
            return nil
        }
        return user
    }
}

