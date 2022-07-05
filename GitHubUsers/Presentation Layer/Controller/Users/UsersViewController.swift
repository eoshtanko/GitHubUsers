//
//  UsersViewController.swift
//  GitHubUsers
//
//  Created by Екатерина on 05.07.2022.
//

import UIKit

class UsersViewController: UIViewController {
    
    var currentAPICallPage = 1
    var usersList: [Users] = []
    
    var usersView: UsersView? {
        view as? UsersView
    }
    
    private let refreshControl = UIRefreshControl()
    
    private let requestSender: RequestSenderProtocol

    
    init(requestSender: RequestSenderProtocol) {
        self.requestSender = requestSender
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        view = UsersView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        usersView?.configureView()
        // viewWillAppear ?
        usersView?.configureNavigationTitle(navigationItem: navigationItem, navigationController: navigationController)
        usersView?.activityIndicator?.startAnimating()
        initiallyDownloadUsers()
        configurePullToRefresh()
    }
    
    @objc private func initiallyDownloadUsers() {
        downloadUsers(page: 1, completitionSuccess: completitionSuccessForInitialRequest(_:), competitionFailer: completitionFailerForInitialRequest(_:))
    }
    
    func downloadUsers(page: Int, completitionSuccess: (([Users]) -> Void)?, competitionFailer: ((Error) -> Void)?) {
        let requestConfig = RequestsFactory.UsersGitHubApiRequests.getUsers(since: page)
        requestSender.send(config: requestConfig) { (result: Result<[Users], Error>) in
            switch result {
            case .success(let users):
                completitionSuccess?(users)
            case .failure(let failure):
                competitionFailer?(failure)
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
    
    // -MARK: Можно ли это сделать в viewDidLoad?
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
////        usersView?.configureNavigationTitle(navigationItem: navigationItem, navigationController: navigationController)
//    }
    
    private func configureTableView() {
        usersView?.tableView.dataSource = self
        usersView?.tableView.delegate = self
    }
    
    private func completitionSuccessForInitialRequest(_ users: [Users]) {
        usersList.append(contentsOf: users)
        DispatchQueue.main.async { [weak self] in
            self?.usersView?.activityIndicator?.stopAnimating()
            self?.refreshControl.endRefreshing()
            self?.usersView?.tableView.reloadData()
        }
    }
    
    private func completitionFailerForInitialRequest(_ failure: Error) {
        DispatchQueue.main.async { [weak self] in
            self?.refreshControl.endRefreshing()
            self?.usersView?.activityIndicator?.stopAnimating()
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
        usersView?.tableView.addSubview(refreshControl)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    enum Const {
        static let numberOfSections = 1
        static let hightOfCell: CGFloat = 70
    }
}
