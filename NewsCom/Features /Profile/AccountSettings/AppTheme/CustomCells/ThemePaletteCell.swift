//
//  ThemePaletteCell.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 19/05/26.
//

import UIKit
import SnapKit

class ThemePaletteCell: UITableViewCell {
    
    static let identifier: String = "ThemePaletteCell"
    
    private let containerView = UIView()
    private let colorPreview = UIView()
    private let secondaryPreview = UIView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let checkMarkImageView = UIImageView()
        
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    private func setupUI(){
        
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(containerView)
        
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 20
        
        containerView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(6)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        colorPreview.layer.cornerRadius = 18
        containerView.addSubview(colorPreview)
        colorPreview.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(36)
        }
        
        containerView.addSubview(secondaryPreview)
        secondaryPreview.layer.cornerRadius = 18
        
        secondaryPreview.snp.makeConstraints { make in
            make.leading.equalTo(colorPreview.snp.trailing).offset(-10)
            make.centerY.equalTo(colorPreview)
            make.width.height.equalTo(36)
        }
        
        titleLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        titleLabel.textColor = .black
        
        containerView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(18)
            make.leading.equalTo(colorPreview.snp.trailing).offset(16)
        }
        
        subtitleLabel.font = .systemFont(ofSize: 14, weight: .regular)
        subtitleLabel.textColor = .gray
        containerView.addSubview(subtitleLabel)
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.equalTo(titleLabel)
        }
        
        checkMarkImageView.image = UIImage(systemName: "checkmark.circle.fill")
        checkMarkImageView.tintColor = .systemTeal
        containerView.addSubview(checkMarkImageView)
        
        checkMarkImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }
        
    }
    
    func configure(theme: Theme){
        
        titleLabel.text = theme.title
        subtitleLabel.text = theme.subtitle
        colorPreview.backgroundColor = theme.primaryColor
        secondaryPreview.backgroundColor = theme.secondaryColor
        checkMarkImageView.isHidden = !theme.isSelected
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
