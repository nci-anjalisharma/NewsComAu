//
//  TotalReadingTimeCell.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 31/07/26.
//

import UIKit
import SnapKit

final class TotalReadingTimeCell: UITableViewCell {

    static let identifier = "TotalReadingTimeCell"

    private let cardView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 24
        view.layer.borderWidth = 1
        view.clipsToBounds = true
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "TOTAL READING TIME"
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        return label
    }()

    private let readingTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(
            name: "Georgia-Bold",
            size: 32
        ) ?? .boldSystemFont(ofSize: 32)
        return label
    }()

    private let dividerView: UIView = {
        let view = UIView()
        return view
    }()

    private let articlesValueLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()

    private let articlesLabel: UILabel = {
        let label = UILabel()
        label.text = "articles"
        label.font = .systemFont(ofSize: 14)
        return label
    }()

    private let changeValueLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        return label
    }()

    private let changeLabel: UILabel = {
        let label = UILabel()
        label.text = "vs last day"
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 1
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear

        setupView()
        setupConstraints()
        applyTheme()

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(themeChanged),
            name: .themeChanged,
            object: nil
        )
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    private func setupView() {

        contentView.addSubview(cardView)

        cardView.addSubview(titleLabel)
        cardView.addSubview(readingTimeLabel)
        cardView.addSubview(dividerView)

        cardView.addSubview(articlesValueLabel)
        cardView.addSubview(articlesLabel)

        cardView.addSubview(changeValueLabel)
        cardView.addSubview(changeLabel)
    }



    private func applyTheme() {

        let theme = ThemeManager.shared.currentTheme

        backgroundColor = .clear
        contentView.backgroundColor = .clear

        cardView.backgroundColor = theme.colors.surface
        cardView.layer.borderColor = theme.colors.primary.cgColor

        titleLabel.textColor = theme.colors.secondary

        readingTimeLabel.textColor = theme.colors.primary

        dividerView.backgroundColor = theme.colors.secondary.withAlphaComponent(0.25)

        articlesValueLabel.textColor = theme.colors.primary

        articlesLabel.textColor = theme.colors.secondary

        changeValueLabel.textColor = theme.colors.primary

        changeLabel.textColor = theme.colors.secondary
    }

    @objc private func themeChanged() {
        applyTheme()
    }

    func configure(readingTime: String, articles: Int, percentageChange: Int) {
        
        readingTimeLabel.text = readingTime
        articlesValueLabel.text = "\(articles)"

        if percentageChange >= 0 {
            changeValueLabel.text = "↑ \(percentageChange)%"
        } else {
            changeValueLabel.text = "↓ \(abs(percentageChange))%"
        }
    }


    private func setupConstraints() {

        cardView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(10)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.leading.trailing.equalToSuperview().inset(24)
        }

        readingTimeLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(24)
        }

        dividerView.snp.makeConstraints {
            $0.top.equalTo(readingTimeLabel.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(1)
        }

        // Articles

        articlesValueLabel.snp.makeConstraints {
            $0.top.equalTo(dividerView.snp.bottom).offset(18)
            $0.leading.equalToSuperview().offset(24)
        }

        articlesLabel.snp.makeConstraints {
            $0.top.equalTo(articlesValueLabel.snp.bottom).offset(2)
            $0.leading.equalTo(articlesValueLabel)
            $0.bottom.equalToSuperview().inset(24)
        }

        // Topics

    

        // Change

        changeValueLabel.snp.makeConstraints {
            $0.top.equalTo(articlesValueLabel)
            $0.trailing.equalToSuperview().inset(24)
        }

        changeLabel.snp.makeConstraints {
            $0.top.equalTo(changeValueLabel.snp.bottom).offset(2)
            $0.trailing.equalToSuperview().inset(24)
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        readingTimeLabel.text = nil
        articlesValueLabel.text = nil
        changeValueLabel.text = nil
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
