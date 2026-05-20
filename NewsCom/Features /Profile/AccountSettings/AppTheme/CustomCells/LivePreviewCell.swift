//
//  LivePreviewCell.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 19/05/26.
//

import UIKit
import SnapKit

class LivePreviewCell: UITableViewCell {
    
    static let identifier: String = "LivePreviewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
