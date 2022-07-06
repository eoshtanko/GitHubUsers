//
//  UsersViewController + UITableViewDelegate.swift
//  GitHubUsers
//
//  Created by Екатерина on 05.07.2022.
//

import UIKit

extension UsersViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationItem.title = ""
        if let userName = usersList[indexPath.row].login {
            let userViewController = UserViewController(requestSender: RequestSender(), userName: userName)
            navigationController?.pushViewController(userViewController, animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Const.hightOfCell
    }
}
