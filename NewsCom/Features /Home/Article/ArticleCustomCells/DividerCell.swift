//
//  Divider cell.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 18/05/26.
//

import UIKit
import SnapKit

class DividerCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    private func setupUI(){
        
        contentView.backgroundColor = .darkGray
        contentView.layer.cornerRadius = 20
        
        contentView.clipsToBounds = true
        contentView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
            make.height.equalTo(5)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
