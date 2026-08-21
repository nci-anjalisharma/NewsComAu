//
//  SettingTableViewCell.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 07/05/26.
//

import UIKit
import SnapKit

class SettingTableViewCell: UITableViewCell {
    
    private let iconImageView = UIImageView()
    private let titleLabel = UILabel()
    private let rightImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    private func setupUI(){
        
        titleLabel.font = .systemFont(ofSize: 16, weight: .regular)
        
        rightImageView.image = UIImage(systemName: "chevron.right")
        
        contentView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(rightImageView)
        
        iconImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(20)
        }

        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).offset(20)
            make.centerY.equalToSuperview()
        }

        rightImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
        }
    }
    
    func configure(title: String, icon: String) {
        
        let theme = ThemeManager.shared.currentTheme

        backgroundColor = .clear
        contentView.backgroundColor = theme.colors.background
        
        titleLabel.text = title
        
        titleLabel.textColor = theme.colors.primary
        iconImageView.image = UIImage(systemName: icon)
        iconImageView.tintColor = theme.colors.secondary
        rightImageView.tintColor = theme.colors.secondary
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
