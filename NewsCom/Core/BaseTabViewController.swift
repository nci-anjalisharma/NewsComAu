//
//  TabBarController.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 09/04/26.
//


import UIKit

class BaseTabBarController: UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        
    }
    
    private func setupTabs() {
        
        let homeVC = HomeViewController()
        let menuVC = MenuViewController()
        let quizVC = QuizViewController()
        
        let homeTab = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        let exploreTab = UITabBarItem(title: "Explore", image: UIImage(systemName: "safari.fill"), tag: 2)
        let menuTab = UITabBarItem(title: "Menu", image: UIImage(systemName: "person.circle.fill"), tag: 3)
        
        let nav1 = UINavigationController(rootViewController: homeVC)
       
        let nav2 = UINavigationController(rootViewController: quizVC)
         
        let nav3 = UINavigationController(rootViewController: menuVC)
       
        
        nav1.tabBarItem = homeTab
        nav2.tabBarItem = exploreTab
        nav3.tabBarItem = menuTab
        
        nav1.title = "Home"
        nav2.title = "Explore"
        nav3.title = "Profile"
        
        tabBar.tintColor = .black
        
        self.viewControllers = [nav1, nav2, nav3]
        
    }
}




