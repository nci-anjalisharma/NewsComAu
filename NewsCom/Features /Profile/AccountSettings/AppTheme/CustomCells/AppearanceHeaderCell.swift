//
//  AppearanceHeaderCell.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 19/05/26.
//
import UIKit
import SnapKit

class AppearanceHeaderCell: UITableViewCell {

    static let identifier = "AppearanceHeaderCell"

    var onAppearanceChanged: ((Int) -> Void)?

    private let containerView = UIView()
    private let titleLabel = UILabel()

    let segmentedControl = UISegmentedControl(items: ["Light", "Dark"])

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupUI()

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(themeChanged),
            name: .themeChanged,
            object: nil
        )
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc
    private func themeChanged() {
        applyTheme()
    }

    func configure(theme: ThemeModel, appearance: UIUserInterfaceStyle) {

        backgroundColor = theme.colors.background

        containerView.backgroundColor = theme.colors.surface

        titleLabel.textColor = theme.colors.primary

        segmentedControl.backgroundColor = theme.colors.surface
        segmentedControl.selectedSegmentTintColor = theme.colors.secondary

        segmentedControl.setTitleTextAttributes(
            [.foregroundColor: UIColor.white],
            for: .selected
        )

        segmentedControl.setTitleTextAttributes(
            [.foregroundColor: theme.colors.secondary],
            for: .normal
        )

        segmentedControl.selectedSegmentIndex =
            appearance == .dark ? 1 : 0
    }

    private func applyTheme() {

        let theme = ThemeManager.shared.currentTheme

//        backgroundColor = theme.colors.background
        backgroundColor = .clear

        containerView.backgroundColor = theme.colors.background

        titleLabel.textColor = theme.colors.primary

        segmentedControl.backgroundColor = theme.colors.surface

        segmentedControl.selectedSegmentTintColor = theme.colors.secondary

        segmentedControl.setTitleTextAttributes(
            [.foregroundColor: UIColor.white],
            for: .selected
        )

        segmentedControl.setTitleTextAttributes(
            [.foregroundColor: theme.colors.secondary],
            for: .normal
        )
    }

    private func setupUI() {

        contentView.backgroundColor = .clear
        selectionStyle = .none

        contentView.addSubview(containerView)

        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        titleLabel.text = "APPEARANCE MODE"
        titleLabel.font = .systemFont(ofSize: 18, weight: .semibold)

        containerView.addSubview(titleLabel)

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
        }

        segmentedControl.selectedSegmentIndex = 0

        containerView.addSubview(segmentedControl)

        segmentedControl.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(50)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(12)
        }
        segmentedControl.addTarget(
            self,
            action: #selector(appearanceChanged),
            for: .valueChanged
        )
    }

    @objc
    private func appearanceChanged() {

        onAppearanceChanged?(segmentedControl.selectedSegmentIndex)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
