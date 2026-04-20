//
//  RootNavigationService.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 16/04/26.
//

import UIKit

class RootNavigationService {
    
    static let shared = RootNavigationService()
    
    weak var window: UIWindow?
    
    private init() {}
    
    
    
    func showSplash(in window: UIWindow) {
        let splashVC = SplashViewController()
        self.window = window
        window.rootViewController = splashVC
        
        window.makeKeyAndVisible()
        
    }
    
    func moveFromSplashToRoot() {
        
        
        let activeWindow = self.window ?? UIApplication.shared.connectedScenes.compactMap({($0 as? UIWindowScene)?.keyWindow}).first
        
        guard let window = activeWindow else {
            print(" Window is NIL")
            return }
        
        let hasFinishedOnboarding = UserDefaults.standard.bool(forKey: "hasFinishedOnboarding")
        let hasLoggedIn = UserDefaults.standard.bool(forKey: "hasLoggedIn")
        let hasSignedUp = UserDefaults.standard.bool(forKey: "hasSignedUp")
        
        let destination: UIViewController
        
        if !hasFinishedOnboarding {
            destination = OnboardingPageViewController()
            
        } else if !hasLoggedIn {
            destination = LoginScreenViewController()
        } else if !hasSignedUp {
            destination = SignupScreenViewController()
            
        } else {
            
            destination = BaseTabBarController()
        }
        
      
        
        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
            window.rootViewController = destination
        })
            window.makeKeyAndVisible()
        
        
        
        
    }
    
}
    
