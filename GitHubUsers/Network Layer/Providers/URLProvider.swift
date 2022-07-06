//
//  URLProvider.swift
//  GitHubUsers
//
//  Created by Екатерина on 05.07.2022.
//

import Foundation

public struct URLProvider {
    
    public static let gitHubEmojisApiPath = Bundle.main.object(
        forInfoDictionaryKey: "gitHubEmojisApiPath"
    ) as? String
    
    public static let gitHubUsersApiPath = Bundle.main.object(
        forInfoDictionaryKey: "gitHubUsersApiPath"
    ) as? String
}
