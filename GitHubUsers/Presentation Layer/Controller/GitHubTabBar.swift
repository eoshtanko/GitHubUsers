//
//  GitHubTabBar.swift
//  GitHubUsers
//
//  Created by Екатерина on 05.07.2022.
//

import UIKit

class GitHubTabBar: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
    }
    
    private func setupViewControllers() {
        viewControllers = [
            getEmojiViewController(),
            getUsersViewController(),
        ]
    }
    
    private func getUsersViewController() -> UIViewController {
        let navigationViewController = UINavigationController(rootViewController: UsersViewController(requestSender: RequestSender()))
        if #available(iOS 13.0, *) {
            navigationViewController.tabBarItem.image = UIImage(systemName: "person.fill")
        } else {
            navigationViewController.tabBarItem.image = UIImage(named: "person.fill")
        }
        return navigationViewController
    }
    
    private func getEmojiViewController() -> UIViewController {
        let viewController = EmojiViewController(requestSender: RequestSender())
        if #available(iOS 13.0, *) {
            viewController.tabBarItem.image = UIImage(systemName: "smiley.fill")
        } else {
            viewController.tabBarItem.image = UIImage(named: "smiley.fill")
        }
        return viewController
    }
}
