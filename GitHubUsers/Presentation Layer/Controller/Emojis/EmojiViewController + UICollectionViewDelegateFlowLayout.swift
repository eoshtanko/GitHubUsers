//
//  EmojiViewController + UICollectionViewDelegateFlowLayout.swift
//  GitHubUsers
//
//  Created by Екатерина on 06.07.2022.
//

import UIKit

extension EmojiViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = collectionView.bounds.width / Const.density
        return CGSize(width: itemWidth, height: itemWidth)
    }
}
