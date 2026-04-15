 


import UIKit

class OnboardingPageViewController: UIPageViewController, UIPageViewControllerDataSource{
    
    private var pagesList: [UIViewController] = []
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pagesList.firstIndex(of: viewController), currentIndex > 0 else {return nil}
        return pagesList[currentIndex - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pagesList.firstIndex(of: viewController), currentIndex < (pagesList.count - 1) else {return nil}
        return pagesList[currentIndex + 1]
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPages()
        self.dataSource = self
        view.backgroundColor = .systemBackground
        
    }
    
    private func setupPages() {
        
        let topics: [String] = ["Page 1", "Page 2", "Page 3", "Page 4", "Page 5"]
        let colors: [UIColor] = [.systemRed, .systemOrange, .systemYellow, .systemGreen, .systemBlue]
        
        for i in 0..<topics.count {
            let stepVC = OnboardingStepViewController()
            stepVC.pageIndex = i
            stepVC.view.backgroundColor = colors[i]
            
            stepVC.onSignUpPressed = {
                
                let vc = SignupScreenViewController()
                vc.modalPresentationStyle = .popover
                self.present(vc, animated: true)
//                if let window = self.view.window {
//                    window.rootViewController = vc
//                    UIView.transition(with: window, duration: 0.3, options: .transitionCurlUp, animations: nil)
//                }
            }
            
            stepVC.onLoginPressed = {
                let vc = LoginScreenViewController()
                vc.modalPresentationStyle = .popover
                self.present(vc, animated: true)
//                if let window = self.view.window {
//                    window.rootViewController = vc
//                    UIView.transition(with: window, duration: 0.3, options: .transitionCurlUp, animations: nil)
//                }
            }
            
            stepVC.onSkipPressed = {
                let vc = BaseTabBarController()
                if let window = self.view.window {
                    window.rootViewController = vc
                    UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil)
                }
            }
            pagesList.append(stepVC)
           
        }
        if let firstPage = pagesList.first {
            setViewControllers([firstPage], direction: .forward, animated: true)
        }
        
    }
}
