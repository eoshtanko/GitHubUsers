//
//  UserListViewController + UITableViewDelegate.swift
//  GitHubUsers
//
//  Created by Екатерина on 05.07.2022.
//

import UIKit

extension UserListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationItem.title = ""
        
        let userViewController = UserViewController(userName: usersList[indexPath.row].login,
                                                    requestSender: RequestSender(),
                                                    downloadImageService: DownloadImageService(
                                                        requestSender: RequestSender()))
        navigationController?.pushViewController(userViewController, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Const.hightOfCell
    }
}
