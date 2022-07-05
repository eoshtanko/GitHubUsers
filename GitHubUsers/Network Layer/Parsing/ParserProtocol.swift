//
//  ParserProtocol.swift
//  GitHubUsers
//
//  Created by Екатерина on 05.07.2022.
//

import Foundation

protocol ParserProtocol {
   associatedtype Model
   func parse(data: Data) -> Model?
}
