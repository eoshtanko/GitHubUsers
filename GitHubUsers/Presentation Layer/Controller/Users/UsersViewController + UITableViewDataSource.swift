//
//  UsersViewController + UITableViewDataSource.swift
//  GitHubUsers
//
//  Created by Екатерина on 05.07.2022.
//

import UIKit

extension UsersViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: UsersTableViewCell.identifier,
            for: indexPath)
        guard let userCell = cell as? UsersTableViewCell else {
            return cell
        }
        userCell.downloadImageAction = downloadImage
        userCell.configure(with: usersList[indexPath.row])
        
        if indexPath.row == usersList.count - 1 {
            currentAPICallPage += 1
            downloadUsers(page: currentAPICallPage, completitionSuccess: completitionSuccessForRepeatedRequest, competitionFailer: nil)
        }
        
        return userCell
    }
    
    private func completitionSuccessForRepeatedRequest(_ moreUsers: [Users]) {
        usersList.append(contentsOf: moreUsers)
        DispatchQueue.main.async { [weak self] in
            self?.usersView?.tableView.reloadData()
        }
    }
}
