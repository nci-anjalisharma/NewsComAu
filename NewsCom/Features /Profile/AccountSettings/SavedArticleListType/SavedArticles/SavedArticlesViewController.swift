//
//  SavedArticles.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 02/06/26.
//

import UIKit

class SavedArticlesViewController: UIViewController {
    
    weak var delegate: SaveArticlesDelegate?
    
    private let tableView = UITableView()
    
    private let type: ArticleListType
    
    private let theme = ThemeManager.shared.currentTheme
    
    init(type: ArticleListType) {
        self.type = type
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle()
        setupTableView()
    }
    
    private func setTitle(){
        switch type {
            
        case .saved:
            self.title = "Saved Articles"
            
        case .history:
            self.title = "Reading History"
        }
    }
    
    private var articles: [Article] {

        switch type {

        case .saved:
            return SavedManager.shared.fetchSavedArticles().reversed()

        case .history:
            return ReadingHistoryManager.shared.history.reversed()
        }
    }
    
    private func setupTableView() {
        
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.separatorStyle = .none
        
        tableView.register(LatestNewsTableViewCell.self, forCellReuseIdentifier: "SavedArticlesCell")

        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.backgroundColor = theme.colors.background
        tableView.layer.cornerRadius = 16
        tableView.contentInsetAdjustmentBehavior = .automatic
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SavedArticlesViewController: SaveArticlesDelegate {
 
    func didSaveArticle(_ article: Article) {
    }
    
    func didRemoveSaveArticle(_ article: Article) {

    }
}

extension SavedArticlesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let articleNewsCell = tableView.dequeueReusableCell(withIdentifier: "SavedArticlesCell", for: indexPath) as! LatestNewsTableViewCell
        
        let item = articles[indexPath.row]
        articleNewsCell.configure(item: item)

        return articleNewsCell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
            
        let vc = ArticlePageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        vc.hidesBottomBarWhenPushed = true
        vc.configure(with: articles, startIndex: indexPath.row)
            
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
}
