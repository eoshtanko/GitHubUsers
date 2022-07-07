//
//  UILabelExtantion.swift
//  GitHubUsers
//
//  Created by Екатерина on 07.07.2022.
//

import UIKit

extension UILabel {
    
    func enableAdjustingFontSizeToFit() {
        let minimumFontSize: CGFloat = 10
        minimumScaleFactor = minimumFontSize / UIFont.labelFontSize
        adjustsFontSizeToFitWidth = true
    }
}
