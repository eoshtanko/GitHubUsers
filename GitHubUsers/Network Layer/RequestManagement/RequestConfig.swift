//
//  RequestConfig.swift
//  GitHubUsers
//
//  Created by Екатерина on 05.07.2022.
//

import Foundation

struct RequestConfig<Parser> where Parser: ParserProtocol {
   let request: RequestProtocol
   let parser: Parser
}
