//
//  UserView.swift
//  GitHubUsers
//
//  Created by Екатерина on 06.07.2022.
//

import UIKit

class UserView: UIView {
    
    // -MARK: fields
    
    var activityIndicator: UIActivityIndicatorView?
    
    var downloadImageAction: ((String, ((UIImage) -> Void)?) -> Void)?
    
    private let avatarImageView = UIImageView()
    
    private let nameLabel = UILabel()
    private let nameTitleLabel = UILabel()
    
    private let emailTitleLabel = UILabel()
    private let emailLabel = UILabel()
    
    private let organizationTitleLabel = UILabel()
    private let organizationLabel = UILabel()
    
    private let followingTitleLabel = UILabel()
    private let followingLabel = UILabel()
    
    private let followersTitleLabel = UILabel()
    private let followersLabel = UILabel()
    
    private let dateTitleLabel = UILabel()
    private let dateLabel = UILabel()
    
    // -MARK: override
    
    init(login: String?, navigationItem: UINavigationItem) {
        super.init(frame: CGRect.zero)
        backgroundColor = .white
        addSubviews(avatarImageView, nameTitleLabel, nameLabel, emailLabel, emailTitleLabel, organizationLabel, organizationTitleLabel, followingLabel, followingTitleLabel, followersLabel, followersTitleLabel, dateLabel, dateTitleLabel)
        configureConstraints()
        configureAvatarImageView()
        configureLabels()
        configureNavigationTitle(login, navigationItem)
        configureActivityIndicator()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        avatarImageView.roundСorners()
    }
    
    // -MARK: internal
    
    func configureView(downloadImageAction: ((String, ((UIImage) -> Void)?) -> Void)?, navigationItem: UINavigationItem) {
        self.downloadImageAction = downloadImageAction
    }
    
    func configure(with user: User, navigationItem: UINavigationItem) {
        configureNavigationTitle(user.login, navigationItem)
        configureAvatarImageContent(with: user)
        nameLabel.text = user.name != nil ? user.name : Const.noInfoText
        emailLabel.text = user.email != nil ? user.email : Const.noInfoText
        organizationLabel.text = user.company != nil ? user.company : Const.noInfoText
        configureFollowingLabelContent(with: user)
        configureFollowersLabelContent(with: user)
        configureDateLabelContent(with: user)
    }
    
    // -MARK: private
    
    private func addSubviews (_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
    
    private func configureConstraints() {
        configureAvatarImageConstraints()
        configureFirstTitleAndLabelConstraints(title: nameTitleLabel, label: nameLabel)
        configureTitleAndLabelConstraints(title: emailTitleLabel, label: emailLabel, upperTitle: nameTitleLabel)
        configureTitleAndLabelConstraints(title: organizationTitleLabel, label: organizationLabel, upperTitle: emailTitleLabel)
        configureTitleAndLabelConstraints(title: followingTitleLabel, label: followingLabel, upperTitle: organizationTitleLabel)
        configureTitleAndLabelConstraints(title: followersTitleLabel, label: followersLabel, upperTitle: followingTitleLabel)
        configureTitleAndLabelConstraints(title: dateTitleLabel, label: dateLabel, upperTitle: followersTitleLabel)
    }
    
    private func configureAvatarImageConstraints() {
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Const.avatarLeadingConstraint),
            avatarImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            avatarImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Const.avatarTopConstraint),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor)
        ])
    }
    
    private func configureFirstTitleAndLabelConstraints(title: UILabel, label: UILabel) {
        title.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Const.titlesLeadingConstraint),
            title.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: Const.firstTitleTopConstraint)
        ])
        configureLabelConstraints(title: title, label: label)
    }
    
    private func configureTitleAndLabelConstraints(title: UILabel, label: UILabel, upperTitle: UILabel) {
        title.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: upperTitle.leadingAnchor),
            title.topAnchor.constraint(equalTo: upperTitle.bottomAnchor, constant: Const.titleTopConstraint)
        ])
        configureLabelConstraints(title: title, label: label)
    }
    
    private func configureLabelConstraints(title: UILabel, label: UILabel) {
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: title.trailingAnchor, constant: Const.labelsLeadingConstraint),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Const.labelsTrailingConstraint),
            label.centerYAnchor.constraint(equalTo: title.centerYAnchor)
        ])
    }
    
    private func configureAvatarImageView() {
        avatarImageView.frame.size = CGSize(width: Const.avatarSideSize, height: Const.avatarSideSize)
        avatarImageView.setDefaultImage()
        avatarImageView.clipsToBounds = true
    }
    
    private func configureLabels() {
        configureTitleLabelsFont(titleLabels: nameTitleLabel, emailTitleLabel, organizationTitleLabel, followingTitleLabel, followersTitleLabel, dateTitleLabel)
        configureTitleValues()
        enableAdjustingFontSizeToFit(labels: nameLabel, emailLabel, organizationLabel, followingLabel, followersLabel)
    }
    
    private func configureTitleLabelsFont(titleLabels: UILabel...) {
        for label in titleLabels {
            label.font = UIFont.systemFont(ofSize: Const.titleLabelsFontSize, weight: .semibold)
        }
    }
    
    private func configureTitleValues() {
        nameTitleLabel.text = "Name:"
        emailTitleLabel.text = "Email:"
        organizationTitleLabel.text = "Organization:"
        followingTitleLabel.text = "Following:"
        followersTitleLabel.text = "Followers:"
        dateTitleLabel.text = "Creation Date:"
    }
    
    private func enableAdjustingFontSizeToFit(labels: UILabel...) {
        for label in labels {
            label.enableAdjustingFontSizeToFit()
        }
    }
    
    private func configureNavigationTitle(_ login: String?, _ navigationItem: UINavigationItem) {
        if let login = login {
            navigationItem.title = login
        }
    }
    
    private func configureActivityIndicator() {
        activityIndicator = UIActivityIndicatorView()
        activityIndicator?.center = CGPoint(x: UIScreen.main.bounds.size.width / 2, y: UIScreen.main.bounds.size.height / 2)
        activityIndicator?.hidesWhenStopped = true
        if let activityIndicator = activityIndicator {
            addSubview(activityIndicator)
        }
    }
    
    private func configureFollowingLabelContent(with user: User) {
        if let following = user.following {
            followingLabel.text = String(following)
        } else {
            followingLabel.text = Const.noInfoText
        }
    }
    
    private func configureFollowersLabelContent(with user: User) {
        if let followers = user.followers {
            followersLabel.text = String(followers)
        } else {
            followersLabel.text = Const.noInfoText
        }
    }
    
    private func configureDateLabelContent(with user: User) {
        if let createdAt = user.createdAt {
            dateLabel.text = String(createdAt.prefix(Const.datePrefix))
        } else {
            dateLabel.text = Const.noInfoText
        }
    }
    
    private func configureAvatarImageContent(with user: User) {
        if let avatarUrl = user.avatarUrl {
            downloadImageAction?(avatarUrl) { [weak self] image in
                self?.avatarImageView.image = image
            }
        }
    }
    
    private enum Const {
        static let avatarLeadingConstraint: CGFloat = 90
        static let avatarTopConstraint: CGFloat = 20
        static let titlesLeadingConstraint: CGFloat = 15
        static let firstTitleTopConstraint: CGFloat = 20
        static let labelsLeadingConstraint: CGFloat = 5
        static let titleTopConstraint: CGFloat = 15
        static let titleLabelsFontSize: CGFloat = 17
        static let labelsTrailingConstraint: CGFloat = -15
        static let avatarSideSize: CGFloat = 190
        static let datePrefix = 10
        static let noInfoText = "No info"
    }
}
