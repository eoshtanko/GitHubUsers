//
//  EmojisCollectionViewCell.swift
//  GitHubEmojis
//
//  Created by Екатерина on 06.07.2022.
//

import UIKit

class EmojisCollectionViewCell: UICollectionViewCell {
    
    // -MARK: fields
    
    static let identifier = String(describing: EmojisCollectionViewCell.self)
    
    var downloadImageAction: ((String, ((UIImage) -> Void)?) -> Void)?
    
    private let emojiImageView = UIImageView()
    
    // -MARK: override
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(emojiImageView)
        configureEmojiImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        emojiImageView.setDefaultImage()
    }
    
    // -MARK: internal
    
    func configure(with emojiUrl: String) {
        downloadImageAction?(emojiUrl) { [weak self] emoji in
            self?.emojiImageView.image = emoji
        }
    }
    
    // -MARK: private
    
    private func configureEmojiImageView() {
        emojiImageView.setDefaultImage()
        emojiImageView.contentMode = .scaleAspectFill
        emojiImageView.frame.size = CGSize(width: Const.emojiSideSize, height: Const.emojiSideSize)
        self.emojiImageView.clipsToBounds = true
        configureEmojiImageViewConstraints()
    }
    
    private func configureEmojiImageViewConstraints() {
        emojiImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emojiImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            emojiImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            emojiImageView.topAnchor.constraint(equalTo: topAnchor),
            emojiImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private enum Const {
        static let emojiSideSize: CGFloat = 45
    }
}
