//
//  UsersTableViewCell.swift
//  GitHubUsers
//
//  Created by Екатерина on 05.07.2022.
//

import UIKit

class UsersTableViewCell: UITableViewCell {
    
    static let identifier = String(describing: UsersTableViewCell.self)
    
    var downloadImageAction: ((String, ((UIImage) -> Void)?) -> Void)?
    
    private let avatarImageView = UIImageView()
    private let loginLabel = UILabel()
    private let idLabel = UILabel()
    
    // -MARK: override
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        configureAvatarImageView()
        configureLoginLabel()
        configureIdLabel()
    }
    
    override func layoutSubviews() {
         super.layoutSubviews()
         self.avatarImageView.layer.cornerRadius = self.avatarImageView.frame.width / 2
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImageView.image = UIImage(named: "defaultImage")
    }
    
    // -MARK: internal
    
    func configure(with user: Users) {
        configureAvatarContent(user.avatarUrl)
        configureLoginContent(user.login)
        configureIdContent(user.id)
    }
    
    // -MARK: private
    
    private func configureAvatarContent(_ avatarUrl: String?) {
        if let avatarUrl = avatarUrl {
            downloadImageAction?(avatarUrl, setImage)
        }
    }
    
    private func configureLoginContent(_ login: String?) {
        guard let login = login, !login.isEmpty else {
            loginLabel.text = "No Login"
            return
        }
        loginLabel.text = login
    }
    
    private func configureIdContent(_ id: Int?) {
        guard let id = id, !"\(id)".isEmpty else {
            idLabel.text = "No ID"
            return
        }
        idLabel.text = "\(id)"
    }
    
    private func addSubviews() {
        addSubview(avatarImageView)
        addSubview(loginLabel)
        addSubview(idLabel)
    }
    
    private func configureAvatarImageView() {
        avatarImageView.image = UIImage(named: "defaultImage")
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.frame.size = CGSize(width: Const.avatarSideSize, height: Const.avatarSideSize)
        self.avatarImageView.clipsToBounds = true
        
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            avatarImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor)
        ])
    }
    
    private func configureLoginLabel() {
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        loginLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        NSLayoutConstraint.activate([
            loginLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 5),
            loginLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10)
        ])
    }
    
    private func configureIdLabel() {
        idLabel.translatesAutoresizingMaskIntoConstraints = false
        idLabel.font = UIFont.systemFont(ofSize: 15, weight: .light)
        NSLayoutConstraint.activate([
            idLabel.leadingAnchor.constraint(equalTo: loginLabel.leadingAnchor),
            idLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10),
            idLabel.topAnchor.constraint(equalTo: loginLabel.bottomAnchor),
            idLabel.topAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private func setImage(image: UIImage) {
        avatarImageView.image = image
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private enum Const {
        static let avatarSideSize: CGFloat = 60
    }
}
