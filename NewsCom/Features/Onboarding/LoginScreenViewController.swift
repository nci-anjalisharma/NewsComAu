 
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
        let button = UIButton(type: .custom)
        button.setTitle("Go Back", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(goBackAction), for: .touchUpInside)
        
        return button
    }()
    
    
    private lazy var googleButton: UIButton = {
        let button = UIButton()
        button.setTitle(" Google", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setImage(UIImage(named: "googleLogo"), for: .normal)
        
       
        
        //not sure if this works - alternative UIButton.Configuration()
//        
//        button.imageEdgeInsets = UIEdgeInsets(top: 0, left:  -10, bottom: 0, right: 0)
//        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
//        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 1, bottom: 0, right: 1)
        
       // button
        button.backgroundColor = .gray.withAlphaComponent(0.2)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 0.2
        button.layer.borderColor = UIColor.black.cgColor
        button.imageView?.contentMode = .scaleAspectFit
        button.configuration?.imagePadding = 2

        
        
        return button
    }()
    
    private lazy var appleButton: UIButton = {
        let button = UIButton()
        button.setTitle(" Apple", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setImage(UIImage(named: "appleLogo"), for: .normal)
        
 
       
        
        
//        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: 0)
//        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
//        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
//        
        
        button.backgroundColor = .gray.withAlphaComponent(0.2)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 0.2
        button.layer.borderColor = UIColor.black.cgColor
        button.imageView?.contentMode = .scaleAspectFit
        button.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0)
//        button.configuration?.contentInsets.top = 10
//        
//        button.configuration?.contentInsets.bottom = 10
//        button.configuration?.contentInsets.leading = 10
//              var config = UIButton.Configuration.filled()
        
        var config = UIButton.Configuration.filled()
        config.image = UIImage(named: "appleLogo")?.withRenderingMode(.alwaysTemplate)
        config.imagePadding = 8
        config.image?.contentMode = .scaleAspectFit
        config.baseForegroundColor = .white
      //  config.baseBackgroundColor = PodcastConfig.colorPalette.secondryButtonBackground.color
        config.imagePlacement = .leading
        
          button.configuration = config
        
   
 
        return button
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        self.title = "Login"
//        setLoginPage()
        view.backgroundColor = .systemBackground
        
    }
    
    private func setLoginPage() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "loginVC") as? LoginScreenViewController {
            
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
            
        }
        
        
        
        
    }
    
    private func setupUI() {
        view.addSubview(goHome)
        view.addSubview(goBack)
        view.addSubview(googleButton)
        view.addSubview(appleButton)
        
        goHome.snp.makeConstraints { (make) in
              
            make.top.equalTo(view.safeAreaLayoutGuide).inset(50)
            
            
            make.width.equalTo(200)
            make.height.equalTo(150)
        }
        
        goBack.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        googleButton.snp.makeConstraints { (make) in
            
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(150)
            make.height.equalTo(60)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(200)
            
        }
        
        appleButton.snp.makeConstraints { (make) in
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(150)
            make.height.equalTo(60)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(200)
        }
    }
    
    private func navigateToHome() {
        
        UserDefaults.standard.set(true, forKey: "hasFinishedOnboarding")
        UserDefaults.standard.set(true, forKey: "hasLoggedIn")
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



