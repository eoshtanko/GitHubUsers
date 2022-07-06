//
//  GitHubEmojisParser.swift
//  GitHubUsers
//
//  Created by Екатерина on 06.07.2022.
//

import Foundation

class GitHubEmojisParser: ParserProtocol {
    
    typealias Model = Emoji
    
    func parse(data: Data) -> Emoji? {
        guard let emojis = try? JSONDecoder().decode(Emoji.self, from: data) else {
            return nil
        }
        return emojis
    }
}
