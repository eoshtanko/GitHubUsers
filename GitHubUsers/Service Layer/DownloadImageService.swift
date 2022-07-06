//
//  DownloadImageService.swift
//  GitHubUsers
//
//  Created by Екатерина on 06.07.2022.
//

import UIKit

protocol DownloadImageServiceProtocol {
    func downloadImage(from url: String, competition: ((UIImage) -> Void)?)
}

class DownloadImageService: DownloadImageServiceProtocol {
    
    // -MARK: fields
    
    private let requestSender: RequestSenderProtocol
    
    // -MARK: internal
    
    init(requestSender: RequestSenderProtocol) {
        self.requestSender = requestSender
    }
    
    func downloadImage(from url: String, competition: ((UIImage) -> Void)?) {
        let requestConfig = RequestsFactory.ImagesRequests.getImage(urlString: url)
        requestSender.send(config: requestConfig) { (result: Result<Data, Error>) in
            switch result {
            case .success(let data):
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        competition?(image)
                    }
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
