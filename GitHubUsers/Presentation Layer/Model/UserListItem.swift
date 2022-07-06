//
//  UserListItem.swift
//  GitHubUsers
//
//  Created by Екатерина on 05.07.2022.
//

import Foundation

public struct UserListItem : Codable {
    
    let avatarUrl : String?
    let id : Int?
    let login : String?
    
    
    enum CodingKeys: String, CodingKey {
        case avatarUrl = "avatar_url"
        case id
        case login
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        avatarUrl = try values.decodeIfPresent(String.self, forKey: .avatarUrl)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        login = try values.decodeIfPresent(String.self, forKey: .login)
    }
}
