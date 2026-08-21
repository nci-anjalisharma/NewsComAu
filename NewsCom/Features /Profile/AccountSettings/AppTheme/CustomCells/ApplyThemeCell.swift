//
//  ApplyThemeCell.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 19/05/26.
//

import UIKit
import SnapKit

class ApplyThemeCell: UITableViewCell {

    static let identifier = "ApplyThemeCell"

    var onApplyTapped: (() -> Void)?

    private let applyButton: UIButton = {

        let button = UIButton(type: .system)

        button.setTitle("Apply Theme", for: .normal)

        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {

        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupUI()
        
        NotificationCenter.default.addObserver(self, selector: #selector(themeChanged), name: .themeChanged, object: nil)
    }
    
    @objc private func themeChanged() {
        applyTheme()
    }
    
    private func applyTheme() {

        let theme = ThemeManager.shared.currentTheme

        applyButton.backgroundColor = theme.colors.surface
        applyButton.setTitleColor(theme.colors.textColor, for: .normal)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
//        let theme = ThemeManager.shared.currentTheme

        selectionStyle = .none
        contentView.addSubview(applyButton)
    
        applyButton.layer.cornerRadius = 10

        applyButton.snp.makeConstraints { make in

            make.leading.trailing.equalToSuperview().inset(30)

            make.top.bottom.equalToSuperview().inset(10)

            make.height.equalTo(50)
        }

        applyButton.addTarget(self, action: #selector(applyTapped), for: .touchUpInside)
    }
    
    func configure(theme: ThemeModel){
        applyButton.backgroundColor = theme.colors.secondary
        applyButton.titleLabel?.textColor = theme.colors.surface
        applyButton.tintColor = theme.colors.surface
    }

    @objc private func applyTapped() {
        
        print("Button Tapped")
        onApplyTapped?()
    }
}
