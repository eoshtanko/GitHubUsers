//
//  EmojisViewController.swift
//  GitHubemojis
//
//  Created by Екатерина on 06.07.2022.
//

import UIKit

class EmojisViewController: UIViewController {
    
    // -MARK: fields
    
    var emojiList: [String] = []
    
    var emojisView: EmojisView? {
        view as? EmojisView
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
        view = EmojisView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        emojisView?.activityIndicator.startAnimating()
        downloadEmojis()
        configurePullToRefresh()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        emojisView?.configureCollectionViewFrame()
    }
    
    // -MARK: private
    
    private func configureCollectionView() {
        emojisView?.collectionView.dataSource = self
        emojisView?.collectionView.delegate = self
    }
    
    @objc private func downloadEmojis() {
        let requestConfig = RequestsFactory.GitHubApiRequests.EmojisApiRequests.getEmojis()
        requestSender.send(config: requestConfig) { (result: Result<Emoji, Error>) in
            switch result {
            case .success(let emojis):
                self.completitionSuccessForRequest(emojis)
            case .failure(let failure):
                self.completitionFailerForRequest(failure)
            }
        }
    }
    
    private func completitionSuccessForRequest(_ emojis: Emoji) {
        emojiList = emojis.values.map{ $0 }
        DispatchQueue.main.async { [weak self] in
            self?.emojisView?.activityIndicator.stopAnimating()
            self?.refreshControl.endRefreshing()
            self?.emojisView?.collectionView.reloadData()
        }
    }
    
    private func completitionFailerForRequest(_ failure: Error) {
        DispatchQueue.main.async { [weak self] in
            self?.emojisView?.activityIndicator.stopAnimating()
            self?.refreshControl.endRefreshing()
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
        refreshControl.addTarget(self, action: #selector(downloadEmojis), for: .valueChanged)
        emojisView?.collectionView.addSubview(refreshControl)
    }
    
    enum Const {
        static let densityOfCollectionItems: CGFloat = 10
    }
}
