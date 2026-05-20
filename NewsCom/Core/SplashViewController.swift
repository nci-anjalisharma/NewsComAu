 
//
//  SplashViewController.swift
//NewsCom
//
//  Created by ANJALI SHARMA R on 07/04/26.
//

import UIKit
import SnapKit


class SplashViewController: UIViewController {
    
    
    private lazy var logoImageView: UIImageView = {
        
        let iv = UIImageView()
        
        
        iv.image = UIImage(named: "ncaNameLogo")
//        iv.image = UIImage(systemName: "newspaper.circle.fill")
//        iv.image = UIImage(named: "appleLogo")

//        iv.contentMode = .scaleAspectFit
        iv.contentMode = .scaleAspectFill
        
        iv.backgroundColor = .systemBackground
        
        
        return iv
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setUpLayout()
        startSplashAnimation()
        
        
    }
    

    private func setUpLayout() {
        
        view.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { make in
            
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.4)   //40% of the screen
            make.height.equalTo(logoImageView.snp.width)
            }
    }
    
    
    private func startSplashAnimation(){
        
        UIView.animate(withDuration: 0.3, delay: 0.2, options: .curveEaseInOut, animations: {
            self.logoImageView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }) { _ in
            
            // redirecting to onboardingPage
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                RootNavigationService.shared.moveFromSplashToRoot()
            }
        }
        UserDefaults.standard.set(true, forKey: "hasFinishedOnboarding")
    }
    
//    private func navigateToOnboarding(){
//        
//        let onboardingVC = OnboardingPageViewController()
//        onboardingVC.modalPresentationStyle = .fullScreen
//        onboardingVC.modalTransitionStyle = .crossDissolve
//        
//        if let window = self.view.window {
//            window.rootViewController = onboardingVC
//            UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil)
//        }
//    }
}






 

 
