//
//  ST.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 08/05/26.
//

import UIKit
import SnapKit


class StatsCardView: UIView {
    
    let countLabel = UILabel()
    let titleLabel = UILabel()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setupUI()
    }
    
    private func setupUI(){
        let theme = ThemeManager.shared.currentTheme
        
        let isDark = traitCollection.userInterfaceStyle == .dark

//        layer.shadowOpacity = isDark ? 0.45 : 0.12
//        layer.shadowRadius = isDark ? 20 : 10
        
//        backgroundColor = theme.colors.surface.withAlphaComponent(0.95)
        backgroundColor = theme.colors.surface

        layer.cornerRadius = 18
        layer.borderWidth = 1
        
//        layer.shadowColor = UIColor.black.cgColor
//        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.masksToBounds = false
        
        countLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        countLabel.textAlignment = .center
        
        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 2
        
        addSubview(countLabel)
        addSubview(titleLabel)
        
        countLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(25)
            make.leading.trailing.equalToSuperview().inset(8)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(countLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(8)
        }
    }
    
    func configure(count: String, title: String){
        
        countLabel.text = count
        titleLabel.text = title
        
        let theme = ThemeManager.shared.currentTheme
        
//        backgroundColor = theme.colors.primary.withAlphaComponent(0.1)
//        backgroundColor = .clear
        
        countLabel.textColor = theme.colors.primary
        titleLabel.textColor = theme.colors.secondary
    }
    
    required init?(coder: NSCoder){
        fatalError("init(coder: has not been implemented")
    }
}
