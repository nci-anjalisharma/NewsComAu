//
//  RootNavigationService.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 16/04/26.
//

import UIKit

extension RootNavigationService {
     
    static var hasLoggedIn: Bool {
        return UserDefaults.standard.bool(forKey: "hasLoggedIn")
    }
}

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
        
        let hasFinishedOnboarding = UserDefaults.standard.bool(forKey: "hasFinishedOnboarding")
        let hasLoggedIn = UserDefaults.standard.bool(forKey: "hasLoggedIn")
        let hasSignedUp = UserDefaults.standard.bool(forKey: "hasSignedUp")
        
        guard hasFinishedOnboarding else {
            showOnboardingPage()
            return
        }
        
        if hasLoggedIn || hasSignedUp {
            showTabBar()
        } else {
            showLoginPage()
        }
    }
    
    func showSignupPage(){
        let vc = storyboard(withID: "signupVC")
        switchVC(vc)
    }
    
    func showLoginPage(){
        
        let vc = LoginScreenViewController()
        switchVC(vc)
    }
    
    func showLoginWithOTP(){
        let vc = OTPLoginViewController()
        switchVC(vc)
    }
    
    func showLoginWithPassword(){
        let vc = PasswordLoginViewController()
        switchVC(vc)
    }
    
    func showTabBar(){
        let vc = BaseTabBarController()
        switchVC(vc)
    }
    
    func showOnboardingPage(){
        let vc = OnboardingPageViewController()
        switchVC(vc)
    }
    
    func showForgotPassword()  {
        let vc = storyboard(withID: "forgotPassword")
        switchVC(vc)
    }
    
    func showTermsAndConditions(){
        let vc = TermsAndConditions()
        switchVC(vc)
    }
    
    private func switchVC(_ viewController: UIViewController) {
        
        let activeWindow = self.window ?? UIApplication.shared.connectedScenes.compactMap({($0 as? UIWindowScene)?.keyWindow}).first
        guard let window = activeWindow else { return }
        
        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
            window.rootViewController = viewController
        })
        window.makeKeyAndVisible()
    }
    
    private func storyboard(withID id: String) -> UIViewController {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: id)
    }
}
