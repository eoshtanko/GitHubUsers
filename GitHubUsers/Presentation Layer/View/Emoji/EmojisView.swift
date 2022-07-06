//
//  EmojiView.swift
//  GitHubEmojis
//
//  Created by Екатерина on 06.07.2022.
//

import UIKit

class EmojisView: UIView {
    
    let collectionView: UICollectionView
    
    var activityIndicator: UIActivityIndicatorView?
    
    override init(frame: CGRect) {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 15, bottom: 0, right: 15)
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.contentInsetAdjustmentBehavior = .always

        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        configureCollectionView()
        configureActivityIndicator()
        collectionView.frame.origin = CGPoint(x: 0, y: 20)
    }
    
    func configureCollectionView() {
        self.addSubview(collectionView)
        registerCell()
        configureCollectionViewAppearance()
        backgroundColor = .white
    }
    
    private func registerCell() {
        collectionView.register(EmojisCollectionViewCell.self, forCellWithReuseIdentifier: EmojisCollectionViewCell.identifier)
    }
    
    private func configureCollectionViewAppearance() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    private func configureActivityIndicator() {
        activityIndicator = UIActivityIndicatorView()
        activityIndicator?.center = CGPoint(x: UIScreen.main.bounds.size.width / 2, y: UIScreen.main.bounds.size.height / 2)
        activityIndicator?.hidesWhenStopped = true
        if let activityIndicator = activityIndicator {
            collectionView.addSubview(activityIndicator)
        }
    }
}
