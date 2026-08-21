//
//  ContentSettingCell.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 09/07/26.
//

import UIKit
import SnapKit

class ContentSettingSegmentCell: UITableViewCell {

    static let identifier = "ContentSettingSegmentCell"

    private let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 24
        view.layer.borderWidth = 1
//        view.layer.borderColor = UIColor.systemGray5.cgColor
        view.clipsToBounds = true
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Article Length Preference"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .label
        return label
    }()

    private let segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["Short", "Medium", "Full"])
        control.selectedSegmentIndex = 1

        control.backgroundColor = .systemGray6
        control.selectedSegmentTintColor = .white

        control.setTitleTextAttributes(
            [
                .font: UIFont.systemFont(ofSize: 12, weight: .regular),
                .foregroundColor: UIColor.label
            ],
            for: .normal
        )

        control.setTitleTextAttributes(
            [
                .font: UIFont.systemFont(ofSize: 12, weight: .semibold),
                .foregroundColor: UIColor.label
            ],
            for: .selected
        )

        return control
    }()
    
    @objc private func segmentedChanged(_ sender: UISegmentedControl) {

        let preference: String

        switch sender.selectedSegmentIndex {
        case 0:
            preference = "short"
        case 1:
            preference = "medium"
        default:
            preference = "full"
        }

        UserDefaults.standard.set(preference, forKey: "ArticleLength")
    }
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text =
        """
        Adjusts how summaries and full texts are
        prioritized in your feed.
        """
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14)
        label.textColor = .secondaryLabel
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {

        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear

        contentView.addSubview(cardView)

        cardView.addSubview(titleLabel)
        cardView.addSubview(segmentedControl)
        cardView.addSubview(descriptionLabel)

        segmentedControl.addTarget(self, action: #selector(segmentedChanged(_:)), for: .valueChanged)
        
        loadSavedPreference()
        setupConstraints()
        applyTheme()
        
        NotificationCenter.default.addObserver(
                self,
                selector: #selector(themeChanged),
                name: .themeChanged,
                object: nil
            )
    }
    
    private func applyTheme() {

        let theme = ThemeManager.shared.currentTheme

        backgroundColor = .clear
        contentView.backgroundColor = .clear

        cardView.backgroundColor = theme.colors.surface
        

        titleLabel.textColor = theme.colors.primary
        descriptionLabel.textColor = theme.colors.secondary

        segmentedControl.backgroundColor = theme.colors.background
        segmentedControl.selectedSegmentTintColor = theme.colors.primary

        segmentedControl.setTitleTextAttributes(
            [
                .foregroundColor: theme.colors.secondary,
                .font: UIFont.systemFont(ofSize: 12, weight: .regular)
            ],
            for: .normal
        )

        segmentedControl.setTitleTextAttributes(
            [
                .foregroundColor: theme.colors.surface,
                .font: UIFont.systemFont(ofSize: 12, weight: .semibold)
            ],
            for: .selected
        )
    }
    
    private func loadSavedPreference() {

        let preference = UserDefaults.standard.string(forKey: "ArticleLength") ?? "medium"

        switch preference {
        case "short":
            segmentedControl.selectedSegmentIndex = 0

        case "medium":
            segmentedControl.selectedSegmentIndex = 1

        case "full":
            segmentedControl.selectedSegmentIndex = 2

        default:
            segmentedControl.selectedSegmentIndex = 1
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupConstraints() {

        cardView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(28)
            $0.leading.trailing.equalToSuperview().inset(24)
        }

        segmentedControl.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(28)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(46)
        }

        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(segmentedControl.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().offset(-28)
        }
    }
    
    @objc private func themeChanged() {
        applyTheme()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
