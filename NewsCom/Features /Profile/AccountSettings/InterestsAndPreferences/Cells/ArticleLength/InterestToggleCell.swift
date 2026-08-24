//
//  TopicsForYouCustomCell.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 08/07/26.
//


import UIKit
import SnapKit

class InterestToggleCell: UITableViewCell {

    static let identifier = "InterestToggleCell"

    private let iconView = UIImageView()

    private let titleLabel = UILabel()

    let toggleSwitch = UISwitch()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {

        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none

        contentView.addSubview(iconView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(toggleSwitch)

        iconView.tintColor = .darkGray

        titleLabel.font = .systemFont(ofSize: 18, weight: .semibold)

        iconView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(28)
        }

        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(iconView.snp.trailing).offset(16)
            $0.centerY.equalToSuperview()
        }

        toggleSwitch.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-20)
            $0.centerY.equalToSuperview()
        }
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    func configure(with item: InterestItem) {

        iconView.image = item.icon
        titleLabel.text = item.title
        toggleSwitch.isOn = item.isEnabled
    }
}
