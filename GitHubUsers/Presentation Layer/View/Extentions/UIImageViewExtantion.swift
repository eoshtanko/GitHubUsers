//
//  UIImageViewExtantion.swift
//  GitHubUsers
//
//  Created by Екатерина on 06.07.2022.
//

import UIKit

extension UIImageView {
    
    func roundСorners() {
        layer.cornerRadius = frame.width / 2
    }
    
    func setDefaultImage() {
        image = UIImage(named: "defaultImage")
    }
}
