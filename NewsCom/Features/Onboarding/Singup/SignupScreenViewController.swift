


//
//  SignupScreenViewController.swift
//  news.com.au_skeleton
//
//  Created by ANJALI SHARMA R on 07/04/26.
//

import UIKit
import SnapKit

class SignupScreenViewController: UIViewController {
    
    
    
    @IBOutlet weak var subtitleLable: UILabel!
    
    
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    func emailFunction() {
        emailTextField.placeholder = "@gmail.com"
        emailTextField.leftView = emailLabel
        emailTextField.leftViewMode = .always

    }
    
    @IBOutlet weak var forgotPasswordButton: UIButton!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var passwordLabel: UILabel!
    
    func passwordFunction() {
        passwordField.placeholder = "Password"
        passwordField.leftView = passwordLabel
        passwordField.leftViewMode = .always
    }
    
    
    @IBOutlet weak var signupButton: UIButton!
    
    @IBOutlet weak var tcPrivacyPolicy: UIButton!
    
    @IBOutlet weak var loginPageButton: UIButton!
    
    
    //    private lazy var goHome: UIButton = {
    //        let button = UIButton()
    //        button.setTitle("Sign up successfull", for: .normal)
    //        button.backgroundColor = .white.withAlphaComponent(0.4)
    //        button.setTitleColor(UIColor.black, for: .normal)
    //        button.addTarget(self, action: #selector(goHomeAction), for: .touchUpInside)
    //
    //        return button
    //    }()
    //
    //    private lazy var goBack: UIButton = {
    //        let button = UIButton()
    //        button.setTitle("Go back", for: .normal)
    //        button.setTitleColor(UIColor.black, for: .normal)
    //        button.addTarget(self, action: #selector(goBackAction), for: .touchUpInside)
    //
    //        return button
    //    }()
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        //        setupUI()
        view.backgroundColor = .systemBackground
        self.title = "Sign up to Continue"
        emailFunction()
        passwordFunction()
        
    }
    //
    //    private func setupUI() {
    //        view.addSubview(goHome)
    //        view.addSubview(goBack)
    //
    //        goHome.snp.makeConstraints { (make) in
    //
    //            make.leading.trailing.equalToSuperview().inset(16)
    //            make.height.equalTo(45)
    //            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(350)
    //        }
    //
    //        goBack.snp.makeConstraints { (make) in
    //            make.leading.trailing.bottom.equalToSuperview().inset(20)
    //            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
    //        }
    //
    //
    //    }
    //
     
    @IBAction func signupButton(_ sender: Any) {
             
            RootNavigationService.shared.showLoginWithOTP()
        }
      
    
    
    @IBAction func forgotPasswordButton(_ sender: Any) {
        
//        RootNavigationService.shared.switchVC(ForgotPassword())
       
    }
    
    
    
    
    @IBAction func loginButton(_ sender: Any) {
     
        RootNavigationService.shared.showLoginPage()
    }
    
    
    @IBAction func tcPrivacyPolicy(_ sender: Any) {
        
        let vc = RootNavigationService.shared.showTermsAndConditions()
        navigationController?.pushViewController(vc, animated: true)
        
//        navigationController?.pushViewController(RootNavigationService.shared.showTermsAndConditions(), animated: true)
    }
    
    
}

