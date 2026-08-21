//
//  ReadingStreakCell.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 31/07/26.
//
//
//  ReadingStreakCell.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 31/07/26.
//

import UIKit
import SnapKit

final class ReadingStreakCell: UITableViewCell {

    static let identifier = "ReadingStreakCell"

    // MARK: - UI Elements

    private let cardView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 24
        view.layer.borderWidth = 1
        view.clipsToBounds = true
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "READING STREAK", attributes: [.kern: 1.0])
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        return label
    }()

    private let fireImageView: UIImageView = {
        let imageView = UIImageView(
            image: UIImage(systemName: "flame.fill")
        )
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let streakValueLabel: UILabel = {
        let label = UILabel()
//        label.text = "14"
        label.font = UIFont(
            name: "Georgia-Bold",
            size: 44
        ) ?? .boldSystemFont(ofSize: 44)
        return label
    }()

    private let daysLabel: UILabel = {
        let label = UILabel()
        label.text = "days"
        label.font = .systemFont(ofSize: 17, weight: .medium)
        return label
    }()

    private let streakCaptionLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "CURRENT STREAK", attributes: [.kern: 0.8])
        label.font = .systemFont(ofSize: 11, weight: .medium)
        return label
    }()

    private let dividerView: UIView = {
        let view = UIView()
        return view
    }()

    private let bestTitleLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "PERSONAL BEST", attributes: [.kern: 0.7])
        label.font = .systemFont(ofSize: 11, weight: .semibold)
        return label
    }()

    private let bestValueLabel: UILabel = {
        let label = UILabel()
//        label.text = "22 days"
        label.font = .systemFont(ofSize: 17, weight: .bold)
        return label
    }()

    private let progressBackgroundView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 4
        view.clipsToBounds = true
        return view
    }()

    private let progressView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 4
        view.clipsToBounds = true
        return view
    }()

    private let messageLabel: UILabel = {
        let label = UILabel()
        label.text = "Keep going to beat your record!"
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.numberOfLines = 2
        return label
    }()

    // MARK: - Init

    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(
            style: style,
            reuseIdentifier: reuseIdentifier
        )

        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear

        setupView()
        setupConstraints()
        applyTheme()

        NotificationCenter.default.addObserver(self, selector: #selector(themeChanged), name: .themeChanged, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    private func setupView() {

        contentView.addSubview(cardView)

        cardView.addSubview(titleLabel)
        cardView.addSubview(fireImageView)

        cardView.addSubview(streakValueLabel)
        cardView.addSubview(daysLabel)
        cardView.addSubview(streakCaptionLabel)

        cardView.addSubview(dividerView)

        cardView.addSubview(bestTitleLabel)
        cardView.addSubview(bestValueLabel)

        cardView.addSubview(progressBackgroundView)
        progressBackgroundView.addSubview(progressView)

        cardView.addSubview(messageLabel)
    }

    // MARK: - Theme

    private func applyTheme() {

        let theme = ThemeManager.shared.currentTheme

        backgroundColor = .clear
        contentView.backgroundColor = .clear

        cardView.backgroundColor = theme.colors.surface

        cardView.layer.borderColor = theme.colors.primary.cgColor

        titleLabel.textColor = theme.colors.secondary

        fireImageView.tintColor = theme.colors.primary

        streakValueLabel.textColor = theme.colors.primary

        daysLabel.textColor = theme.colors.primary

        streakCaptionLabel.textColor = theme.colors.secondary.withAlphaComponent(0.70)

        dividerView.backgroundColor =
            theme.colors.secondary
                .withAlphaComponent(0.18)

        bestTitleLabel.textColor =
            theme.colors.secondary

        bestValueLabel.textColor =
            theme.colors.primary

        progressBackgroundView.backgroundColor =
            theme.colors.secondary
                .withAlphaComponent(0.12)

        progressView.backgroundColor =
            theme.colors.primary

        messageLabel.textColor =
            theme.colors.secondary
    }

    @objc private func themeChanged() {
        applyTheme()
    }

    // MARK: - Configuration

    func configure(currentStreak: Int,
        personalBest: Int
    ) {

        streakValueLabel.text = "\(currentStreak)"
        bestValueLabel.text = "\(personalBest) days"

        // MARK: Progress

        let progress: CGFloat

        if personalBest > 0 {
            progress = min(CGFloat(currentStreak) / CGFloat(personalBest), 1.0)
        } else {
            progress = 0
        }

        progressView.snp.remakeConstraints {
            $0.leading.top.bottom.equalToSuperview()
            $0.width.equalTo(progressBackgroundView.snp.width).multipliedBy(progress)
        }

        // MARK: Message

        if currentStreak > personalBest {

            messageLabel.text = "New personal best!"

        } else if currentStreak == personalBest {

            messageLabel.text = "You've matched your best!"

        } else {

            let remaining = personalBest - currentStreak

            if remaining == 1 {

                messageLabel.text = "Just 1 more day to beat your record!"

            } else {

                messageLabel.text = "\(remaining) more days to beat your record!"
            }
        }
    }

    // MARK: - Constraints

    private func setupConstraints() {

        // MARK: Card

        cardView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(10)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        // MARK: Header

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(22)
            $0.leading.equalToSuperview().offset(24)
        }

        fireImageView.snp.makeConstraints {
//            $0.centerY.equalTo(titleLabel)
            $0.centerY.equalTo(streakValueLabel)
            $0.trailing.equalToSuperview().inset(30)
            $0.width.height.equalTo(50)
        }
        

//         MARK: Current Streak

        streakValueLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(14)
            $0.leading.equalToSuperview().offset(24)
        }

        daysLabel.snp.makeConstraints {
            $0.firstBaseline.equalTo(streakValueLabel.snp.firstBaseline)
            $0.leading.equalTo(streakValueLabel.snp.trailing).offset(8)
        }

        streakCaptionLabel.snp.makeConstraints {
            $0.top.equalTo(streakValueLabel.snp.bottom).offset(6)
            $0.leading.equalTo(streakValueLabel)
        }
        
        // MARK: Divider

        dividerView.snp.makeConstraints {
            $0.top.equalTo(streakCaptionLabel.snp.bottom).offset(18)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(1)
        }

        // MARK: Personal Best

        bestTitleLabel.snp.makeConstraints {
            $0.top.equalTo(dividerView.snp.bottom).offset(16)

            $0.leading.equalToSuperview().offset(24)
        }

        bestValueLabel.snp.makeConstraints {
            $0.centerY.equalTo(bestTitleLabel)
            $0.trailing.equalToSuperview().inset(24)
        }

        // MARK: Progress

        progressBackgroundView.snp.makeConstraints {
            $0.top.equalTo(bestTitleLabel.snp.bottom).offset(10)

            $0.leading.trailing.equalToSuperview().inset(24)

            $0.height.equalTo(7)
        }

        progressView.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview()
            $0.width.equalTo(0)
        }

        // MARK: Message

        messageLabel.snp.makeConstraints {
            $0.top.equalTo(progressBackgroundView.snp.bottom).offset(12)

            $0.leading.trailing.equalToSuperview().inset(24)

            $0.bottom.equalToSuperview().inset(20)
        }
    }

    // MARK: - Reuse

    override func prepareForReuse() {
        super.prepareForReuse()

        streakValueLabel.text = nil
        bestValueLabel.text = nil
        messageLabel.text = nil

        progressView.snp.remakeConstraints {
            $0.leading.top.bottom.equalToSuperview()
            $0.width.equalTo(0)
        }
    }

    // MARK: - Deinit

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

