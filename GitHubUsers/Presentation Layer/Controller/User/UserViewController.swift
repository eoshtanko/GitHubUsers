//
//  UserViewController.swift
//  GitHubUsers
//
//  Created by Екатерина on 06.07.2022.
//

import UIKit

class UserViewController: UIViewController {
    
    // -MARK: fields
    
    var user: User?
    let userName: String?
    
    var userView: UserView? {
        view as? UserView
    }
    
    private let downloadImageService: DownloadImageServiceProtocol
    private let requestSender: RequestSenderProtocol
    
    // -MARK: override
    
    init(userName: String?, requestSender: RequestSenderProtocol,
         downloadImageService: DownloadImageServiceProtocol) {
        self.userName = userName
        self.requestSender = requestSender
        self.downloadImageService = downloadImageService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = UserView(login: userName, navigationItem: navigationItem)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userView?.activityIndicator?.startAnimating()
        downloadUser()
    }
    
    // -MARK: internal
    
    @objc func downloadUser() {
        guard let userName = userName else { return }
        let requestConfig = RequestsFactory.GitHubApiRequests.UsersApiRequests.getUser(username: userName)
        requestSender.send(config: requestConfig) { (result: Result<User, Error>) in
            switch result {
            case .success(let user):
                self.completitionSuccess(user)
            case .failure(let failure):
                self.competitionFailer(failure)
            }
        }
    }
    
    // -MARK: private
    
    private func completitionSuccess(_ user: User) {
        self.user = user
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.userView?.activityIndicator?.stopAnimating()
            self.userView?.configureView(downloadImageAction: self.downloadImageService.downloadImage,
                                         navigationItem: self.navigationItem)
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
            self?.navigationController?.popViewController(animated: true)
        })
        present(successAlert, animated: true, completion: nil)
    }
}

