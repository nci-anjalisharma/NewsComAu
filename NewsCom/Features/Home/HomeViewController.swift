//
//  HomeViewController.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 09/04/26.
//




import UIKit


class HomeViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    var articlePages: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.title = "Home"
    
        
        setupArticlePages()
    }
    
    private func setupArticlePages() {
        // creating three pages
        let news1 = VerticalPageScrollViewController(headline: "Breaking news", color: .systemRed)
        let news2 = VerticalPageScrollViewController(headline: "Entertainment news", color: .systemBlue)
        let news3 = VerticalPageScrollViewController(headline: "Sports news", color: .systemPurple)
        
        // Passing navigation ability to the child
        [news1, news2, news3].forEach { vc in
            vc.onReadMorePressed = { [weak self] in
                let detailVC = FullArticleViewController()
                detailVC.title = "Full Story"
                
                self?.navigationController?.pushViewController(detailVC, animated: true)
            }
        }
        
        articlePages = [news1, news2, news3]
        
        if let first = articlePages.first {
            setViewControllers([first], direction: .forward, animated: true)
        }
    }

    // Data source
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = articlePages.firstIndex(of: viewController), index > 0 else { return nil }
        return articlePages[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = articlePages.firstIndex(of: viewController), index < articlePages.count - 1 else { return nil }
        return articlePages[index + 1]
    }
}
