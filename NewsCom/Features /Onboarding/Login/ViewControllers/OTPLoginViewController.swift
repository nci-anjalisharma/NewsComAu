

import UIKit
import SnapKit
import FirebaseAuth

final class OTPLoginViewController: UIViewController {

    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
        return textField
    }()
    
    
    private lazy var continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.isEnabled = false
        button.alpha = 0.5
        button.addTarget(self, action: #selector(didTapSendOTP), for: .touchUpInside)
        
        return button
    }()
    
    private func updateContinueButtonEnabled() {
        let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let enabled = !email.isEmpty
        continueButton.isEnabled = enabled
        continueButton.alpha = enabled ? 1.0 : 0.5
    }
    
    @objc private func textFieldsDidChange(){
        updateContinueButtonEnabled()
    }
    
    @objc private func didTapSendOTP() {
        
        guard let email = emailTextField.text,
                  !email.isEmpty else {
                return
            }

            let otp = String(format: "%04d", Int.random(in: 0...99999))

            let vc = OTPVerificationViewController()
            vc.email = email
            vc.generatedOTP = otp

            let alert = UIAlertController(
                title: "Demo OTP",
                message: "OTP: \(otp)",
                preferredStyle: .alert
            )

            alert.addAction(UIAlertAction(title: "Continue", style: .default) { _ in
                self.present(vc, animated: true)
                print("OTP screen pushed")
                })

            present(alert, animated: true)
    }
    private let socialView = SocialLoginView()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        updateContinueButtonEnabled()
    }

    private func setupUI() {

        view.backgroundColor = .white

        emailTextField.placeholder = "name@example.com"
        emailTextField.borderStyle = .roundedRect

        continueButton.setTitle("Send OTP", for: .normal)
        continueButton.backgroundColor = .black
        continueButton.setTitleColor(.white, for: .normal)
        continueButton.layer.cornerRadius = 16

        view.addSubview(emailTextField)
        view.addSubview(continueButton)
        view.addSubview(socialView)

        emailTextField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(56)
        }

        continueButton.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(60)
        }

        socialView.snp.makeConstraints {
            $0.top.equalTo(continueButton.snp.bottom).offset(32)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(180)
        }
    }
}
