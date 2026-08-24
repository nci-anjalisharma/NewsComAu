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
    private let divider = UILabel()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    private func setupUI() {
        
        contentView.backgroundColor = .clear
        selectionStyle = .none
        
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .leading
        stackView.layer.cornerRadius = 8
        
        contentView.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(22)
            make.bottom.equalToSuperview().inset(2)
        }
        
       
        articleTopic.font = .systemFont(ofSize: 12, weight: .bold)
        
//        articleTopic.snp.makeConstraints { make in
//            make.height.equalTo(30)
//            make.width.equalTo(60)
//        }
        
        divider.text = "|"
        divider.textColor = .black
        divider.font = .systemFont(ofSize: 12, weight: .semibold)
        
        articleReadTime.textColor = .black
        articleReadTime.font = .systemFont(ofSize: 12, weight: .medium)
        
        stackView.addArrangedSubview(articleTopic)
        stackView.addArrangedSubview(divider)
        stackView.addArrangedSubview(articleReadTime)

    }
    
    func configure(article: Article){
        let theme = ThemeManager.shared.currentTheme
        
        backgroundColor = theme.colors.background
//        articleReadTime.text = "12 MIN READ"
        articleReadTime.textColor = theme.colors.secondary
        articleTopic.text = article.source?.name
        articleTopic.textColor = theme.colors.primary
        
        let hash = abs((article.title ?? "").hashValue)
        let readTime = (hash % 10) + 3   // 3–12 minutes

        articleReadTime.text = "\(readTime) MIN READ"
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
