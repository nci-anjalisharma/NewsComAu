


//
//  SignupScreenViewController.swift
//  news.com.au_skeleton
//
//  Created by ANJALI SHARMA R on 07/04/26.
//

import UIKit
import SnapKit
import FirebaseAuth
import FirebaseCore
import GoogleSignIn

class SignupScreenViewController: UIViewController {
    
    private let viewModel = AuthViewModel()
    
    @IBOutlet weak var subtitleLable1: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
//    private let nameTextField: UITextField = {
//        let textField = UITextField()
//        textField.placeholder = "Name"
//        textField.borderStyle = .roundedRect
////        textField.autocapitalizationType = .words
//        textField.returnKeyType = .next
//        return textField
//    }()
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var tcCheckButton: UIButton!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var signupButton: UIButton!
    
    @IBOutlet weak var tcPrivacyPolicy: UIButton!
    
    
    private lazy var googleButton: UIButton = {
        let button = UIButton()
        button.setTitle("Google", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .body)
        return button
    }()
    
    private lazy var appleButton: UIButton = {
        let button = UIButton()
        button.setTitle("Apple", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .body)
        return button
        
    }()
    
    @IBOutlet weak var loginPageButton: UIButton!
    
    @IBOutlet weak var haveAccountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Signup loaded")
        
        view.backgroundColor = .systemBackground
        self.title = "Sign up to Continue"
        
        setupConstraints()
        setupUI()
        checkFormStatus()
        
        emailTextField.delegate = self
        passwordField.delegate = self
//        nameTextField.delegate = self
        
        googleButton.addTarget(self, action: #selector(signInWithGoogle), for: .touchUpInside)
        
    }
    
    @objc private func signInWithGoogle() {

        guard let clientID = FirebaseApp.app()?.options.clientID else {
            print("No Client ID found")
            return
        }

        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [weak self] result, error in

            if let error = error {
                print(error.localizedDescription)
                return
            }

            guard
                let user = result?.user,
                let idToken = user.idToken?.tokenString
            else {
                return
            }

            let credential = GoogleAuthProvider.credential(
                withIDToken: idToken,
                accessToken: user.accessToken.tokenString
            )

            Auth.auth().signIn(with: credential) { _, error in

                if let error = error {
                    print(error.localizedDescription)
                    return
                }

                DispatchQueue.main.async {
                    UserDefaults.standard.set(true, forKey: "hasLoggedIn")
                    RootNavigationService.shared.showTabBar()
                }
            }
        }
    }
    private func checkFormStatus() {
        
        let config = UIImage.SymbolConfiguration(pointSize: 18, weight: .regular)
        let unchecked = UIImage(systemName: "square", withConfiguration: config)
        let checked = UIImage(systemName: "checkmark.square.fill", withConfiguration: config)
        
        tcCheckButton.setImage(unchecked, for: .normal)
        tcCheckButton.setImage(checked, for: .selected)
        
        tcCheckButton.tintColor = .label
        tcCheckButton.contentHorizontalAlignment = .leading
        tcCheckButton.imageView?.contentMode = .scaleAspectFit
        
        tcCheckButton.isSelected = false
        
    }
    private func setupConstraints() {
        
//        view.addSubview(nameTextField)
        view.addSubview(googleButton)
        view.addSubview(appleButton)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            $0.leading.trailing.equalToSuperview().inset(130)
        }
        
        subtitleLable1.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        emailTextField.snp.remakeConstraints {
            $0.top.equalTo(subtitleLable1.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(56)
        }
        
//        nameTextField.snp.makeConstraints {
//            $0.top.equalTo(subtitleLable1.snp.bottom).offset(30)
//            $0.leading.trailing.equalToSuperview().inset(24)
//            $0.height.equalTo(56)
//        }
//
//        emailTextField.snp.remakeConstraints {
//            $0.top.equalTo(nameTextField.snp.bottom).offset(16)
//            $0.leading.trailing.equalToSuperview().inset(24)
//            $0.height.equalTo(56)
//        }
    
        passwordField.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(56)
        }
        
        tcCheckButton.snp.makeConstraints {
            $0.top.equalTo(passwordField.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(10)
            $0.height.equalTo(5)
            $0.width.equalTo(50)
        }
        
        tcPrivacyPolicy.titleLabel?.numberOfLines = 2
        
        tcPrivacyPolicy.snp.makeConstraints {
            $0.centerY.equalTo(tcCheckButton)
            $0.top.equalTo(passwordField.snp.bottom).offset(40)
            $0.leading.equalTo(tcCheckButton.snp.trailing).offset(5)
            $0.trailing.equalToSuperview().inset(24)
        }
        
        signupButton.isEnabled = false
        signupButton.alpha = 0.1
        
        signupButton.snp.makeConstraints {
            $0.top.equalTo(tcCheckButton.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(60)
        }
        
        googleButton.setTitle("Google", for: .normal)
        googleButton.setTitleColor(.black, for: .normal)
        
        googleButton.snp.makeConstraints {
            $0.top.equalTo(signupButton.snp.bottom).offset(32)
            $0.leading.equalToSuperview().offset(24)
            $0.height.equalTo(60)
        }
        
        appleButton.setTitle("Apple", for: .normal)
        appleButton.setTitleColor(.black, for: .normal)
        
        appleButton.snp.makeConstraints {
            $0.top.equalTo(googleButton)
            $0.leading.equalTo(googleButton.snp.trailing).offset(16)
            $0.trailing.equalToSuperview().inset(24)
            $0.width.equalTo(googleButton)
            $0.height.equalTo(googleButton)
        }
        
        [googleButton, appleButton].forEach {
            $0.layer.cornerRadius = 16
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.label.cgColor
            $0.clipsToBounds = true
        }
        
        haveAccountLabel.snp.makeConstraints{
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(80)
            $0.centerX.equalToSuperview()
        }
        
        loginPageButton.snp.makeConstraints {
            $0.top.equalTo(haveAccountLabel.snp.bottom).offset(5)
            $0.centerX.equalToSuperview()
        }
        
    }
    
    private func setupUI() {
        
        view.backgroundColor = .white
        
        [emailTextField, passwordField].forEach {
            $0?.borderStyle = .roundedRect
        }
        
        emailTextField.autocapitalizationType = .none
        
        passwordField.isSecureTextEntry = true
        
        signupButton.backgroundColor = .black
        signupButton.setTitleColor(.white, for: .normal)
        signupButton.layer.cornerRadius = 16
//        
//        tcPrivacyPolicy.addTarget(self, action: #selector(didSelectTc), for: .touchUpInside)
    }
    @IBAction func didSelectTc(_ sender: Any) {
        print("Button tapped")
        
        let vc = TermsAndConditions()
        vc.hidesBottomBarWhenPushed = true
        self.present(vc, animated: true)
    }
    
//    @objc private func didSelectTc() {
//        print("Button tapped")
//        
//        let vc = TermsAndConditions()
//        vc.hidesBottomBarWhenPushed = true
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
    
    private func showAlert(title: String = "Alert", message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    @IBAction func signupButton(_ sender: Any) {
        
        print("Signup button pressed")
        
        guard tcCheckButton.isSelected else {
            showAlert(
                message: "Please agree to the Terms & Privacy Policy to continue."
            )
            return
        }
        
//        guard
//            let name = nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
//            !name.isEmpty,
//            let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
//            let password = passwordField.text,
//            !email.isEmpty,
//            !password.isEmpty
//        else {
//            showAlert(message: "Please fill all fields")
//            return
//        }
        
        guard let email = emailTextField.text?.trimmingCharacters(
                in: .whitespacesAndNewlines
            ),
                  let password = passwordField.text,
                  !email.isEmpty,
                  !password.isEmpty else {
                
                showAlert(
                    message: "Please enter email and password."
                )
                return
            }
        
//        print("Name:", name)
        print("Email: '\(email)'")
        print("Password length:", password.count)
        
        viewModel.signUp(email: email, password: password) { [weak self] result in
            
            guard let self else { return }
            
            print("Completion reached")
            
            DispatchQueue.main.async {
                
                switch result {
                    
                case .success:
                    
//                    self.showAlert(title: "Success", message: "Verification email sent.")
                    
                    RootNavigationService.shared.showTabBar()
                    
                    
                    UserDefaults.standard.set(true, forKey: "hasLoggedIn")
                    UserDefaults.standard.set(true,forKey: "hasFinishedOnboarding")
                    
                case .failure(let error):
                    
                    print(error)
                    print((error as NSError).code)
                    self.showAlert(message: error.localizedDescription)
                                    }
            }
        }
    }
    
    @IBAction func loginButton(_ sender: Any) {
        
        RootNavigationService.shared.showLoginPage()
    }
    
    @IBAction func termsLabelTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        updateSignupButtonEnabled()
        
//        let vc = TermsAndConditions()
//        vc.hidesBottomBarWhenPushed = true
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func updateSignupButtonEnabled() {
        let agreed = tcCheckButton.isSelected
        signupButton.isEnabled = agreed
        signupButton.alpha = agreed ? 1.0 : 0.3
    }
}
//
//    @IBAction func tcPrivacyPolicy(_ sender: UIButton) {
//        
////        RootNavigationService.shared.showTermsAndConditions()
//        let vc = TermsAndConditions()
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
//}

extension SignupScreenViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn: NSRange, replacementString: String) -> Bool {
        return true
    }
}
