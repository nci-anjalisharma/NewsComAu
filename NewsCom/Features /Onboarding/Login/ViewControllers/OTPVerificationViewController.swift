//
//  OTPVerificationViewController.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 24/06/26.
//

import UIKit
import SnapKit

class OTPVerificationViewController: UIViewController {
    
    var email: String?
    var generatedOTP: String?
    
    private let titleLabel: UILabel = {

        let label = UILabel()
        label.text = "Verify OTP"
        label.font = .boldSystemFont(ofSize: 28)

        return label
    }()

    private let otpTextField: UITextField = {

        let tf = UITextField()

        tf.placeholder = "Enter OTP"
        tf.borderStyle = .roundedRect
        tf.keyboardType = .numberPad

        return tf
    }()

    private let verifyButton: UIButton = {

        let button = UIButton(type: .system)

        button.setTitle("Verify", for: .normal)
        button.backgroundColor = .black
        button.tintColor = .white
        button.layer.cornerRadius = 16

        return button
    }()
    
    @objc private func didTapVerify() {

        guard let enteredOTP = otpTextField.text,
              !enteredOTP.isEmpty else {

            showAlert(message: "Enter OTP")
            return
        }

        if enteredOTP == generatedOTP {
            
            UserDefaults.standard.set(true, forKey: "hasLoggedIn")
            RootNavigationService.shared.showTabBar()

        } else {

            showAlert(
                message: "Invalid OTP"
            )
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

        verifyButton.addTarget(self, action: #selector(didTapVerify), for: .touchUpInside)
        
    }
    
    private func showAlert(title: String = "Alert", message: String) {

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "OK", style: .default))

        present(alert, animated: true)
    }
    
    private func setupUI() {

        view.backgroundColor = .white

        view.addSubview(titleLabel)
        view.addSubview(otpTextField)
        view.addSubview(verifyButton)

        titleLabel.snp.makeConstraints {

            $0.top.equalTo(view.safeAreaLayoutGuide).offset(40)
            $0.centerX.equalToSuperview()
        }

        otpTextField.snp.makeConstraints {

            $0.top.equalTo(titleLabel.snp.bottom).offset(40)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(56)
        }

        verifyButton.snp.makeConstraints {

            $0.top.equalTo(otpTextField.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(60)
        }
    }
    
    
}

extension OTPLoginViewController: UITextFieldDelegate {
    
//    func editTextFieldShouldReturn(_ textField: UITextField) -> Bool {
//        
//    }
}
