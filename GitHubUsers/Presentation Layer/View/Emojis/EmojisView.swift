//
//  EmojisView.swift
//  GitHubEmojis
//
//  Created by Екатерина on 06.07.2022.
//

import UIKit

class EmojisView: UIView {
    
    // -MARK: fields
    
    let collectionView: UICollectionView
    var activityIndicator = UIActivityIndicatorView()
    
    // -MARK: override
    
    override init(frame: CGRect) {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: Const.collectionSectionInset,
                                           left: Const.collectionSectionInset, bottom: 0,
                                           right: Const.collectionSectionInset)
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        super.init(frame: frame)
        backgroundColor = .white
        configureCollectionView()
        configureActivityIndicator()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // -MARK: private
    
    private func configureCollectionView() {
        addSubview(collectionView)
        registerCell()
        configureCollectionViewAppearance()
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
        activityIndicator.center = CGPoint(x: UIScreen.main.bounds.size.width / 2, y: UIScreen.main.bounds.size.height / 2)
        activityIndicator.hidesWhenStopped = true
        collectionView.addSubview(activityIndicator)
    }
    
    private enum Const {
        static let collectionSectionInset: CGFloat = 15
    }
}
