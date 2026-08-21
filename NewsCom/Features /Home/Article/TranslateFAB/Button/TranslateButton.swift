//
//  TranslateButton.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 27/07/26.
//

import UIKit
import SnapKit

final class TranslateButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {

        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = UIColor.systemTeal
        config.baseForegroundColor = .white
        config.cornerStyle = .capsule

        let imageConfig = UIImage.SymbolConfiguration(pointSize: 24,weight: .medium)

        config.image = UIImage(systemName: "translate", withConfiguration: imageConfig)

        configuration = config

        layer.cornerRadius = 32

        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 8
        layer.shadowOffset = CGSize(width: 0, height: 4)

        translatesAutoresizingMaskIntoConstraints = false
    }

    func attach(to view: UIView) {

        view.addSubview(self)

        snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(24)
            $0.size.equalTo(CGSize(width: 64, height: 64))
        }
    }

    func setLoading(_ loading: Bool) {

        if loading {

            configuration?.image = nil

            let spinner = UIActivityIndicatorView(style: .medium)
            spinner.color = .white
            spinner.startAnimating()
            spinner.tag = 100

            addSubview(spinner)

            spinner.snp.makeConstraints {
                $0.center.equalToSuperview()
            }

        } else {

            viewWithTag(100)?.removeFromSuperview()

            configuration?.image = UIImage(systemName: "translate")
        }
    }

    func setTranslated(_ translated: Bool) {

        configuration?.baseBackgroundColor = translated ? .systemGreen : .systemTeal
    }
}
