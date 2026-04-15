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
        
        let homeVC = HomeViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        let menuVC = MenuViewController()
        let watchVC = WatchViewController()
        let quizVC = QuizViewController()
        
        let homeTab = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        let watchTab = UITabBarItem(title: "Watch", image: UIImage(systemName: "play.circle.fill"), tag: 1)
        let quizTab = UITabBarItem(title: "Quiz", image: UIImage(systemName: "square.grid.2x2"), tag: 2)
        let menuTab = UITabBarItem(title: "Menu", image: UIImage(systemName: "list.bullet"), tag: 3)
        
        let nav1 = UINavigationController(rootViewController: homeVC)
        nav1.navigationBar.prefersLargeTitles = true
        let nav2 = UINavigationController(rootViewController: watchVC)
        nav2.navigationBar.prefersLargeTitles = true
        let nav3 = UINavigationController(rootViewController: quizVC)
        nav3.navigationBar.prefersLargeTitles = true
        let nav4 = UINavigationController(rootViewController: menuVC)
        nav4.navigationBar.prefersLargeTitles = true
        
        nav1.tabBarItem = homeTab
        nav2.tabBarItem = watchTab
        nav3.tabBarItem = quizTab
        nav4.tabBarItem = menuTab
        
        nav1.title = "Home"
        nav2.title = "Watch"
        nav3.title = "Quiz"
        nav4.title = "Menu"
        
        tabBar.tintColor = .white
        tabBar.tintColor = .systemBackground
        
        self.viewControllers = [nav1, nav2, nav3, nav4]
        
        
        
        
    }
}




