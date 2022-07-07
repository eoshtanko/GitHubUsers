//
//  EmojisViewController + UICollectionViewDataSource.swift
//  GitHubEmojis
//
//  Created by Екатерина on 06.07.2022.
//

import UIKit

extension EmojisViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        emojiList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: EmojisCollectionViewCell.identifier,
            for: indexPath
        )
        guard let emojiCell = cell as? EmojisCollectionViewCell else {
            return cell
        }
        emojiCell.downloadImageAction = downloadImageService.downloadImage
        emojiCell.configure(with: emojiList[indexPath.row])
        
        return emojiCell
    }
}
