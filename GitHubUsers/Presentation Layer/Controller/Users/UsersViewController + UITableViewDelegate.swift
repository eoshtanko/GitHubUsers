//
//  UsersViewController + UITableViewDelegate.swift
//  GitHubUsers
//
//  Created by Екатерина on 05.07.2022.
//

import UIKit

extension UsersViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Const.hightOfCell
    }
}
