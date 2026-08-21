//
//  UILabelExtension.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 16/07/26.
//

import UIKit

extension UILabel {
    
    func applyTextShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.45
        layer.shadowRadius = 6
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.masksToBounds = false
    }
}
