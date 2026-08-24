



import UIKit
import SnapKit

class BaseTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabs()
        applyTheme()
        
        NotificationCenter.default.addObserver(self, selector: #selector(themeChanged), name: .themeChanged, object: nil)
    }

    @objc private func themeChanged() {
        applyTheme()
    }
    
    private func applyTheme() {
        
        let theme = ThemeManager.shared.currentTheme
        
        let tabAppearance = UITabBarAppearance()
        tabAppearance.configureWithOpaqueBackground()
        tabAppearance.backgroundColor = theme.colors.surface
        
        tabBar.standardAppearance = tabAppearance
        tabBar.scrollEdgeAppearance = tabAppearance
        
        tabBar.tintColor = theme.colors.secondary
        tabBar.unselectedItemTintColor = .gray
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        
        appearance.titleTextAttributes = [.foregroundColor: theme.colors.primary]
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
    }
    
    private func setupTabs() {
    
        let homeTab = UITab(title: "Home", image: UIImage(systemName: "house"), identifier: "home") { _ in
            
            UINavigationController(rootViewController: HomeViewController())
        }
    
        let exploreTab = UITab(title: "Explore", image: UIImage(systemName: "safari"), identifier: "explore") { _ in
            
            NewsNavigationController(rootViewController: ExploreViewController())
        }
        
        let profileTab = UITab(title: "Profile", image: UIImage(systemName: "person.circle"), identifier: "profile") { _ in
            
            UINavigationController(rootViewController: MenuViewController())
        }
       
        if #available(iOS 26.0, *) {
            let searchTab = UISearchTab { _ in
                
                UINavigationController(rootViewController: SearchViewController())
            }
            searchTab.automaticallyActivatesSearch = true
            tabs = [homeTab, exploreTab, profileTab, searchTab]
        } else {
            let searchTab = UITab(title: "Search", image: UIImage(systemName: "magnifyingglass.circle"), identifier: "search") { _ in
                
                UINavigationController(rootViewController: SearchViewController())
            }
            tabs = [homeTab, exploreTab, profileTab, searchTab]
        }
    }
}
