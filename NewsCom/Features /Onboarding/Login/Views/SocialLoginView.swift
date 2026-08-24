//
//  SocialLoginView.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 18/06/26.
//

import UIKit
import SnapKit

final class SocialLoginView: UIView {

    private let dividerLeft = UIView()
    private let dividerRight = UIView()

    private let continueLabel: UILabel = {
        let label = UILabel()
        label.text = "OR CONTINUE WITH"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()

    private lazy var googleButton:  UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(goToLoginScreen), for: .touchUpInside)
        
        return button
    }()
    
    @objc private func goToLoginScreen(){
        RootNavigationService.shared.showOnboardingPage()
    }
    
    let appleButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    private func setupUI() {

        dividerLeft.backgroundColor = .lightGray
        dividerRight.backgroundColor = .lightGray

        googleButton.setTitle("Google", for: .normal)
        googleButton.setTitleColor(.black, for: .normal)
        googleButton.layer.borderWidth = 1
        googleButton.layer.cornerRadius = 16

        appleButton.setTitle("Apple", for: .normal)
        appleButton.setTitleColor(.black, for: .normal)
        appleButton.layer.borderWidth = 1
        appleButton.layer.cornerRadius = 16

        addSubview(dividerLeft)
        addSubview(dividerRight)
        addSubview(continueLabel)
        addSubview(googleButton)
        addSubview(appleButton)

        continueLabel.snp.makeConstraints {
            $0.top.centerX.equalToSuperview()
        }

        dividerLeft.snp.makeConstraints {
            $0.centerY.equalTo(continueLabel)
            $0.leading.equalToSuperview()
            $0.trailing.equalTo(continueLabel.snp.leading).offset(-12)
            $0.height.equalTo(1)
        }

        dividerRight.snp.makeConstraints {
            $0.centerY.equalTo(continueLabel)
            $0.leading.equalTo(continueLabel.snp.trailing).offset(12)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }

        googleButton.snp.makeConstraints {
            $0.top.equalTo(continueLabel.snp.bottom).offset(24)
            $0.leading.equalToSuperview()
            $0.height.equalTo(60)
            $0.width.equalToSuperview().multipliedBy(0.47)
        }

        appleButton.snp.makeConstraints {
            $0.top.equalTo(googleButton)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(60)
            $0.width.equalToSuperview().multipliedBy(0.47)
        }
    }
}
