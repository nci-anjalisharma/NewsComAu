//
//  SearchViewController.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 16/07/26.
//

import UIKit
import SnapKit

class SearchViewController: UIViewController {
    
    private let tableView = UITableView()
    private let viewModel = SearchViewModel()
    private let forYouViewModel = ForYouViewModel()
    
    private var isTopicSearch = false
        
    private let emptyLabel: UILabel = {
        let label = UILabel()
        label.text = "Start typing to search news"
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var emptyStateLabel: UILabel = {
        let label = UILabel()
        label.text = "No articles found"
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        label.font = .preferredFont(forTextStyle: .headline)
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()

    private let searchController = UISearchController(
        searchResultsController: nil
    )

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchBar.delegate = self
        
        print("ViewDidLOad")
        testANNAPI()

        view.backgroundColor = .systemBackground
        title = "Search"

        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false

        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        
        setupTableView()
        
        viewModel.onResultsUpdated = { [weak self] in
            guard let self else { return }

            tableView.reloadData()

            let searchText = searchController.searchBar.text ?? ""

            if searchText.isEmpty {

                emptyLabel.isHidden = true
                emptyStateLabel.isHidden = true
                tableView.isHidden = false

            } else if viewModel.filteredArticles.isEmpty {

                emptyLabel.isHidden = true
                
                if isTopicSearch {
                        emptyStateLabel.text = "No data fetched from API"
                    } else {
                        emptyStateLabel.text = "No articles found for \"\(searchText)\""
                    }
                
                emptyStateLabel.isHidden = false
                tableView.isHidden = true

            } else {

                emptyLabel.isHidden = true
                emptyStateLabel.isHidden = true
                tableView.isHidden = false
            }
        }
       
        
        view.addSubview(emptyLabel)

        emptyLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(32)
        }
        view.addSubview(emptyStateLabel)

        emptyStateLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(32)
        }
        
        forYouViewModel.onDataUpdated = { [weak self] in

            guard let self else { return }

            DispatchQueue.main.async {
                self.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
            }
        }
        
        viewModel.loadArticles()
        forYouViewModel.fetchArticles()
        
    }
    
    private func testANNAPI() {
        
        print("ANN TEST STARTED")
        
        let urlString = "https://cdn.animenewsnetwork.com/encyclopedia/api.xml?anime=155"
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error { return }
            
            guard let data else { return }
        
        }.resume()
    }
    
    private func searchTopic(_ topic: String) {
        
        isTopicSearch = true

        searchController.searchBar.text = topic

        viewModel.search(text: topic)
        
        tableView.isHidden = false
        emptyLabel.isHidden = true
        emptyStateLabel.isHidden = true
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        searchController.isActive = true

        DispatchQueue.main.async {
            self.searchController.searchBar.becomeFirstResponder()
        }
    }
    
    private func setupTableView() {
        
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        tableView.backgroundColor = ThemeManager.shared.currentTheme.colors.background
        
        tableView.separatorStyle = .none
 
        tableView.showsVerticalScrollIndicator = false
        
        tableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 20, right: 0)
        
        tableView.register(DiscoverTopicCell.self, forCellReuseIdentifier: DiscoverTopicCell.identifier)
        
        tableView.register(LatestNewsTableViewCell.self, forCellReuseIdentifier: "LatestNewsCell")
        
        tableView.register(BreakingNewsTableViewCell.self, forCellReuseIdentifier: BreakingNewsTableViewCell.identifier)
    }
}

extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        let searchText = searchController.searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""

        if searchText.isEmpty {
            return 1
        }
        return viewModel.filteredArticles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let searchText = searchController.searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""

        if searchText.isEmpty {

            if indexPath.section == 0 {

                let cell = tableView.dequeueReusableCell(withIdentifier: BreakingNewsTableViewCell.identifier, for: indexPath) as! BreakingNewsTableViewCell

                cell.parentViewController = self

                cell.onFreeNewsArticleTapped = { [weak self] article in

                    self?.openFreeNewsArticle(article)
                }

                cell.configure(item: forYouViewModel.articles)

                return cell
            }

            let cell = tableView.dequeueReusableCell(withIdentifier: DiscoverTopicCell.identifier, for: indexPath) as! DiscoverTopicCell

            cell.onAnimeTapped = { [weak self] in

                let animeVC = AnimeViewController()

                self?.navigationController?.pushViewController(animeVC, animated: true)
            }
            
            cell.onTopicTapped = { [weak self] topic in
                self?.searchTopic(topic)
            }
            return cell
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: "LatestNewsCell", for: indexPath) as! LatestNewsTableViewCell

        cell.configure(item: viewModel.filteredArticles[indexPath.row])

        return cell
    }
    
    private func openFreeNewsArticle(_ freeNewsArticle: FreeNewsListArticle) {

        print("Free News article selected")
        print("UUID:", freeNewsArticle.uuid)

        FreeNewsAPIManager.shared.fetchArticleDetails(uuid: freeNewsArticle.uuid) { [weak self] result in

            DispatchQueue.main.async {

                guard let self else { return }

                switch result {

                case .success(let response):
                    
                    let article = self.convertFreeNewsToArticle(response.data)

                    let vc = ArticlePageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)

                    vc.configure(with: [article], startIndex: 0)

                    vc.hidesBottomBarWhenPushed = true

                    self.navigationController?.pushViewController(vc, animated: true)

                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    private func convertFreeNewsToArticle(_ detail: FreeNewsDetailArticle) -> Article {

        Article(source: Source(id: nil, name: detail.publisher), author: detail.authors?.first, title: detail.title, description: nil, url: detail.originalURL, urlToImage: detail.thumbnail, publishedAt: detail.publishedAt, content: detail.body)
    }
}

extension SearchViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        
        let text = searchController.searchBar.text ?? ""
        
        viewModel.search(text: text)
    }
}

extension SearchViewController: UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {

        let searchText = searchController.searchBar.text?
            .trimmingCharacters(in: .whitespacesAndNewlines) ?? ""

        if searchText.isEmpty {
            return 2
        }

        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let searchText = searchController.searchBar.text ?? ""
        
        if searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty { return }
        
        let article = viewModel.filteredArticles[indexPath.row]
        
        let detailVC = FullArticleViewController()
        
        detailVC.configure(article: article, relatedStoriesArticle: viewModel.filteredArticles)
        
        detailVC.hidesBottomBarWhenPushed = true
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        let searchText = searchController.searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""

        if searchText.isEmpty {

            if indexPath.row == 0 {
                return 320
            }
            
            return 305
        }
        return 150
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        let searchText = searchController.searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""

        if searchText.isEmpty {

            if section == 0 {
                return "For You"
            } else if section == 1 {
                return "Discover by Topic"
            }
        }
        return nil
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isTopicSearch = false
    }
}
