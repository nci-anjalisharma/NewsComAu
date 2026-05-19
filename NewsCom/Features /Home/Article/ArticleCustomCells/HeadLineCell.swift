//
//  headLineCell.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 14/05/26.
//

import UIKit
import SnapKit

class HeadLineCell: UITableViewCell {
    
    static let identifier = "HeadLineCell"
    
    private let headlineLabel = UILabel()
    
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
        
    }
    
    private func setupUI(){
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(headlineLabel)
        
        headlineLabel.font = .systemFont(ofSize: 32, weight: .bold)
        headlineLabel.numberOfLines = 0
        headlineLabel.textAlignment = .left
        headlineLabel.textColor = .black
        headlineLabel.text = "The Silent Shift: How Artificial Intelligence is Redefining Personal Connectivity"
         
        headlineLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(5)
            make.leading.trailing.bottom.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(5)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
