//
//  LatestNewsTableViewCell.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 07/05/26.
//

import UIKit
import SnapKit


class LatestNewsTableViewCell: UITableViewCell {
    
    let articleImageView = UIImageView()
    let title = UILabel()
    let headLine = UILabel()
    let timeLine = UILabel()
    let textStackView = UIStackView()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    
    private func setupUI(){
        
        selectionStyle = .blue
        backgroundColor = .clear
        
         
        articleImageView.contentMode = .scaleAspectFill
        articleImageView.layer.cornerRadius = 10
        articleImageView.clipsToBounds = true
        
        title.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        title.tintColor = UIColor(named: "BlueSet")
        
        headLine.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        headLine.numberOfLines = 4
        headLine.textColor = .black
        
        timeLine.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        timeLine.textColor = UIColor.gray
        
        textStackView.axis = .vertical
        textStackView.spacing = 6
        
        
        
        textStackView.addArrangedSubview(title)
        textStackView.addArrangedSubview(headLine)
        textStackView.addArrangedSubview(timeLine)
        
         
        contentView.layer.cornerRadius = 15
        contentView.backgroundColor = .lightGray.withAlphaComponent(0.1)
        contentView.layer.masksToBounds = true
        
        contentView.addSubview(textStackView)
        contentView.addSubview(articleImageView)
        
        
        textStackView.snp.makeConstraints { make in
            make.leading.equalTo(articleImageView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().inset(10)
            make.centerY.equalTo(articleImageView)
            
        }
        
        
        articleImageView.snp.makeConstraints{ make in
            make.leading.top.bottom.equalToSuperview().inset(10)
            make.width.equalTo(110)
            make.height.equalTo(130)
        }
        
    }
    
    func configure(article: Article){
        title.text = article.author
        headLine.text = article.description
        timeLine.text = "2 hours ago"
        
        articleImageView.image = UIImage(named: article.imageURL)
        
    }
    
    
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
