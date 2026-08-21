//
//  SurpriseBannerView.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 29/07/26.
//
import UIKit
import SnapKit

final class SurpriseBannerView: UIView {

    // MARK: - Views

    private let iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "sparkles")
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.textColor = .white
        label.numberOfLines = 1
        return label
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    private func setupUI() {
        
        
        layer.cornerRadius = 16
        clipsToBounds = true

        alpha = 0
        transform = CGAffineTransform(translationX: 0, y: -20)

        addSubview(iconView)
        addSubview(titleLabel)

        iconView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(20)
        }

        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(iconView.snp.trailing).offset(10)
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
    }

    // MARK: - Public

    func show(message: String, duration: TimeInterval = 1.8, completion: (() -> Void)? = nil) {
        
        backgroundColor = ThemeManager.shared.currentTheme.colors.secondary
        titleLabel.text = message

        alpha = 0
        transform = CGAffineTransform(translationX: 0, y: -20)

        UIView.animate(withDuration: 0.8, animations: {
            self.alpha = 1
            self.transform = .identity
        })

        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {

            UIView.animate(withDuration: 0.5, animations: {
                self.alpha = 0
            }) { _ in
                completion?()
            }
        }
    }
}
