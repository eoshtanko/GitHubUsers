//
//  UILabelExtantion.swift
//  GitHubUsers
//
//  Created by Екатерина on 07.07.2022.
//

import UIKit

extension UILabel {
    
    func enableAdjustingFontSizeToFit() {
        minimumScaleFactor = 10 / UIFont.labelFontSize
        adjustsFontSizeToFitWidth = true
    }
}
