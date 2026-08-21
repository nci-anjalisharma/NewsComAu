//
//  TodayTrendingTableViewCell.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 27/05/26.
//

import UIKit
import SnapKit

class TrendingTableViewCell: UITableViewCell {
    
    private var autoScrollTimer: Timer?
    private var currentIndex = 0
    
    static let identifier = "TrendingTableViewCell"
    
    weak var parentViewController: UIViewController?
    
    var onArticleSelected: ((Article) -> Void)?
    
    private let cardContainer = UIView()
    
    private let pageVC = UIPageViewController(
        transitionStyle: .scroll,
        navigationOrientation: .horizontal
    )
    
    private let pageControl = UIPageControl()
    
    private var articlePages: [UIViewController] = []
    private var articles: [Article] = []
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCard()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupCard(){
        selectionStyle = .none
        
//        view.addSubview(containerCardView)
        
        contentView.addSubview(cardContainer)
        contentView.addSubview(pageControl)
        
        cardContainer.layer.cornerRadius = 28
        cardContainer.clipsToBounds = false
        
        cardContainer.layer.shadowColor = UIColor.black.cgColor
        cardContainer.layer.shadowOpacity = 0.2
        cardContainer.layer.shadowRadius = 15
        cardContainer.layer.shadowOffset = CGSize(width: 0, height: 8)
        
        cardContainer.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(280)
        }
        
        pageControl.snp.makeConstraints { make in
            make.top.equalTo(cardContainer.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(20)
        }
        
        pageVC.dataSource = self
        pageVC.delegate = self
        
    }
    
    private func startAutoScroll() {

        autoScrollTimer?.invalidate()

        guard articlePages.count > 1 else { return }

        autoScrollTimer = Timer.scheduledTimer(
            withTimeInterval: 2.0,
            repeats: true
        ) { [weak self] _ in

            guard let self = self else { return }

            let nextIndex = (self.currentIndex + 1) % self.articlePages.count

            let nextViewController = self.articlePages[nextIndex]

            self.pageVC.setViewControllers(
                [nextViewController],
                direction: .forward,
                animated: true
            )

            self.currentIndex = nextIndex
            self.pageControl.currentPage = nextIndex
        }
    }
    
    func configure(with articles: [Article]) {
  
        self.articles = articles
        
        currentIndex = 0
        
        guard let parent = parentViewController else { return }
        
        if pageVC.parent == nil {

            parent.addChild(pageVC)

            cardContainer.addSubview(pageVC.view)

            pageVC.view.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }

            pageVC.didMove(toParent: parent)
        }
        
            articlePages = articles.map { article in
                
                let vc = TodayTrendingViewController()
                
                vc.configure(article: article)
                
                vc.onTap = { [weak self] article in
                    self?.onArticleSelected?(article)
                }
                
                return vc
            }
            
            pageControl.numberOfPages = articlePages.count
            
            if let first = articlePages.first {
                
                pageVC.setViewControllers([first], direction: .forward, animated: false)
            }
        
        pageControl.currentPage = 0

        startAutoScroll()
            
        let theme = ThemeManager.shared.currentTheme
            
        pageControl.pageIndicatorTintColor = theme.colors.secondary
        pageControl.currentPageIndicatorTintColor = theme.colors.primary
//        pageControl.backgroundColor = theme.colors.background
        pageControl.backgroundColor = .clear
        self.contentView.backgroundColor = theme.colors.background
        }
    
    override func prepareForReuse() {
        super.prepareForReuse()

        autoScrollTimer?.invalidate()
        autoScrollTimer = nil

        currentIndex = 0
    }
    
    deinit {
        autoScrollTimer?.invalidate()
    }
}


extension TrendingTableViewCell: UIPageViewControllerDataSource {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {

        guard
            let index = articlePages.firstIndex(of: viewController),
            index > 0
        else {
            return nil
        }

        return articlePages[index - 1]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {

        guard
            let index = articlePages.firstIndex(of: viewController),
            index < articlePages.count - 1
        else {
            return nil
        }

        return articlePages[index + 1]
    }
}

extension TrendingTableViewCell: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        guard
            completed,
            let vc = pageViewController.viewControllers?.first,
            let index = articlePages.firstIndex(of: vc)
        else { return }
        
        currentIndex = index
        pageControl.currentPage = index
    }
}
