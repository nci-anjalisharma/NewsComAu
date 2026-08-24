//
//  PaddingLabel.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 21/07/26.
//
import UIKit

class PaddingLabel: UILabel {

    var textInsets = UIEdgeInsets(top: 6, left: 14, bottom: 6, right: 14)

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textInsets))
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(
            width: size.width + textInsets.left + textInsets.right,
            height: size.height + textInsets.top + textInsets.bottom
        )
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2
        clipsToBounds = true
    }
}
