 
//
//  LoginScreenViewController.swift
//  news.com.au_skeleton
//
//  Created by ANJALI SHARMA R on 07/04/26.
//

import UIKit
import SnapKit

class LoginScreenViewController: UIViewController {
    
    private lazy var goHome: UIButton = {
        let button = UIButton()
        button.setTitle("Login Success", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(goHomeAction), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var goBack: UIButton = {
        let button = UIButton()
        button.setTitle("Go Back", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(goBackAction), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        view.backgroundColor = .systemCyan
        
    }
    
    
    private func setupUI() {
        view.addSubview(goHome)
        view.addSubview(goBack)
        
        goHome.snp.makeConstraints { (make) in
              
            make.top.equalTo(view.safeAreaLayoutGuide).inset(50)
            
            
            make.width.equalTo(200)
            make.height.equalTo(150)
        }
        
        goBack.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    
    private func navigateToHome() {
        
        UserDefaults.standard.set(true, forKey: "hasFinishedOnboarding")
        UserDefaults.standard.set(true, forKey: "isLoggedIn")
        RootNavigationService.shared.moveFromSplashToRoot()
//        let vc = BaseTabBarController()
//        
//        if let window = self.view.window {
//            guard let sceneDelegate = UIApplication.shared.delegate as? AppDelegate else {
//                return
//            }
//
//           // window.rootViewController = vc // not needed
//          //  UIView.transition(with: sceneDelegate.window ?? , duration: 0.3, options: .transitionCurlDown, animations: nil, completion: nil)
//
//            }
            
        }

    
    @objc private func goHomeAction() {
        navigateToHome()
    }
    
    @objc private func goBackAction() {
        
        self.dismiss(animated: true)
    }
}

