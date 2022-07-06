//
//  UserViewController.swift
//  GitHubUsers
//
//  Created by Екатерина on 06.07.2022.
//

import UIKit

class UserViewController: UIViewController {
    
    var user: User?
    let userName: String
    
    var userView: UserView? {
        view as? UserView
    }
    
    private let requestSender: RequestSenderProtocol
    
    init(requestSender: RequestSenderProtocol, userName: String) {
        self.requestSender = requestSender
        self.userName = userName
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        view = UserView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userView?.configureView(downloadImageAction: downloadImage, navigationItem: navigationItem)
        userView?.activityIndicator?.startAnimating()
        downloadUser()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard let userView = userView else { return }
        userView.avatarImageView.layer.cornerRadius = userView.avatarImageView.frame.width / 2
    }
    
    @objc func downloadUser() {
        let requestConfig = RequestsFactory.GitHubApiRequests.UsersGitHubApiRequests.getUser(username: userName)
        requestSender.send(config: requestConfig) { (result: Result<User, Error>) in
            switch result {
            case .success(let user):
                self.completitionSuccess(user)
            case .failure(let failure):
                self.competitionFailer(failure)
            }
        }
    }
    
    func downloadImage(from url: String, competition: ((UIImage) -> Void)?) {
        let requestConfig = RequestsFactory.ImagesRequests.getImage(urlString: url)
        requestSender.send(config: requestConfig) { (result: Result<Data, Error>) in
            switch result {
            case .success(let data):
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        competition?(image)
                    }
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    private func completitionSuccess(_ user: User) {
        self.user = user
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.userView?.activityIndicator?.stopAnimating()
            self.userView?.configure(with: user, navigationItem: self.navigationItem)
        }
    }
    
    private func competitionFailer(_ failure: Error) {
        DispatchQueue.main.async { [weak self] in
            self?.userView?.activityIndicator?.stopAnimating()
            self?.showFailureAlert()
        }
    }
    
    private func showFailureAlert() {
        let successAlert = UIAlertController(title: "Ошибка", message: "Проверьте подключение к интернету.", preferredStyle: UIAlertController.Style.alert)
        successAlert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { [weak self] _ in
            self?.dismiss(animated: true)
        })
        present(successAlert, animated: true, completion: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

