//
//  UserListViewController.swift
//  GitHubUsers
//
//  Created by Екатерина on 05.07.2022.
//

import UIKit

class UserListViewController: UIViewController {
    
    // -MARK: fields
    
    var usersList: [UserListItem] = []
    var currentAPICallPage = 1
    
    var userListView: UserListView? {
        view as? UserListView
    }
    
    let downloadImageService: DownloadImageServiceProtocol
    private let requestSender: RequestSenderProtocol
    
    private let refreshControl = UIRefreshControl()
    
    // -MARK: override
    
    init(requestSender: RequestSenderProtocol,
         downloadImageService: DownloadImageServiceProtocol) {
        self.requestSender = requestSender
        self.downloadImageService = downloadImageService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = UserListView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        userListView?.configureView(tabBarController: tabBarController)
        userListView?.activityIndicator.startAnimating()
        initiallyDownloadUsers()
        configurePullToRefresh()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        userListView?.configureNavigationTitle(navigationItem: navigationItem, navigationController: navigationController)
    }
    
    // -MARK: internal
    
    func downloadUsers(page: Int, completitionSuccess: (([UserListItem]) -> Void)?, competitionFailer: ((Error) -> Void)?) {
        let requestConfig = RequestsFactory.GitHubApiRequests.UsersApiRequests.getUsers(since: page)
        requestSender.send(config: requestConfig) { (result: Result<[UserListItem], Error>) in
            switch result {
            case .success(let users):
                completitionSuccess?(users)
            case .failure(let failure):
                competitionFailer?(failure)
            }
        }
    }
    
    // -MARK: private
    
    private func configureTableView() {
        userListView?.tableView.dataSource = self
        userListView?.tableView.delegate = self
    }
    
    @objc private func initiallyDownloadUsers() {
        downloadUsers(page: 1, completitionSuccess: completitionSuccessForInitialRequest(_:), competitionFailer: completitionFailerForInitialRequest(_:))
    }
    
    private func completitionSuccessForInitialRequest(_ users: [UserListItem]) {
        usersList.append(contentsOf: users)
        DispatchQueue.main.async { [weak self] in
            self?.userListView?.activityIndicator.stopAnimating()
            self?.refreshControl.endRefreshing()
            self?.userListView?.tableView.isHidden = false
            self?.userListView?.tableView.reloadData()
        }
    }
    
    private func completitionFailerForInitialRequest(_ failure: Error) {
        DispatchQueue.main.async { [weak self] in
            self?.userListView?.activityIndicator.stopAnimating()
            self?.refreshControl.endRefreshing()
            self?.userListView?.tableView.isHidden = false
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
    
    private func configurePullToRefresh() {
        refreshControl.attributedTitle = NSAttributedString(string: "Updating")
        refreshControl.addTarget(self, action: #selector(initiallyDownloadUsers), for: .valueChanged)
        userListView?.tableView.addSubview(refreshControl)
    }
    
    enum Const {
        static let hightOfCell: CGFloat = 70
    }
}
