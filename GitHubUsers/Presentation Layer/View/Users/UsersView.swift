//
//  UsersView.swift
//  GitHubUsers
//
//  Created by Екатерина on 05.07.2022.
//

import UIKit

class UsersView: UIView {
    
    let tableView = UITableView(frame: .zero, style: .grouped)
    
    var activityIndicator: UIActivityIndicatorView?
    
    func configureView() {
        configureTableView()
        configureActivityIndicator()
    }
    
    func configureTableView() {
        self.addSubview(tableView)
        registerCell()
        configureTableViewAppearance()
        backgroundColor = .white
    }
    
    private func registerCell() {
        tableView.register(UsersTableViewCell.self, forCellReuseIdentifier: UsersTableViewCell.identifier)
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
    
    func configureNavigationTitle(navigationItem: UINavigationItem, navigationController: UINavigationController?) {
        navigationItem.title = "Users"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureActivityIndicator() {
        activityIndicator = UIActivityIndicatorView()
        activityIndicator?.center = CGPoint(x: UIScreen.main.bounds.size.width / 2, y: UIScreen.main.bounds.size.height / 2)
        activityIndicator?.hidesWhenStopped = true
        if let activityIndicator = activityIndicator {
            tableView.addSubview(activityIndicator)
        }
    }
}
