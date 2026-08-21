//
//  MilestoneUnlockView.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 28/07/26.
//

import UIKit
import SnapKit

final class MilestoneUnlockView: UIView {

    private let lockImageView = UIImageView()

    private let titleLabel = UILabel()

    private let subtitleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        let theme = ThemeManager.shared.currentTheme

        backgroundColor = theme.colors.surface
        layer.cornerRadius = 24

        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 16
        layer.shadowOffset = CGSize(width: 0, height: 8)

        lockImageView.image = UIImage(systemName: "lock.fill")
        lockImageView.tintColor = theme.colors.primary
        lockImageView.contentMode = .scaleAspectFit
        lockImageView.preferredSymbolConfiguration =
            UIImage.SymbolConfiguration(pointSize: 48, weight: .bold)

        titleLabel.font = .systemFont(ofSize: 22, weight: .bold)
        titleLabel.textAlignment = .center
        titleLabel.textColor = theme.colors.primary

        subtitleLabel.font = .systemFont(ofSize: 16)
        subtitleLabel.textAlignment = .center
        subtitleLabel.textColor = theme.colors.secondary
        subtitleLabel.numberOfLines = 2

        addSubview(lockImageView)
        addSubview(titleLabel)
        addSubview(subtitleLabel)

        lockImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(60)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(lockImageView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(24)
        }

        alpha = 0
        transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    func configure(title: String, subtitle: String) {

        titleLabel.text = title
        subtitleLabel.text = subtitle
    }

    func playAnimation() {

        UIView.animate(
            withDuration: 0.45,
            delay: 0,
            usingSpringWithDamping: 0.7,
            initialSpringVelocity: 0.8
        ) {

            self.alpha = 1
            self.transform = .identity
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.45) {

            UIView.transition(
                with: self.lockImageView,
                duration: 0.35,
                options: .transitionFlipFromTop
            ) {

                self.lockImageView.image =
                    UIImage(systemName: "lock.open.fill")

            }

        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.2) {

            UIView.animate(withDuration: 0.3) {

                self.alpha = 0
                self.transform =
                    CGAffineTransform(scaleX: 0.8, y: 0.8)

            } completion: { _ in

                self.removeFromSuperview()
            }
        }
    }
}
