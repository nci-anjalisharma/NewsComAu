//
//  HomeViewController.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 09/04/26.
//


import UIKit
import SnapKit

class HomeViewController: UIViewController, UIPageViewControllerDataSource, UITableViewDataSource, UITableViewDelegate, UIPageViewControllerDelegate {
    
    
    var latestNewsArticles: [Article] = []

    let tableView = UITableView()

    var pageVC: UIPageViewController!
    var articlePages: [UIViewController] = []
    let pageControl = UIPageControl()
//    var searchBar = UISearchController(searchResultsController: SearchViewController())
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.backgroundColor = .lightGray.withAlphaComponent(0.1)

        navigationItem.title = "The Daily News"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapAdd))
        
        
        view.addSubview(tableView)
        tableView.frame = view.bounds
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.backgroundColor = .clear
        tableView.layer.cornerRadius = 16
        tableView.contentInsetAdjustmentBehavior = .automatic
        tableView.register(LatestNewsTableViewCell.self, forCellReuseIdentifier: "LatestNewsCell")
        tableView.register(BreakingNewsTableViewCell.self, forCellReuseIdentifier: "BreakingNewsCell")
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            
        }
        
         
    
        tableView.separatorStyle = .none
        
        setupDummyData()
        setupArticlePages()
    
    }

    @objc private func didTapAdd(){
        let searchBar = UISearchController()
        searchBar.modalPresentationStyle = .fullScreen
        present(searchBar, animated: true, completion: nil)
    }

    func setupDummyData(){
        
        latestNewsArticles = [
            
            Article(
                    title: "Apple sold for 5000. Nutritionists Concerned",
                    author: "Apple Man",
                    imageURL: "news13",
                    description: "Increase rise in the trend of Excotic fruits like Kiwi and Dragon fruit has left apples in grave danger"),
            
            Article(
                    title: "Sports",
                    author: "ESPN",
                    imageURL: "news12",
                    description: "Chelsea secure dramatic win in final minutes after intense second half"),

            Article(
                    title: "Politics",
                    author: "BBC",
                    imageURL: "news9",
                    description: "Global leaders gather for climate summit discussions in Geneva"),

            Article(
                    title: "Finance",
                    author: "Bloomberg",
                    imageURL: "news3",
                    description: "Stock markets surge as tech companies report stronger earnings"),

                    Article(
                        title: "Entertainment",
                        author: "Netflix Daily",
                        imageURL: "news4",
                        description: "New sci-fi thriller becomes the most streamed show this week"
                    ),

                    Article(
                        title: "Science",
                        author: "NASA",
                        imageURL: "news5",
                        description: "Astronomers discover potentially habitable planet near solar system"
                    ),

                    Article(
                        title: "Travel",
                        author: "Lonely Planet",
                        imageURL: "news8",
                        description: "Japan announces new digital nomad visa for remote workers"
                    ),

                    Article(
                        title: "Gaming",
                        author: "IGN",
                        imageURL: "news7",
                        description: "Major open-world RPG delayed until early next year"
                    ),

                    Article(
                        title: "Fashion",
                        author: "Vogue",
                        imageURL: "news8",
                        description: "Minimal streetwear trends dominate summer collections"
                    ),

                    Article(
                        title: "Health",
                        author: "WHO",
                        imageURL: "news9",
                        description: "Experts recommend new sleep routines for better mental health"
                    ),

                    Article(
                        title: "Food",
                        author: "Food Insider",
                        imageURL: "news10",
                        description: "Traditional South Indian dishes gain global popularity"
                    ),

                    Article(
                        title: "AI",
                        author: "OpenAI",
                        imageURL: "news7",
                        description: "New AI tools are transforming productivity across industries"
                    )
                ]
    }
    

    private func setupArticlePages() {
        // creating three pages
        pageVC = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        
        
        pageVC.dataSource = self
        pageVC.delegate = self
        
        
        let news1 = VerticalPageScrollViewController(headline: "", color: .clear)
        news1.configure(article: latestNewsArticles[0])
        
        let news2 = VerticalPageScrollViewController(headline: "", color: .clear)
        news2.configure(article: latestNewsArticles[1])
        
        let news3 = VerticalPageScrollViewController(headline: "", color: .clear)
        news3.configure(article: latestNewsArticles[2])
        
        let news4 = VerticalPageScrollViewController(headline: "", color: .clear)
        news4.configure(article: latestNewsArticles[3])
        
        
//        for i in 1...3 {
//            let article = latestNewsArticles[i]
//            let news = VerticalPageScrollViewController(headline: article.description, color: .black)
//            latestNewsArticles.
//        }
     
        
        let pages: [(VerticalPageScrollViewController, Article)] = [(news1, latestNewsArticles[0]), (news2, latestNewsArticles[1]), (news3, latestNewsArticles[2]), (news4, latestNewsArticles[3])]

        
        for(index, pair) in pages.enumerated() {
            pair.0.onReadMorePressed = { [weak self] in
                
                let detailVC = ArticlePageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: .none)
                detailVC.configure(with: self!.latestNewsArticles, startIndex: index)
                
                self?.navigationController?.pushViewController(detailVC, animated: true)
            }
        }
        
        articlePages = [news1, news2, news3, news4]
        
        pageControl.numberOfPages = articlePages.count
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .lightGray

        
        if let first = articlePages.first {
            pageVC.setViewControllers([first], direction: .forward, animated: true)
        }
        
        
        
        addChild(pageVC)
        pageVC.didMove(toParent: self)
        view.addSubview(pageControl)
    }

    
    // Data source (pageview)
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = articlePages.firstIndex(of: viewController), index > 0 else { return nil }
        return articlePages[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = articlePages.firstIndex(of: viewController), index < articlePages.count - 1 else { return nil }
        return articlePages[index + 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers previousViewController: [UIViewController], transitionCompleted completed: Bool) {
        
        guard completed,
              let visibleVC = pageViewController.viewControllers?.first,
              let index = articlePages.firstIndex(of: visibleVC) else { return }
        
        pageControl.currentPage = index
    }
    
    
    //tableview
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 1
        } else {
            return latestNewsArticles.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 250
        
        case 1:
            return 300
        
        case 2:
            return 160
            
        default:
            return 100
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section{
        case 0: return "Today Trending"
        case 1: return "Breaking News"
        case 2: return "Latest News"
        default: return nil
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 12
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default,
                                   reuseIdentifier: nil)
        
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }
        
        if indexPath.section == 0 {
            
            //trending section
            pageVC.view.removeFromSuperview()
        
            pageControl.removeFromSuperview()
            
            cell.contentView.addSubview(pageVC.view)
            cell.contentView.addSubview(pageControl)
            
            pageVC.view.snp.makeConstraints { make in
                make.top.leading.trailing.equalToSuperview()
                make.height.equalTo(250)
            }
            
            pageControl.snp.makeConstraints { make in
                make.top.equalTo(pageVC.view.snp.bottom)
                make.centerX.equalToSuperview()
                make.height.equalTo(30)
                make.bottom.equalToSuperview()
            }
            
        } else if indexPath.section == 1 {
            
            let breakingCell = tableView.dequeueReusableCell(withIdentifier: "BreakingNewsCell", for: indexPath) as! BreakingNewsTableViewCell
            breakingCell.parentViewController = self
            
            
            return breakingCell
            
        } else if indexPath.section == 2 {
            
            let latestNewsCell = tableView.dequeueReusableCell(withIdentifier: "LatestNewsCell", for: indexPath) as! LatestNewsTableViewCell
            
            let article = latestNewsArticles[indexPath.row]
            latestNewsCell.configure(article: article)
            
            return latestNewsCell
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        if indexPath.section == 2 {
            
            let vc = ArticlePageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
            vc.configure(with: latestNewsArticles, startIndex: indexPath.row)
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
}
