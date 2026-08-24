//
//  Divider cell.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 18/05/26.
//
import UIKit
import SnapKit

class DividerCell: UITableViewCell {

    static let identifier = "DividerCell"

    private let dividerView = UIView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    private func setupUI() {

        let theme = ThemeManager.shared.currentTheme

        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear

        dividerView.backgroundColor = theme.colors.secondary.withAlphaComponent(0.1)
        dividerView.layer.cornerRadius = 0.5

        contentView.addSubview(dividerView)

        dividerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.bottom.equalToSuperview().inset(8)
            make.height.equalTo(1)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
