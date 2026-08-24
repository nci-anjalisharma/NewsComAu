//
//  MilestoneBannerView.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 28/07/26.
//
import UIKit
import SnapKit

final class MilestoneBannerView: UIView {

    private let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterial))

    private let tintView = UIView()

    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    private func setupUI() {

        let theme = ThemeManager.shared.currentTheme

        backgroundColor = .clear

        // Shadow
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.18
        layer.shadowRadius = 24
        layer.shadowOffset = CGSize(width: 0, height: 12)

        // Blur
        addSubview(blurView)

        blurView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        blurView.clipsToBounds = true
        blurView.layer.cornerRadius = 28

        // Theme tint 
        tintView.backgroundColor = theme.colors.primary.withAlphaComponent(0.08)

        blurView.contentView.addSubview(tintView)

        tintView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        // Thin border
        blurView.layer.borderWidth = 1

        blurView.layer.borderColor =
            UIColor.white.withAlphaComponent(0.18).cgColor

        // Labels

        titleLabel.font = .systemFont(ofSize: 22, weight: .bold)
        titleLabel.textAlignment = .center
        titleLabel.textColor = theme.colors.primary

        subtitleLabel.font = .systemFont(ofSize: 15)
        subtitleLabel.textAlignment = .center
        subtitleLabel.numberOfLines = 2
        subtitleLabel.textColor = .secondaryLabel

        blurView.contentView.addSubview(titleLabel)
        blurView.contentView.addSubview(subtitleLabel)

        titleLabel.snp.makeConstraints {

            $0.top.equalToSuperview().offset(20)
            $0.leading.trailing.equalToSuperview().inset(24)
        }

        subtitleLabel.snp.makeConstraints {

            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().inset(20)
        }
    }

    func configure(title: String, subtitle: String) {

        titleLabel.text = title
        subtitleLabel.text = subtitle
    }
}
