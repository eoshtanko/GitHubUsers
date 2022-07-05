//
//  RequestsFactory.swift
//  GitHubUsers
//
//  Created by Екатерина on 05.07.2022.
//

import Foundation

struct RequestsFactory {
    
    struct UsersGitHubApiRequests {
        
        static func getUsers(since: Int) -> RequestConfig<GitHubUsersParser> {
            return RequestConfig<GitHubUsersParser>(request: GetUsersRequest(since: since), parser: GitHubUsersParser())
        }
    }
    
    struct ImagesRequests {
        
        static func getImage(urlString: String) -> RequestConfig<ImageParser> {
            return RequestConfig<ImageParser>(request: GetImageRequest(urlString: urlString), parser: ImageParser())
        }
    }
}
