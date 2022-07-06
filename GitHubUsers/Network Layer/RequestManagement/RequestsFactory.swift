//
//  RequestsFactory.swift
//  GitHubUsers
//
//  Created by Екатерина on 05.07.2022.
//

import Foundation

struct RequestsFactory {
    
    struct GitHubApiRequests {
        
        struct UsersGitHubApiRequests {
            
            static func getUsers(since: Int) -> RequestConfig<GitHubUsersParser> {
                return RequestConfig<GitHubUsersParser>(request: GetUsersRequest(since: since), parser: GitHubUsersParser())
            }
            
            static func getUser(username: String) -> RequestConfig<GitHubUserParser> {
                return RequestConfig<GitHubUserParser>(request: GetUserRequest(username: username), parser: GitHubUserParser())
            }
        }
        
        struct EmojisGitHubApiRequests {
            
            static func getEmojis() -> RequestConfig<GitHubEmojisParser> {
                return RequestConfig<GitHubEmojisParser>(request: GetEmojisRequest(), parser: GitHubEmojisParser())
            }
        }
    }
    struct ImagesRequests {
        
        static func getImage(urlString: String) -> RequestConfig<ImageParser> {
            return RequestConfig<ImageParser>(request: GetImageRequest(urlString: urlString), parser: ImageParser())
        }
    }
}
