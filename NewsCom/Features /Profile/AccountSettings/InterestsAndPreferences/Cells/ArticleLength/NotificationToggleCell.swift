//
//  ContentSettingsCustom.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 09/07/26.
//

import UIKit
import SnapKit

class NotificationToggleCell: UITableViewCell {

    static let identifier = "NotificationToggleCell"

    private let titleLabel = UILabel()

    private let subtitleLabel = UILabel()

    let toggleSwitch = UISwitch()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {

        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none

        subtitleLabel.numberOfLines = 0
        subtitleLabel.textColor = .gray
        subtitleLabel.font = .systemFont(ofSize: 15)

        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)

        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(toggleSwitch)

        titleLabel.snp.makeConstraints {
            $0.leading.top.equalToSuperview().offset(20)
        }

        subtitleLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel)
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.bottom.equalToSuperview().offset(-20)
        }

        toggleSwitch.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-20)
            $0.centerY.equalToSuperview()
        }
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    func configure(with item: NotificationItem) {

        titleLabel.text = item.title
        subtitleLabel.text = item.subtitle
        toggleSwitch.isOn = item.isEnabled
    }
}
