//
//  DataManagementCell.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 20/07/26.
//

import UIKit
import SnapKit

class DataManagementCell: UITableViewCell {
    
    static let identifier = "DataManagementCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .label
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        return label
    }()
    
    let clearButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Clear", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(clearButton)
        
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(20)
            $0.trailing.equalTo(clearButton.snp.leading).offset(-16)
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(6)
            $0.leading.equalTo(titleLabel)
            $0.trailing.equalTo(clearButton.snp.leading).offset(-16)
            $0.bottom.equalToSuperview().inset(20)
        }
        
        clearButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
            $0.width.equalTo(80)
        }
        
        applyTheme()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(themeChanged),
            name: .themeChanged,
            object: nil
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configure(with option: DataManagementOption) {
        titleLabel.text = option.title
        subtitleLabel.text = option.subtitle
    }
    
    private func applyTheme() {
        
        let theme = ThemeManager.shared.currentTheme
        
        backgroundColor = .clear
        contentView.backgroundColor = theme.colors.surface
        
        titleLabel.textColor = theme.colors.primary
        subtitleLabel.textColor = theme.colors.secondary
        
        clearButton.setTitleColor(theme.colors.primary, for: .normal)
    }
    
    @objc private func themeChanged() {
        applyTheme()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
