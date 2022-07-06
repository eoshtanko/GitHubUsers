//
//  UserView.swift
//  GitHubUsers
//
//  Created by Екатерина on 06.07.2022.
//

import UIKit

class UserView: UIView {
    
    var activityIndicator: UIActivityIndicatorView?
    
    var downloadImageAction: ((String, ((UIImage) -> Void)?) -> Void)?
    
    lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.frame.size = CGSize(width: Const.avatarSideSize, height: Const.avatarSideSize)
        imageView.layer.cornerRadius = imageView.frame.width / 2
        imageView.image = UIImage(named: "defaultImage")
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let nameLabel = UILabel()
    private let nameTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Name:"
        return label
    }()
    
    private let emailTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Email:"
        return label
    }()
    private let emailLabel = UILabel()
    
    private let organizationTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Organization:"
        return label
    }()
    private let organizationLabel = UILabel()
    
    private let followingTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Following:"
        return label
    }()
    private let followingLabel = UILabel()
    
    private let followersTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Followers:"
        return label
    }()
    private let followersLabel = UILabel()
    
    private let dateTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Creation Date:"
        return label
    }()
    private let dateLabel = UILabel()
    
    func configureView(downloadImageAction: ((String, ((UIImage) -> Void)?) -> Void)?, navigationItem: UINavigationItem) {
        self.downloadImageAction = downloadImageAction
        addSubviews(avatarImageView, nameTitleLabel, nameLabel, emailLabel, emailTitleLabel, organizationLabel, organizationTitleLabel, followingLabel, followingTitleLabel, followersLabel, followersTitleLabel, dateLabel, dateTitleLabel)
        setupConstraints()
        setupTitleLabelsFont(titleLabels: nameTitleLabel, emailTitleLabel, organizationTitleLabel, followingTitleLabel, followersTitleLabel, dateTitleLabel)
        setupDefaultValues(labels: nameLabel, emailLabel, organizationLabel, followingLabel, followersLabel, dateLabel)
        backgroundColor = .white
        navigationItem.title = "No Login"
        configureActivityIndicator()
    }
    
    func configure(with user: User, navigationItem: UINavigationItem) {
        if let login = user.login {
            navigationItem.title = login
        }
        if let avatarUrl = user.avatarUrl {
            downloadImageAction?(avatarUrl, setImage)
        }
        if let name = user.name {
            nameLabel.text = name
        }
        if let email = user.email {
            emailLabel.text = email
        }
        if let organization = user.company {
            organizationLabel.text = organization
        }
        if let following = user.following {
            followingLabel.text = "\(following)"
        }
        if let followers = user.followers {
            followersLabel.text = "\(followers)"
        }
        if let createdAt = user.createdAt {
            dateLabel.text = createdAt
        }
    }
    
    private func setImage(image: UIImage) {
        avatarImageView.image = image
    }
    
    private func addSubviews (_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
    
    private func setupDefaultValues(labels: UILabel...) {
        for label in labels {
            label.text = "No info"
        }
    }
    
    private func setupTitleLabelsFont(titleLabels: UILabel...) {
        for label in titleLabels {
            label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        }
    }
    
    private func setupConstraints() {
        setupAvatarImageConstraints()
        setupFirstTitleAndLabelConstraints(title: nameTitleLabel, label: nameLabel)
        setupTitleAndLabelConstraints(title: emailTitleLabel, label: emailLabel, upperTitle: nameTitleLabel)
        setupTitleAndLabelConstraints(title: organizationTitleLabel, label: organizationLabel, upperTitle: emailTitleLabel)
        setupTitleAndLabelConstraints(title: followingTitleLabel, label: followingLabel, upperTitle: organizationTitleLabel)
        setupTitleAndLabelConstraints(title: followersTitleLabel, label: followersLabel, upperTitle: followingTitleLabel)
        setupTitleAndLabelConstraints(title: dateTitleLabel, label: dateLabel, upperTitle: followersTitleLabel)
    }
    
    private func setupAvatarImageConstraints() {
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 90),
            avatarImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            avatarImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor)
        ])
    }
    
    private func setupFirstTitleAndLabelConstraints(title: UILabel, label: UILabel) {
        title.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            title.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 30)
        ])
        setupLabelConstraints(title: title, label: label)
    }
    
    private func setupTitleAndLabelConstraints(title: UILabel, label: UILabel, upperTitle: UILabel) {
        title.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: upperTitle.leadingAnchor),
            title.topAnchor.constraint(equalTo: upperTitle.bottomAnchor, constant: 15)
        ])
        setupLabelConstraints(title: title, label: label)
    }
    
    private func setupLabelConstraints(title: UILabel, label: UILabel) {
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: title.trailingAnchor, constant: 5),
            label.centerYAnchor.constraint(equalTo: title.centerYAnchor)
        ])
    }
    
    private func configureActivityIndicator() {
        activityIndicator = UIActivityIndicatorView()
        activityIndicator?.center = CGPoint(x: UIScreen.main.bounds.size.width / 2, y: UIScreen.main.bounds.size.height / 2)
        activityIndicator?.hidesWhenStopped = true
        if let activityIndicator = activityIndicator {
            addSubview(activityIndicator)
        }
    }
    
    private enum Const {
        static let avatarSideSize: CGFloat = 190
    }
}
