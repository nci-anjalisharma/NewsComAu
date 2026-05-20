//
//  BreakingNewsTableViewCell.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 10/05/26.
//

import UIKit
import SnapKit


class BreakingNewsCollectionViewCell: UICollectionViewCell {
    
    
    
    
    static let identifier = "BreakingNewsCollectionViewCell"

    
    
    let breakingNewsImage = UIImageView()
    let titleLabel = UILabel()
    let breakingHeadLine = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        
    }
    
    private func setupUI() {
        
        contentView.backgroundColor = .white
        
        contentView.layer.cornerRadius = 16
        contentView.clipsToBounds = true
        
        breakingHeadLine.clipsToBounds = true
        
        
        breakingNewsImage.contentMode = .scaleAspectFill
        breakingNewsImage.clipsToBounds = true
        
        
        titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        titleLabel.textColor = .gray
        titleLabel.numberOfLines = 2
        
        breakingHeadLine.font = .systemFont(ofSize: 14, weight: .bold)
        breakingHeadLine.textColor = .black
        breakingHeadLine.numberOfLines = 0
        
        contentView.addSubview(breakingHeadLine)
        contentView.addSubview(breakingNewsImage)
        contentView.addSubview(titleLabel)
        
        
        breakingNewsImage.snp.makeConstraints { make in
            
            make.top.leading.trailing.equalToSuperview()
            
            make.height.equalTo(150)
        }
        
        
        titleLabel.snp.makeConstraints { make in
            
            make.top.equalTo(breakingNewsImage.snp.bottom).offset(2)
            
            make.leading.trailing.equalToSuperview().inset(10)
            
        }
        
        breakingHeadLine.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(2)
            make.leading.trailing.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(10)
        }
    }
    
    
    
    
    
    func configure(title: String, imageName: String, headLine: String){
        
        titleLabel.text = title
        breakingHeadLine.text = headLine
        breakingNewsImage.image = UIImage(named: imageName)
    }
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
