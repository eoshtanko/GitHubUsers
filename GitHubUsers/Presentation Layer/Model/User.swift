//
//  User.swift
//  GitHubUsers
//
//  Created by Екатерина on 05.07.2022.
//

import Foundation

public struct User : Codable {
    let avatarUrl : String?
    let company : String?
    let createdAt : String?
    let email : String?
    let followers : Int?
    let following : Int?
    let name : String?
    let login : String?


    enum CodingKeys: String, CodingKey {
        case avatarUrl = "avatar_url"
        case company
        case createdAt = "created_at"
        case email
        case followers
        case following
        case name
        case login
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        avatarUrl = try values.decodeIfPresent(String.self, forKey: .avatarUrl)
        company = try values.decodeIfPresent(String.self, forKey: .company)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        followers = try values.decodeIfPresent(Int.self, forKey: .followers)
        following = try values.decodeIfPresent(Int.self, forKey: .following)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        login = try values.decodeIfPresent(String.self, forKey: .login)
    }
}
