//
//  AttributedArticleContentCell.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 15/05/26.
//

import UIKit
import SnapKit

class AttributedArticleContentCell: UITableViewCell {
    
    static let identifier = "AttributedArticleContentCell"
    
    private let containerView = UIView()
    private let leftBorderView = UIView()
    private let quoteLabel = UILabel()


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    private func setupUI(){
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        selectionStyle = .none
        
        containerView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
        containerView.layer.cornerRadius = 15
        
        contentView.addSubview(containerView)
        
        containerView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(12)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
