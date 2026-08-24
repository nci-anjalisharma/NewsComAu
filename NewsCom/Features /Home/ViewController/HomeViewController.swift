//
//  HomeViewController.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 09/04/26.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    private var isNicoVisible = false
    
    private let homeViewModel = HomeViewModel()
    private let tableView = UITableView()
    
    private  let theme = ThemeManager.shared.currentTheme

    private let nicoView = NicoView()
    
    private lazy var surpriseButton: UIButton = {
        let button = UIButton(type: .system)

        let image = UIImage(systemName: "sparkles", withConfiguration: UIImage.SymbolConfiguration(pointSize: 18, weight: .medium))

        button.setImage(image, for: .normal)
        button.tintColor = .label

        button.layer.cornerRadius = 10
        button.clipsToBounds = true

        button.snp.makeConstraints { make in
            make.width.height.equalTo(36)
        }

        button.addTarget(self, action: #selector(surpriseButtonTapped), for: .touchUpInside)

        return button
    }()
    
    private let surpriseBanner = SurpriseBannerView()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupNavigation()
        
        setupTitleLongPress()
        
        setupTableView()
        reloadFetchedData()
        applyTheme()
        
        setupNico()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(articlesUpdated),
            name: .savedArticlesChanged,
            object: nil
        )
    
        NotificationCenter.default.addObserver(self, selector: #selector(themeChanged), name: .themeChanged, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(nicoTapped), name: .nicoTapped, object: nil)
        
//        view.addSubview(surpriseButton)
//        
//        surpriseButton.snp.makeConstraints {
//            $0.trailing.equalToSuperview().inset(20)
//            $0.top.equalTo(view.safeAreaLayoutGuide).offset(12)
//
//            $0.height.equalTo(45)
//        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: surpriseButton)
        
        view.addSubview(surpriseBanner)

        surpriseBanner.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(12)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(60)
        }
    }
    
    @objc
    private func surpriseButtonTapped() {

        guard let article = homeViewModel.randomArticle() else {
            return
        }

        surpriseBanner.show(message: "Finding something you'll love...") { [weak self] in
            guard let self else { return }

            let vc = SurpriseArticleViewController()
            vc.article = article
            
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        hideNico()
    }
    
    @objc private func themeChanged() {
        
        setupNavigation()
        applyTheme()
        
        tableView.reloadData()
    }
    
    @objc private func articlesUpdated() {
        tableView.reloadData()
    }
    
//    @objc
//    private func nicoTapped() {
//
//        UIView.animate(withDuration: 0.25) {
//            self.nicoView.alpha = 0
//        }
//
//        isNicoVisible = false
//    }
//    
    private func setupTitleLongPress() {

        guard let navigationBar = navigationController?.navigationBar else {
            return
        }

        let gesture = UILongPressGestureRecognizer(
            target: self,
            action: #selector(titleLongPressed(_:))
        )

        gesture.minimumPressDuration = 1.0

        navigationBar.addGestureRecognizer(gesture)
    }

    @objc
    private func titleLongPressed(_ gesture: UILongPressGestureRecognizer) {

        guard gesture.state == .began else { return }
        guard !isNicoVisible else { return }

        isNicoVisible = true

        UIView.animate(withDuration: 0.35) {
            self.nicoView.alpha = 1
        }
    }
    
    private func setupNico() {

        view.addSubview(nicoView)
        
        nicoView.isUserInteractionEnabled = true
        
        nicoView.alpha = 0

        nicoView.snp.makeConstraints { make in
            make.width.height.equalTo(110)
            
            make.leading.equalToSuperview().offset(99)
            
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(28)
            
        }


        view.bringSubviewToFront(nicoView)
        
    }
    
    @objc
    private func nicoTapped() {

        guard isNicoVisible else { return }

        isNicoVisible = false

        UIView.animate(withDuration: 0.3) {
            self.nicoView.alpha = 0
        }
    }
    
    private func applyTheme() {

        let theme = ThemeManager.shared.currentTheme

        view.backgroundColor = theme.colors.background
        tableView.backgroundColor = theme.colors.background
        
        surpriseButton.tintColor = ThemeManager.shared.currentTheme.colors.secondary
        surpriseButton.backgroundColor = ThemeManager.shared.currentTheme.colors.background

    }
    
    private func hideNico() {

        guard isNicoVisible else { return }

        isNicoVisible = false

        UIView.animate(withDuration: 0.25) {
            self.nicoView.alpha = 0
        }
    }
    
    private func reloadFetchedData(){
        
        homeViewModel.onDataUpdated = { [weak self] in
            
            guard let self = self else { return }

            self.tableView.reloadData()
        }

        homeViewModel.fetchAllData()
    }
    
    private func setupNavigation(){
        
        let theme = ThemeManager.shared.currentTheme

        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: theme.colors.primary
        ]
        navigationItem.title = "The Daily News"

    }
    
    private func setupTableView(){
//        
//        let theme = ThemeManager.shared.currentTheme
//        
        view.addSubview(tableView)
        tableView.frame = view.bounds
       // tableView.backgroundColor = theme.colors.background
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.layer.cornerRadius = 16
        tableView.contentInsetAdjustmentBehavior = .automatic
        
        tableView.register(LatestNewsTableViewCell.self, forCellReuseIdentifier: "LatestNewsCell")
        tableView.register(BreakingNewsTableViewCell.self, forCellReuseIdentifier: "BreakingNewsTableViewCell")
        tableView.register(TrendingTableViewCell.self, forCellReuseIdentifier: TrendingTableViewCell.identifier)
        tableView.register(DailyDiscoveryTableViewCell.self, forCellReuseIdentifier: "DailyDiscoveryTableViewCell")
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            
        }
        tableView.separatorStyle = .none
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        tableView.reloadData()
    }
}

    extension HomeViewController: UITableViewDataSource, UITableViewDelegate {

        func numberOfSections(in tableView: UITableView) -> Int {
            return 4
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            print("numberOfRowsInSection: ", section)
            
            if section == 0 {
                return 1
            } else if section == 1 {
                return 1
            } else if section == 3 {
                return homeViewModel.latestArticles.count
            }
            return 1
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            switch indexPath.section {
            case 0:
                return 300
                
            case 1:
                return 320
                
            case 2:
                return 220
                
            default:
                return 160
                
            }
        }
        
        func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 10
        }
        
        func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            
            switch section{
            case 0: return "Today Trending"
            case 1: return "Breaking News"
            case 2: return "Daily Discovery"
            case 3: return "Latest News"
            default: return nil
            }
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            print("Section:", indexPath.section, "Row:", indexPath.row)
                        
            if indexPath.section == 0 {
                
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: TrendingTableViewCell.identifier,
                    for: indexPath
                ) as! TrendingTableViewCell

                cell.parentViewController = self

                cell.configure(with: homeViewModel.trendingArticles)

                cell.onArticleSelected = { [weak self] article in

                    guard let self else { return }

                    guard let index = self.homeViewModel.trendingArticles.firstIndex(where: {
                        $0.url == article.url
                    }) else {
                        return
                    }

                    let pageVC = ArticlePageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)

                    pageVC.hidesBottomBarWhenPushed = true

                    pageVC.configure(with: self.homeViewModel.trendingArticles, startIndex: index)

                    self.navigationController?.pushViewController(pageVC, animated: true)
                }

                return cell
                
            } else if indexPath.section == 1 {
                
                let breakingCell = tableView.dequeueReusableCell(withIdentifier: "BreakingNewsTableViewCell", for: indexPath) as! BreakingNewsTableViewCell
                breakingCell.selectionStyle = .none
                
                breakingCell.parentViewController = self
                print("Breaking News Articles Count: \(homeViewModel.breakingArticles.count)")
                breakingCell.configure(item: homeViewModel.breakingArticles)
                
                return breakingCell
                
            } else if indexPath.section == 2 {
                
                let discoveryCell = tableView.dequeueReusableCell(withIdentifier: DailyDiscoveryTableViewCell.identifier, for: indexPath) as! DailyDiscoveryTableViewCell

                discoveryCell.configureRandomFact()

                return discoveryCell
            
            } else if indexPath.section == 3 {
                
                let latestNewsCell = tableView.dequeueReusableCell(withIdentifier: "LatestNewsCell", for: indexPath) as! LatestNewsTableViewCell
                
                let item = homeViewModel.latestArticles[indexPath.row]
                latestNewsCell.configure(item: item)

                return latestNewsCell
                
            }
            
            return UITableViewCell()
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
            
            if indexPath.section == 3 {
                
                let vc = ArticlePageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
                vc.hidesBottomBarWhenPushed = true
                vc.configure(with: homeViewModel.latestArticles, startIndex: indexPath.row)
                
                navigationController?.pushViewController(vc, animated: true)
                tableView.deselectRow(at: indexPath, animated: true)
            }
//            tableView.deselectRow(at: indexPath, animated: true)
        }
}

