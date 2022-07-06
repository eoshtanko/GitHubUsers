//
//  EmojiViewController.swift
//  GitHubemojis
//
//  Created by Екатерина on 06.07.2022.
//

import UIKit

class EmojiViewController: UIViewController {
    
    var emojiList: [String] = []
    
    var emojisView: EmojisView? {
        view as? EmojisView
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        emojisView?.collectionView.frame.origin = CGPoint(x: 0, y: UIApplication.shared.statusBarFrame.height)
    }
    
    private let refreshControl = UIRefreshControl()
    
    private let requestSender: RequestSenderProtocol

    init(requestSender: RequestSenderProtocol) {
        self.requestSender = requestSender
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        view = EmojisView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        emojisView?.configureView()
        configurePullToRefresh()
        emojisView?.activityIndicator?.startAnimating()
        downloadEmojis()
    }

    @objc private func downloadEmojis() {
        let requestConfig = RequestsFactory.GitHubApiRequests.EmojisGitHubApiRequests.getEmojis()
        requestSender.send(config: requestConfig) { (result: Result<Emoji, Error>) in
            switch result {
            case .success(let emojis):
                self.completitionSuccessForRequest(emojis)
            case .failure(let failure):
                self.completitionFailerForRequest(failure)
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
    
    private func configureCollectionView() {
        emojisView?.collectionView.dataSource = self
        emojisView?.collectionView.delegate = self
    }
    
    private func completitionSuccessForRequest(_ emojis: Emoji) {
        emojiList = emojis.values.map{ $0 }
        DispatchQueue.main.async { [weak self] in
            self?.emojisView?.activityIndicator?.stopAnimating()
            self?.refreshControl.endRefreshing()
            self?.emojisView?.collectionView.reloadData()
        }
    }
    
    private func completitionFailerForRequest(_ failure: Error) {
        DispatchQueue.main.async { [weak self] in
            self?.refreshControl.endRefreshing()
            self?.emojisView?.activityIndicator?.stopAnimating()
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    enum Const {
        static let numberOfColumns: CGFloat = 8
        static let hightOfCell: CGFloat = 70
    }
}
