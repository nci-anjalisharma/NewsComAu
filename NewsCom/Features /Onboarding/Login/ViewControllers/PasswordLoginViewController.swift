//
//  LoginWithPassword.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 17/06/26.
//


import UIKit
import SnapKit
import FirebaseAuth

final class PasswordLoginViewController: UIViewController {
    
    private let viewModel = AuthViewModel()

    private let emailField = UITextField()
    private let passwordField = UITextField()

    private lazy var continueButton: UIButton = {
        let button = UIButton()
        button.setTitle("Continue", for: .normal)
        button.backgroundColor = .black
        button.titleLabel?.textColor = .white
        button.layer.cornerRadius = 16
        button.isEnabled = false
        button.alpha = 0.5
        button.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
        
        return button
    }()
    
    @objc private func didTapLogin() {

        guard let email = emailField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              let password = passwordField.text,
              !email.isEmpty,
              !password.isEmpty else {

            present(viewModel.makeAlert(title: "Error", message: "Please enter email and password."), animated: true)
            
            return
        }

        viewModel.login(email: email, password: password) { [weak self] result in

            guard let self else { return }

            DispatchQueue.main.async {

                switch result {

                case .success(_):
                    
                    UserDefaults.standard.set(true, forKey: "hasLoggedIn")
                    UserDefaults.standard.set(true,forKey: "hasFinishedOnboarding")
                    RootNavigationService.shared.showTabBar()

                case .failure(let error):

                    self.present(self.viewModel.makeAlert(title: "Login Failed", message: self.viewModel.userFriendlyMessage(for: error)), animated: true)
                }
            }
        }
    }
    
    private let socialView = SocialLoginView()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        emailField.delegate = self
        passwordField.delegate = self
    }

    private func setupUI() {

        view.backgroundColor = .white

        emailField.placeholder = "Email"
        emailField.autocapitalizationType = .none
        emailField.borderStyle = .roundedRect
        
        emailField.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)

        passwordField.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)

        passwordField.placeholder = "Password"
        passwordField.borderStyle = .roundedRect
        passwordField.isSecureTextEntry = true

        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(continueButton)
        view.addSubview(socialView)

        emailField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(56)
        }

        passwordField.snp.makeConstraints {
            $0.top.equalTo(emailField.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(56)
        }

        continueButton.snp.makeConstraints {
            $0.top.equalTo(passwordField.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(60)
        }

        socialView.snp.makeConstraints {
            $0.top.equalTo(continueButton.snp.bottom).offset(32)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(180)
        }
    }
    
    private func updateContinueButtonEnabled() {
        let email = emailField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let password = passwordField.text ?? ""
        let enabled = !email.isEmpty && !password.isEmpty
        continueButton.isEnabled = enabled
        continueButton.alpha = enabled ? 1.0 : 0.5
    }
    
    @objc private func textFieldsDidChange(){
        print("text changed")
        updateContinueButtonEnabled()
    }
    
}

extension PasswordLoginViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    
        DispatchQueue.main.async { [weak self] in
            self?.updateContinueButtonEnabled()
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField {
            passwordField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
}
