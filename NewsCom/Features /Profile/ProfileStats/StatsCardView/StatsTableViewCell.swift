//
//  StatsTableViewCell.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 07/05/26.
//


import UIKit
import SnapKit

class StatsTableViewCell: UITableViewCell {
    
    let stackView = UIStackView()
    
    let articlesCard = StatsCardView()
    let savedCard = StatsCardView()
    let topicsCard = StatsCardView()
    
    
    
    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupStackView()
        
    }
    
    private func setupStackView() {
        
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        
        
        contentView.addSubview(stackView)
        
        
        stackView.snp.makeConstraints { make in
            
            make.top.equalToSuperview().offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(10)
            make.height.equalTo(100)
        }
        
        [articlesCard, savedCard, topicsCard].forEach{
            
            stackView.addArrangedSubview($0)
        }
    }
    
    
    
    func configure(articlesRead: String, saved: String, topics: String) {
        
        articlesCard.configure(count: articlesRead, title: "ARTICLES READ")
        savedCard.configure(count: saved, title: "SAVED")
        topicsCard.configure(count: topics, title: "TOPICS FOLLOWED")
    }
    

        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
    
    

