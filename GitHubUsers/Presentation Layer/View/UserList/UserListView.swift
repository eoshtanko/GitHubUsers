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
    
    func configureView(navigationController: UINavigationController?) {
        configureTableView()
        configureActivityIndicator(navigationController)
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
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: self.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    private func configureActivityIndicator(_ navigationController: UINavigationController?) {
        activityIndicator.center = navigationController?.navigationBar.center ?? CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
        activityIndicator.hidesWhenStopped = true
        tableView.addSubview(activityIndicator)
    }
}
