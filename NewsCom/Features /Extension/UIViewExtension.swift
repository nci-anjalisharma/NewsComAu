//
//  UIViewExtension.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 16/07/26.
//

import UIKit

extension UIView {
    func applyShadowView() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = .init(width: 0, height: 1)
        layer.shadowRadius = 10
    }
}
