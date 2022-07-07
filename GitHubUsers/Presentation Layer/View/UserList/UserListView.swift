//
//  UserListView.swift
//  GitHubUsers
//
//  Created by Екатерина on 05.07.2022.
//

import UIKit

// Кастомные UIView - хороший способ расправиться с проблемой
// massive view controller в таком простом приложении
class UserListView: UIView {
    
    // -MARK: fields
    
    let tableView = UITableView(frame: .zero, style: .grouped)
    let activityIndicator = UIActivityIndicatorView()
    
    // -MARK: internal
    
    func configureView(tabBarController: UITabBarController?) {
        configureTableView()
        configureActivityIndicator(tabBarController)
    }
    
    func configureNavigationTitle(navigationItem: UINavigationItem,
                                  navigationController: UINavigationController?) {
        navigationItem.title = "Users"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    // -MARK: private
    
    private func configureTableView() {
        self.addSubview(tableView)
        registerCell()
        configureTableViewAppearance()
        backgroundColor = .white
    }
    
    private func registerCell() {
        tableView.register(UserListTableViewCell.self, forCellReuseIdentifier: UserListTableViewCell.identifier)
    }
    
    private func configureTableViewAppearance() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func configureActivityIndicator(_ tabBarController: UITabBarController?) {
        activityIndicator.center = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY - (tabBarController?.tabBar.frame.size.height ?? 0))
        activityIndicator.hidesWhenStopped = true
        tableView.addSubview(activityIndicator)
    }
}
