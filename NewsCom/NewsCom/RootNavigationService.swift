//
//  RootNavigationService.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 16/04/26.
//

import UIKit




extension RootNavigationService {
     
    static var isUserLoggedIn: Bool {
        return UserDefaults.standard.bool(forKey: "hasLoggedIn")
    }
    

}

//extension RootNavigationService {
//    
//    // LOGIN
//    func showLoginPage(){
//        
//        let vc = storyboard(withID: "loginVC")
//        
//        
////        let loginNav = UINavigationController(rootViewController: vc)
//        
//        switchVC(vc)
//        
//    }
//    
//    func showLoginWithOTP(){
//        let vc = storyboard(withID: "loginWithOTP")
//        switchVC(vc)
//        
//    }
//    
//    
//}


//
//extension RootNavigationService {
//    
//    // SIGNUP
//
//}
//



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
    
    func moveFromSplashToRoot(){
        //        let activeWindow = self.window ?? UIApplication.shared.connectedScenes.compactMap({($0 as? UIWindowScene)?.keyWindow}).first
        //        guard let window = activeWindow else {
        //            print(" Window is NIL")
        //            return }
        
        let hasFinishedOnboarding = UserDefaults.standard.bool(forKey: "hasFinishedOnboarding")
        let hasLoggedIn = UserDefaults.standard.bool(forKey: "hasLoggedIn")
        let hasSignedUp = UserDefaults.standard.bool(forKey: "hasSignedUp")
        
        if hasFinishedOnboarding {
            showOnboardingPage()
        } else {
            showTabBar()
        }
        
    }
    
    
    
    func showSignupPage(){
        let vc = storyboard(withID: "signupVC")
        
        
        let loginNav = UINavigationController(rootViewController: vc)
        
        switchVC(loginNav)
        
        //        loginNav.navigationController?.pushViewController(TermsAndConditions(), animated: true)
        
        
    }
    
    func showLoginPage(){
        
        let vc = storyboard(withID: "loginVC")
        
        
//        let loginNav = UINavigationController(rootViewController: vc)
        
        switchVC(vc)
        
    }
    
    func showLoginWithOTP(){
        let vc = storyboard(withID: "loginWithOTP")
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
    
    func showTermsAndConditions() -> UIViewController{
         return TermsAndConditions()
    }
    
    
    //        func swapVC(vc: UIViewController){
    //
    //            let viewController = vc
    //            switchVC(viewController)
    //        }
    
    
    
    private func switchVC(_ viewController: UIViewController) {
        
        let activeWindow = self.window ?? UIApplication.shared.connectedScenes.compactMap({($0 as? UIWindowScene)?.keyWindow}).first
        guard let window = activeWindow else {
            print(" Window is nil")
            return }
        
        
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
      



