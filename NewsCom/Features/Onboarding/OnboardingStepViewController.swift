//
//  OnboardingStepViewController.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 09/04/26.
//



//OnboardingStepViewController - for page templates and butttons (skip, next)





import UIKit
import SnapKit



class OnboardingStepViewController: UIViewController {
    
    // Properties to identify the page
    var pageIndex: Int = 0
    var onSignUpPressed: (() -> Void)?
    var onSkipPressed: (() -> Void)?
    var onLoginPressed: (() -> Void)?
    

    private lazy var signUp: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return button
    }()
    
    
    private lazy var logIn: UIButton = {
        let button = UIButton()
        button.setTitle( "Log In", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    private lazy var skip: UIButton = {
        let button = UIButton()
        button.setTitle("Skip", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(handleSkip), for: .touchUpInside)
        
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        
    }
    
    private func setupLayout() {
        view.addSubview(logIn)
        view.addSubview(skip)
        view.addSubview(signUp)

        logIn.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(50)
        }

        skip.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
            make.width.equalTo(100)
        }
        
        signUp.snp.makeConstraints { make in
            make.bottom.equalTo(logIn.snp.top).offset(-20)
            make.centerX.equalToSuperview()
        }
        
         
    }
    
    
    @objc func handleSignUp() {
        print("Signup Tapped")
              onSignUpPressed?() }
    @objc func handleSkip() { onSkipPressed?() }
    @objc func handleLogin() {
        print("Login Tapped")
        onLoginPressed?()}
}





