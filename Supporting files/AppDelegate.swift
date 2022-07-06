//
//  AppDelegate.swift
//  GitHubUsers
//
//  Created by Екатерина on 05.07.2022.
//

import UIKit

@main
final class AppDelegate: UIResponder {
    
    lazy var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
}

extension AppDelegate: UIApplicationDelegate {
    
    func application( _ application: UIApplication,
                      didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window?.rootViewController = GitHubTabBar()
        window?.makeKeyAndVisible()
        return true
    }
}
