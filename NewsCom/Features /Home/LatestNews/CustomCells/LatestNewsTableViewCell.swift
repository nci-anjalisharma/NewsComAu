//
//  LatestNewsTableViewCell.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 07/05/26.
//

import UIKit
import SnapKit

class LatestNewsTableViewCell: UITableViewCell {
    
    private var articleImageView = UIImageView()
    private var title = UILabel()
    private var headLine = UILabel()
    private var timeLine = UILabel()
    private var textStackView = UIStackView()
    
    private let cardView = UIView()
    
    private var item: Article?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    
    private func setupUI(){
        let theme = ThemeManager.shared.currentTheme
        
        selectionStyle = .none
//        backgroundColor = .clear
//        
//        contentView.backgroundColor = .clear
        contentView.layer.cornerRadius = 15
        contentView.layer.masksToBounds = true
        
        cardView.layer.cornerRadius = 16
        cardView.layer.masksToBounds = true

        contentView.addSubview(cardView)

        cardView.snp.makeConstraints { make in
//            make.edges.equalToSuperview().inset(8)
            make.top.equalToSuperview().offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(155)
        }
      
        articleImageView.contentMode = .scaleAspectFill
        articleImageView.layer.cornerRadius = 10
        articleImageView.clipsToBounds = true
        articleImageView.addImagePlaceholder()
        
        title.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        title.tintColor = theme.colors.secondary

        
        headLine.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        headLine.numberOfLines = 4
        headLine.textColor = theme.colors.textColor
        
        timeLine.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        timeLine.textColor = theme.colors.secondary
        
        textStackView.axis = .vertical
        textStackView.spacing = 6
        textStackView.backgroundColor = .clear
        
        textStackView.addArrangedSubview(title)
        textStackView.addArrangedSubview(headLine)
        textStackView.addArrangedSubview(timeLine)
        
        cardView.addSubview(textStackView)
        cardView.addSubview(articleImageView)
        
        textStackView.snp.makeConstraints { make in
            make.leading.equalTo(articleImageView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().inset(10)
            make.centerY.equalTo(articleImageView)
        }
        
        articleImageView.snp.makeConstraints{ make in
            make.leading.top.bottom.equalToSuperview()
            make.width.equalTo(110)
            make.height.equalTo(90)
        }
    }

    
    func configure(item: Article) {

        let theme = ThemeManager.shared.currentTheme
        
        backgroundColor = theme.colors.background
        
//                contentView.backgroundColor = .clear

        cardView.backgroundColor = theme.colors.secondary.withAlphaComponent(0.1)

        title.textColor = theme.colors.primary
        headLine.textColor = theme.colors.textColor
        timeLine.textColor = theme.colors.secondary

        title.text = item.source?.name
        headLine.text = item.title
        timeLine.text = formattedDate(from: item.publishedAt ?? "")

        articleImageView.loadImage(from: item.urlToImage ?? "")
    }
    
    private func formattedDate(from isoDate: String) -> String {
        let formatter = ISO8601DateFormatter()

        guard let date = formatter.date(from: isoDate) else {
            return isoDate
        }

        let output = DateFormatter()
        output.dateFormat = "dd MMM • h:mm a"

        return output.string(from: date)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

        articleImageView.image = nil
        articleImageView.showPlaceholder()

        title.text = nil
        headLine.text = nil
        timeLine.text = nil
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
