//
//  GitHubTabBar.swift
//  GitHubUsers
//
//  Created by Екатерина on 05.07.2022.
//

import UIKit

class GitHubTabBar: UITabBarController {
    
    // -MARK: override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
    }
    
    // -MARK: private
    
    private func setupViewControllers() {
        viewControllers = [
            getUsersViewController(),
            getEmojiViewController()
        ]
    }
    
    private func getUsersViewController() -> UIViewController {
        let viewController = UINavigationController(
            rootViewController: UserListViewController(requestSender: RequestSender(),
                                                       downloadImageService: DownloadImageService(
                                                        requestSender: RequestSender()))
        )
        setTabBarItemImage(viewController: viewController, imageName: "person.fill")
        return viewController
    }
    
    private func getEmojiViewController() -> UIViewController {
        let viewController = EmojiViewController(requestSender: RequestSender(),
                                                 downloadImageService: DownloadImageService(
                                                    requestSender: RequestSender()))
        setTabBarItemImage(viewController: viewController, imageName: "smiley.fill")
        return viewController
    }
    
    private func setTabBarItemImage(viewController: UIViewController, imageName: String) {
        if #available(iOS 13.0, *) {
            viewController.tabBarItem.image = UIImage(systemName: imageName)
        } else {
            viewController.tabBarItem.image = UIImage(named: imageName)
        }
    }
}
