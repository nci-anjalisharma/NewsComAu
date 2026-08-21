//
//  LoginScreenViewController.swift
//  news.com.au_skeleton
//
//  Created by ANJALI SHARMA R on 07/04/26.
//

import UIKit
import SnapKit
import FirebaseAuth

class LoginScreenViewController: UIViewController {

//    private let modeSegmentedControl: UISegmentedControl = {
//        let sc = UISegmentedControl(items: ["Password", "OTP"])
//        sc.selectedSegmentIndex = 0
//        sc.addTarget(self, action: #selector(modeChanged(_:)), for: .valueChanged)
//        return sc
//    }()
    
    private let modeSegmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Login with Password"])
        sc.selectedSegmentIndex = 0
        sc.isEnabled = false      // Optional: disables tapping since there's only one option
        return sc
    }()
    
    private lazy var pageViewController: UIPageViewController = {
        let pvc = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pvc.dataSource = nil
        pvc.delegate = nil
        return pvc
    }()

    private lazy var passwordLoginVC: UIViewController = {
        return PasswordLoginViewController()
    }()

    private lazy var otpLoginVC: UIViewController = {
        return OTPLoginViewController()
    }()

    private lazy var loginPages: [UIViewController] = {
        [passwordLoginVC, otpLoginVC]
    }()
    
    private lazy var accountLabel: UILabel = {
        let label = UILabel()
        label.text = "Don't have an account?"
        label.font = .systemFont(ofSize: 18)
        label.textColor = .gray
        label.textAlignment = .center
        return label
    }()
    
    private lazy var signupButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign up", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(signupButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc private func signupButtonTapped() {
        RootNavigationService.shared.showSignupPage()
    }
    
    @objc private func modeChanged(_ sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex
        let direction: UIPageViewController.NavigationDirection = (pageViewController.viewControllers?.first == loginPages[0] && index == 1) ? .forward : .reverse
        pageViewController.setViewControllers([loginPages[index]], direction: direction, animated: true)
    }

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome to Daily News"
        label.font = .boldSystemFont(ofSize: 32)
        label.textAlignment = .center
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Login in to continue"
        label.font = .systemFont(ofSize: 20)
        label.textColor = .gray
        label.textAlignment = .center
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)

        setupUI()
        setupConstraints()

        pageViewController.setViewControllers([loginPages[0]], direction: .forward, animated: false)
    }
}

extension LoginScreenViewController {

    private func setupUI() {

        [
            titleLabel,
            subtitleLabel,
            modeSegmentedControl,
            pageViewController.view,
            accountLabel,
            signupButton
            
        ].forEach {
            view.addSubview($0)
        }
    }
}

extension LoginScreenViewController {

    private func setupConstraints() {

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(40)
            $0.centerX.equalToSuperview()
        }

        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
        }

        modeSegmentedControl.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(45)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(60)
        }

        pageViewController.view.snp.makeConstraints {
            $0.top.equalTo(modeSegmentedControl.snp.bottom).offset(5)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(380)
        }

        accountLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(50)
            $0.centerX.equalToSuperview().offset(-40)
        }

        signupButton.snp.makeConstraints {
            $0.centerY.equalTo(accountLabel)
            $0.leading.equalTo(accountLabel.snp.trailing).offset(8)
        }
    }
}

