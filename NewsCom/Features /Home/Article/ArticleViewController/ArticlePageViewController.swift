//
//  ArticlePageViewCOntroller.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 19/05/26.
//


import UIKit

class ArticlePageViewController: UIPageViewController{
    
    var articles: [Article] = []
    
    var pages: [FullArticleViewController] = []
    
    var currentIndex: Int = 0
    
    var isSaved: Bool = false
    var saveButton: UIBarButtonItem!
    var shareButton: UIBarButtonItem!
    var celebrationButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        dataSource = self
        delegate = self
        
       
        
        saveButton = UIBarButtonItem(title: nil, image: UIImage(systemName: "bookmark"), target: self, action: #selector(didTapAdd))
        
        shareButton = UIBarButtonItem(title: nil, image: UIImage(systemName: "square.and.arrow.up"), target: self, action: #selector(didTapShare))
        celebrationButton = UIBarButtonItem(title: nil, image:  UIImage(systemName: "wand.and.stars"), target: self, action: #selector(didTapCelebrateButton))
        self.navigationItem.rightBarButtonItems = [saveButton, shareButton, celebrationButton]
        
    }
    
    func configure(with articles: [Article], startIndex: Int){
        self.articles = articles
        self.currentIndex = startIndex
        
        setupPages()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: false
        )
    }
    
    private func setupPages() {
        
        pages = articles.map { article in
            
            let vc = FullArticleViewController()
            vc.article = article
            
            return vc
        }
        
        guard !pages.isEmpty else {
            return
        }
        
        setViewControllers([pages[currentIndex]], direction: .forward, animated: false)
    }
    
    
    @objc func didTapCelebrateButton() {
       
        CelebrationManager.launch(in: self.view)
    }
   

    @objc func didTapAdd() {
    
        isSaved.toggle()
        
        let imageName = isSaved ? "bookmark.fill" : "bookmark"
        
        saveButton.image = UIImage(systemName: imageName)
        

    }
    
    @objc func didTapShare(){
        
    }
}


extension ArticlePageViewController:  UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let currentViewController = viewController as? FullArticleViewController, let index = pages.firstIndex(of: currentViewController), index > 0 else {
            return nil
        }
        return pages[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentViewController = viewController as? FullArticleViewController, let index = pages.firstIndex(of: currentViewController), index < (pages.count - 1) else {
            return nil
        }
        return pages[index + 1]
    }
}
