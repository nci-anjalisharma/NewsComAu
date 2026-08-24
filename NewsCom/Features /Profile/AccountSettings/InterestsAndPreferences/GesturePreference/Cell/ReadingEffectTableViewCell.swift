//
//  ReadingEffectTableViewCell.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 22/07/26.
//


import UIKit
import SnapKit

class ReadingEffectTableViewCell: UITableViewCell {

    static let identifier = "ReadingEffectTableViewCell"

    private let cardView = UIView()

    private let iconImageView = UIImageView()

    private let titleLabel = UILabel()

    private let subtitleLabel = UILabel()

    private let checkmarkImageView = UIImageView()

    private let textStackView = UIStackView()
    
    private var hasAnimatedBadge = false

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        configureViews()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with effect: ReadingEffect, isSelected: Bool) {

        iconImageView.image = UIImage(systemName: effect.iconName)
        titleLabel.text = effect.title
        subtitleLabel.text = effect.subtitle

        updateSelection(isSelected)
    }

    func updateSelection(_ selected: Bool) {

        checkmarkImageView.isHidden = !selected

        UIView.animate(withDuration: 0.25) {

            self.cardView.layer.borderWidth = selected ? 2 : 1

            self.cardView.layer.borderColor = selected
            ? ThemeManager.shared.currentTheme.colors.primary.cgColor
            : UIColor.systemGray5.cgColor
            
            self.cardView.transform = selected
            ? CGAffineTransform(scaleX: 1.02, y: 1.02)
            : .identity
            
            UISelectionFeedbackGenerator().selectionChanged()
        }
    }
}

extension ReadingEffectTableViewCell {

    func configureViews() {

        backgroundColor = .clear
        selectionStyle = .none

        cardView.backgroundColor = ThemeManager.shared.currentTheme.colors.surface
        cardView.layer.cornerRadius = 18
        cardView.layer.borderWidth = 1
        cardView.layer.borderColor = UIColor.systemGray5.cgColor

        iconImageView.tintColor = ThemeManager.shared.currentTheme.colors.primary
        iconImageView.contentMode = .scaleAspectFit

        titleLabel.font = .systemFont(ofSize: 17, weight: .semibold)

        subtitleLabel.font = .systemFont(ofSize: 14)
        subtitleLabel.textColor = .secondaryLabel
        subtitleLabel.numberOfLines = 0

        textStackView.axis = .vertical
        textStackView.spacing = 4

        checkmarkImageView.image = UIImage(systemName: "checkmark.circle.fill")
        checkmarkImageView.tintColor = ThemeManager.shared.currentTheme.colors.primary
        checkmarkImageView.isHidden = true

        contentView.addSubview(cardView)

        cardView.addSubview(iconImageView)
        cardView.addSubview(textStackView)
        cardView.addSubview(checkmarkImageView)

        textStackView.addArrangedSubview(titleLabel)
        textStackView.addArrangedSubview(subtitleLabel)
    }

    func setupLayout() {

        cardView.snp.makeConstraints {

            $0.edges.equalToSuperview().inset(8)
        }

        iconImageView.snp.makeConstraints {

            $0.leading.equalToSuperview().offset(16)
            $0.top.equalToSuperview().offset(18)
            $0.width.height.equalTo(24)
        }

        checkmarkImageView.snp.makeConstraints {

            $0.trailing.equalToSuperview().offset(-16)
            $0.centerY.equalTo(iconImageView)
            $0.width.height.equalTo(22)
        }

        textStackView.snp.makeConstraints {

            $0.leading.equalTo(iconImageView.snp.trailing).offset(14)
            $0.trailing.lessThanOrEqualTo(checkmarkImageView.snp.leading).offset(-12)
            $0.top.equalToSuperview().offset(16)
            $0.bottom.equalToSuperview().offset(-16)
        }
    }
    
//    func configureMilestone(with milestone: Milestone) {
//
//        iconImageView.image = UIImage(systemName: milestone.iconName)
//
//        titleLabel.text = milestone.title
//
//        subtitleLabel.text = milestone.isUnlocked
//        ? "Unlocked"
//        : "Read \(milestone.remainingArticles) more articles"
//
//
//        // Badge only appears after unlocking
//        if milestone.isUnlocked,
//           let badgeTier = milestone.badgeTier {
//
//            checkmarkImageView.isHidden = false
//
//            checkmarkImageView.image = UIImage(
//                systemName: "medal.fill"
//            )
//
//            checkmarkImageView.tintColor = badgeTier.color
//            
//            animateBadgeUnlock()
//
//
//        } else {
//
//            checkmarkImageView.isHidden = true
//            checkmarkImageView.image = nil
//            hasAnimatedBadge = false
//        }
//
//
//        cardView.alpha = milestone.isUnlocked ? 1.0 : 0.45
//    }
    
    func configureMilestone(with milestone: Milestone) {

        iconImageView.image = UIImage(systemName: milestone.iconName)

        titleLabel.text = milestone.title


        if milestone.isUnlocked {

            subtitleLabel.text =
            "\(milestone.articleCount)/\(milestone.articleCount) articles completed"

        } else {

            let currentRead = milestone.articleCount - milestone.remainingArticles

            subtitleLabel.text =
            "\(currentRead)/\(milestone.articleCount) articles • \(milestone.remainingArticles) more to unlock"
        }


        if milestone.isUnlocked,
           let badgeTier = milestone.badgeTier {

            checkmarkImageView.isHidden = false

            checkmarkImageView.image = UIImage(
                systemName: "medal.fill"
            )

            checkmarkImageView.tintColor = badgeTier.color

            animateBadgeUnlock()

        } else {

            checkmarkImageView.isHidden = true
            checkmarkImageView.image = nil
            hasAnimatedBadge = false
        }


        cardView.alpha = milestone.isUnlocked ? 1.0 : 0.45
    }
    
    private func updateUnlockState(_ unlocked: Bool) {

        checkmarkImageView.isHidden = !unlocked

        UIView.animate(withDuration: 0.25) {

            self.cardView.alpha = unlocked ? 1.0 : 0.45

            self.titleLabel.textColor =
            unlocked ? .label : .secondaryLabel

            self.iconImageView.tintColor =
            unlocked
            ? ThemeManager.shared.currentTheme.colors.primary
            : .systemGray
        }
    }
    
    private func animateBadgeUnlock() {

        checkmarkImageView.transform =
        CGAffineTransform(scaleX: 0.1, y: 0.1)

        checkmarkImageView.alpha = 0


        UIView.animate(
            withDuration: 0.35,
            delay: 0,
            usingSpringWithDamping: 0.35,
            initialSpringVelocity: 1.2,
            options: [.curveEaseOut]
        ) {

            self.checkmarkImageView.transform =
            CGAffineTransform(scaleX: 1.25, y: 1.25)

            self.checkmarkImageView.alpha = 1

        } completion: { _ in

            UIView.animate(
                withDuration: 0.15,
                animations: {

                    self.checkmarkImageView.transform = .identity
                }
            )
        }
    }
}
