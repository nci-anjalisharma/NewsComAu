//
//  TopicAndTimeCell.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 14/05/26.
//

import UIKit
import SnapKit

class TopicAndTimeCell: UITableViewCell {
    
    static let identifier = "TopicAndTimeCell"
    
    private let stackView = UIStackView()
    private let articleReadTime = UILabel()
    private let articleTopic = UILabel()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    private func setupUI() {
        
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        selectionStyle = .none
        
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .center
        
        contentView.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
        
        articleTopic.text = "TECH TRENDS"
        articleTopic.textColor = .white
        articleTopic.backgroundColor = .systemBlue
        articleTopic.layer.cornerRadius = 12
        articleTopic.font = .systemFont(ofSize: 12, weight: .bold)
        
        articleTopic.snp.makeConstraints { make in
            make.height.equalTo(25)
            make.width.equalTo(100)
        }
        
        articleReadTime.text = "12 MIN READ"
        articleReadTime.textColor = .lightGray
        articleReadTime.font = .systemFont(ofSize: 12, weight: .medium)
        
        stackView.addArrangedSubview(articleTopic)
        stackView.addArrangedSubview(articleReadTime)
        
    }
    
    func configure(topic: String, time: String){
        articleReadTime.text = topic
        articleReadTime.text = time
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
