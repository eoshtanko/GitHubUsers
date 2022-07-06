//
//  UserListTableViewCell.swift
//  GitHubUsers
//
//  Created by Екатерина on 05.07.2022.
//

import UIKit

class UserListTableViewCell: UITableViewCell {
    
    // -MARK: fields
    
    static let identifier = String(describing: UserListTableViewCell.self)
    
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        avatarImageView.roundСorners()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImageView.setDefaultImage()
    }
    
    // -MARK: internal
    
    func configure(with user: UserListItem) {
        configureAvatarContent(user.avatarUrl)
        configureLoginContent(user.login)
        configureIdContent(user.id)
    }
    
    // -MARK: private
    
    private func addSubviews() {
        addSubview(avatarImageView)
        addSubview(loginLabel)
        addSubview(idLabel)
    }
    
    private func configureAvatarImageView() {
        avatarImageView.setDefaultImage()
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.frame.size = CGSize(width: Const.avatarSideSize, height: Const.avatarSideSize)
        avatarImageView.clipsToBounds = true
        configureAvatarImageViewConstraints()
    }
    
    private func configureAvatarImageViewConstraints() {
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Const.avatarConstraint),
            avatarImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: Const.avatarConstraint),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor)
        ])
    }
    
    private func configureLoginLabel() {
        loginLabel.font = UIFont.systemFont(ofSize: Const.loginLabelFontSize, weight: .medium)
        configureLoginLabelConstraints()
    }
    
    private func configureLoginLabelConstraints() {
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: Const.loginLabelConstraint),
            loginLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Const.labelsTrailingConstraint)
        ])
    }
    
    private func configureIdLabel() {
        idLabel.font = UIFont.systemFont(ofSize: Const.idLabelFontSize, weight: .light)
        configureIdLabelConstraints()
    }
    
    private func configureIdLabelConstraints() {
        idLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            idLabel.leadingAnchor.constraint(equalTo: loginLabel.leadingAnchor),
            idLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Const.labelsTrailingConstraint),
            idLabel.topAnchor.constraint(equalTo: loginLabel.bottomAnchor),
            idLabel.topAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private func configureAvatarContent(_ avatarUrl: String?) {
        if let avatarUrl = avatarUrl {
            downloadImageAction?(avatarUrl) { [weak self] image in
                self?.avatarImageView.image = image
            }
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
        guard let id = id, !String(id).isEmpty else {
            idLabel.text = "No ID"
            return
        }
        idLabel.text = String(id)
    }
    
    private enum Const {
        static let avatarSideSize: CGFloat = 60
        static let avatarConstraint: CGFloat = 5
        static let loginLabelFontSize: CGFloat = 18
        static let loginLabelConstraint: CGFloat = 5
        static let idLabelFontSize: CGFloat = 16
        static let labelsTrailingConstraint: CGFloat = -5
    }
}
