//
//  EmojiCollectionViewCell.swift
//  GitHubEmojis
//
//  Created by Екатерина on 06.07.2022.
//

import UIKit

class EmojisCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: EmojisCollectionViewCell.self)
    
    var downloadImageAction: ((String, ((UIImage) -> Void)?) -> Void)?
    
    private let emojiImageView = UIImageView()
    
    // -MARK: override
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        configureEmojiImageView()
    }
    
    override func layoutSubviews() {
         super.layoutSubviews()
         self.emojiImageView.layer.cornerRadius = self.emojiImageView.frame.width / 2
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        emojiImageView.image = UIImage(named: "defaultImage")
    }
    
    // -MARK: internal
    
    func configure(with emojiUrl: String) {
        downloadImageAction?(emojiUrl, setImage)
    }
    
    // -MARK: private
    
    private func addSubviews() {
        addSubview(emojiImageView)
    }
    
    private func configureEmojiImageView() {
        emojiImageView.image = UIImage(named: "defaultImage")
        emojiImageView.contentMode = .scaleAspectFill
        emojiImageView.frame.size = CGSize(width: Const.emojiSideSize, height: Const.emojiSideSize)
        self.emojiImageView.clipsToBounds = true
        
        emojiImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emojiImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            emojiImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            emojiImageView.topAnchor.constraint(equalTo: topAnchor),
            emojiImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setImage(image: UIImage) {
        emojiImageView.image = image
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private enum Const {
        static let emojiSideSize: CGFloat = 60
    }
}
