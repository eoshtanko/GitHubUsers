//
//  RequestsFactory.swift
//  GitHubUsers
//
//  Created by Екатерина on 05.07.2022.
//

import Foundation

struct RequestsFactory {
    
    struct GitHubApiRequests {
        
        struct UsersApiRequests {
            
            static func getUsers(since: Int) -> RequestConfig<GitHubUserListParser> {
                return RequestConfig<GitHubUserListParser>(request: GetUserListRequest(since: since), parser: GitHubUserListParser())
            }
            
            static func getUser(username: String) -> RequestConfig<GitHubUserParser> {
                return RequestConfig<GitHubUserParser>(request: GetUserRequest(username: username), parser: GitHubUserParser())
            }
        }
        
        struct EmojisApiRequests {
            
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
