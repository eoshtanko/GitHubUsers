//
//  ApiImageParser.swift
//  GitHubUsers
//
//  Created by Екатерина on 05.07.2022.
//

import Foundation

class GitHubUsersParser: ParserProtocol {
    
    typealias Model = [Users]
    
    func parse(data: Data) -> [Users]? {
        guard let users = try? JSONDecoder().decode([Users].self, from: data) else {
            return nil
        }
        return users
    }
}
