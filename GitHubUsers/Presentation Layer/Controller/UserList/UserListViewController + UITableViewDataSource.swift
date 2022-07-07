//
//  UserListViewController + UITableViewDataSource.swift
//  GitHubUsers
//
//  Created by Екатерина on 05.07.2022.
//

import UIKit

extension UserListViewController: UITableViewDataSource {
    
    // -MARK: internal
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: UserListTableViewCell.identifier,
            for: indexPath
        )
        guard let userCell = cell as? UserListTableViewCell else {
            return cell
        }
        userCell.downloadImageAction = downloadImageService.downloadImage
        userCell.configure(with: usersList[indexPath.row])
        
        doPaginationIfNeeded(indexPath.row)
        
        return userCell
    }
    
    // -MARK: private
    
    private func doPaginationIfNeeded(_ row: Int) {
        if isThisTheLastRaw(row) {
            getNewUsers()
        }
    }
    
    private func isThisTheLastRaw(_ row: Int) -> Bool {
        return row == usersList.count - 1
    }
    
    private func getNewUsers() {
        currentAPICallPage += 1
        downloadUsers(page: currentAPICallPage, completitionSuccess: completitionSuccessForRepeatedRequest, competitionFailer: nil)
    }
    
    private func completitionSuccessForRepeatedRequest(_ moreUsers: [UserListItem]) {
        usersList.append(contentsOf: moreUsers)
        DispatchQueue.main.async { [weak self] in
            self?.userListView?.tableView.isHidden = false
            self?.userListView?.tableView.reloadData()
        }
    }
}
