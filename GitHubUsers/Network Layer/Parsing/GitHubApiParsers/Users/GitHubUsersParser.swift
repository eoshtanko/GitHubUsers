//
//  ApiImageParser.swift
//  GitHubUsers
//
//  Created by Екатерина on 05.07.2022.
//

import Foundation

class GitHubUsersParser: ParserProtocol {
    
    typealias Model = [UserListItem]
    
    func parse(data: Data) -> [UserListItem]? {
        guard let users = try? JSONDecoder().decode([UserListItem].self, from: data) else {
            return nil
        }
        return users
    }
}
