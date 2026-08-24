//
//  GreetingViewController.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 27/07/26.
//

import UIKit
import SnapKit

final class GreetingViewController: UIViewController {

    // MARK: - Data

    var userName: String = "User"
    var isReturningUser = false
    
    // MARK: - UI

    private let greetingLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 36, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.alpha = 0
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        label.alpha = 0
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textAlignment = .center
        label.alpha = 0
        return label
    }()

    private let glowView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemYellow.withAlphaComponent(0.25)
        view.layer.cornerRadius = 120
        view.alpha = 0
        return view
    }()
    
    private lazy var continueButton: UIButton = {

        let button = UIButton(type: .system)

        button.setTitle("Continue", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)

        button.backgroundColor = .label
        button.setTitleColor(.systemBackground, for: .normal)

        button.layer.cornerRadius = 18

        button.alpha = 0

        button.addTarget(
            self,
            action: #selector(didTapContinue),
            for: .touchUpInside
        )

        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        animateGreeting()
    }
    
    private func setupUI() {

        view.backgroundColor = .systemBackground

        view.addSubview(glowView)
        view.addSubview(greetingLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(nameLabel)
        view.addSubview(continueButton)

        glowView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(240)
        }

        greetingLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-20)
            make.leading.trailing.equalToSuperview().inset(24)
        }

        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(greetingLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(24)
        }

        continueButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(40)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(50)
            make.height.equalTo(58)
        }

        configureGreeting()
    }
    
    private func configureGreeting() {

        if isReturningUser {

            greetingLabel.text = "Welcome back,\n\(userName) 👋"

            subtitleLabel.text = "Let's catch up with today's news."

        } else {

            greetingLabel.text = "\(greetingText()),\n\(userName) ☀️"

            subtitleLabel.text = "Your personalized news is ready."
        }
    }
    
    private func greetingText() -> String {

        let hour = Calendar.current.component(.hour, from: Date())

        switch hour {

        case 5..<12:
            return "Good Morning"

        case 12..<17:
            return "Good Afternoon"

        case 17..<22:
            return "Good Evening"

        default:
            return "Good Night"
        }
    }
//    
//    private func animateGreeting() {
//
//        greetingLabel.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
//
//        UIView.animate(
//            withDuration: 0.9,
//            delay: 0.2,
//            usingSpringWithDamping: 0.75,
//            initialSpringVelocity: 0.8
//        ) {
//
//            self.glowView.alpha = 1
//
//            self.greetingLabel.alpha = 1
//            self.subtitleLabel.alpha = 1
//
//            self.greetingLabel.transform = .identity
//        }
//    }
    
    private func animateGreeting() {

        greetingLabel.alpha = 0
        greetingLabel.transform = CGAffineTransform(translationX: 0, y: 20)

        nameLabel.alpha = 0
        nameLabel.transform = CGAffineTransform(translationX: 0, y: 20)

        continueButton.alpha = 0
        continueButton.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)

        UIView.animate(
            withDuration: 0.6,
            delay: 0,
            options: [.curveEaseOut]
        ) {

            self.greetingLabel.alpha = 1
            self.greetingLabel.transform = .identity

        } completion: { _ in

            UIView.animate(
                withDuration: 0.6,
                delay: 0,
                options: [.curveEaseOut]
            ) {

                self.nameLabel.alpha = 1
                self.nameLabel.transform = .identity

            } completion: { _ in

                UIView.animate(
                    withDuration: 0.5,
                    delay: 0.15,
                    usingSpringWithDamping: 0.75,
                    initialSpringVelocity: 0.4
                ) {

                    self.continueButton.alpha = 1
                    self.continueButton.transform = .identity
                }
            }
        }
    }
    
    @objc private func didTapContinue() {

        RootNavigationService.shared.showTabBar()
    }

}
