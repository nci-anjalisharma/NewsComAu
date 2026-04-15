


//
//  SignupScreenViewController.swift
//  news.com.au_skeleton
//
//  Created by ANJALI SHARMA R on 07/04/26.
//

import UIKit
import SnapKit

class SignupScreenViewController: UIViewController {
    
  

    private lazy var goHome: UIButton = {
        let button = UIButton()
        button.setTitle("Sign up successfull", for: .normal)
        button.backgroundColor = .white.withAlphaComponent(0.4)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(goHomeAction), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var goBack: UIButton = {
        let button = UIButton()
        button.setTitle("Go back", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(goBackAction), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        view.backgroundColor = .systemYellow
        
        
    }
    
    private func setupUI() {
        view.addSubview(goHome)
        view.addSubview(goBack)
        
        goHome.snp.makeConstraints { (make) in
            
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(45)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(350)
        }
        
        goBack.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        
    }
    
    private func navigateToHome() {
        
        let tabVC = BaseTabBarController()
        
        if let window = self.view.window {
            window.rootViewController = tabVC
            UIView.transition(with: window, duration: 0.4, options: .curveEaseInOut, animations: nil, completion: nil)
            
        
        }
    }
    
    
    
    @objc private func goHomeAction() {
    
            navigateToHome()
    }
    
    @objc private func goBackAction() {
        self.dismiss(animated: true)
    }
}
