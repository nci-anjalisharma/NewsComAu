//
//  SupriseArticleViewController.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 29/07/26.
//


import UIKit
import SnapKit

class SurpriseArticleViewController: UIViewController {
    
    private lazy var translateButton: UIButton = {

        let button = UIButton(type: .system)

        button.setImage(UIImage(systemName: "speaker.wave.2"), for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 28
        button.backgroundColor = ThemeManager.shared.currentTheme.colors.secondary

        return button
    }()
    
//    private let readingProgressView: UIProgressView = {
//        let progressView = UIProgressView(progressViewStyle: .default)
//        progressView.progress = 0
//        progressView.trackTintColor = UIColor.systemGray5
//        progressView.progressTintColor = ThemeManager.shared.currentTheme.colors.secondary
//        return progressView
//    }()
    
    private let articleLabel = UILabel()
    private var articleText: String?
    
    private var articleVM: ArticlePageViewModel?
    
    let articleTableView = ArticleTableView()
    private var relatedStories: RelatedStoriesViewModel?
    
    var article: Article?
    
    var onBottomReached: ((Bool) -> Void)?
    
    var onDoubleTap: ((CGPoint) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let article {
            articleVM = ArticlePageViewModel(article: article)
        }
        
        articleTableView.tableView.delegate = self
        articleTableView.tableView.dataSource = self
        
        setupTableView()
        
        let doubleTap = UITapGestureRecognizer(
            target: self,
            action: #selector(handleDoubleTap(_:))
        )

        doubleTap.numberOfTapsRequired = 2
        articleTableView.tableView.addGestureRecognizer(doubleTap)
        
        //translate
        setupTranslateButton()
        configureLanguageMenu()
        
//        view.addSubview(readingProgressView)
//        view.bringSubviewToFront(readingProgressView)
//
//        readingProgressView.snp.makeConstraints {
//            $0.top.equalTo(view.safeAreaLayoutGuide)
//            $0.leading.trailing.equalToSuperview()
//            $0.height.equalTo(3)
//        }
    }
    
    private func setupTranslateButton() {

        view.addSubview(translateButton)

        translateButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.width.height.equalTo(56)
        }
    }
    
    private func configureLanguageMenu() {

        let actions = TranslationLanguage.allCases.map { language in

            UIAction(title: language.title) { [weak self] _ in

                self?.translateArticle(to: language)
            }
        }

        translateButton.menu = UIMenu(
            title: "Translate",
            children: actions
        )

        translateButton.showsMenuAsPrimaryAction = true
    }
    
    private func translateArticle(to language: TranslationLanguage) {

//        articleVM?.toggleTranslation(to: language) { [weak self] in
//
//            DispatchQueue.main.async {
//
//                self?.articleTableView.tableView.reloadData()
//            }
//        }
    }
    
    @objc private func handleDoubleTap(_ gesture: UITapGestureRecognizer) {

        let point = gesture.location(in: articleTableView.tableView)
        onDoubleTap?(point)
    }
    
    private func setupTableView(){
    
        view.addSubview(articleTableView)
        
        articleTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configure(article: Article, relatedStoriesArticle: [Article]) {
        self.article = article
        self.articleVM = ArticlePageViewModel(article: article)

        let filteredArticles = relatedStoriesArticle.filter {
            $0.url != article.url
        }

        self.relatedStories = RelatedStoriesViewModel(
            articles: filteredArticles
        )
    }
}

extension SurpriseArticleViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
            
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: TopImageCell.identifier, for: indexPath) as! TopImageCell
            
            cell.configure(imageName: article?.urlToImage ?? "")
            
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: TopicAndTimeCell.identifier, for: indexPath) as! TopicAndTimeCell
            cell.configure(article: article!)
            return cell
        
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: HeadLineCell.identifier, for: indexPath) as! HeadLineCell
            cell.configure(headline: articleVM?.headline ?? "")
            return cell
        
        case 3:
            return tableView.dequeueReusableCell(withIdentifier: DividerCell.identifier, for: indexPath) as! DividerCell
            
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: AuthorAndPublishDateCell.identifier, for: indexPath) as! AuthorAndPublishDateCell
            cell.configure(authorName: articleVM?.authorName ?? "", authorImage: articleVM?.imageNmae ?? "", publishDate: articleVM?.timePublished ?? "")
            return cell
            
        case 5:
            return tableView.dequeueReusableCell(withIdentifier: DividerCell.identifier, for: indexPath) as! DividerCell
            
        case 6:
            let cell = tableView.dequeueReusableCell(withIdentifier: ArticleContentCell.identifier, for: indexPath) as! ArticleContentCell
            cell.configiure(articleContent: articleVM?.content ?? "")
            return cell
            
//        case 7:
//            return tableView.dequeueReusableCell(withIdentifier: AttributedArticleContentCell.identifier, for: indexPath)
            
        case 7:
             return tableView.dequeueReusableCell(withIdentifier: DividerCell.identifier, for: indexPath) as! DividerCell
    
        case 8:
            return tableView.dequeueReusableCell(withIdentifier: LikesAndCommentCell.identifier, for: indexPath)
        
//        case 10:
//            return tableView.dequeueReusableCell(withIdentifier: SectionHeaderCell.identifier, for: indexPath) as! SectionHeaderCell
            
//        case 9:
//            let cell = tableView.dequeueReusableCell(withIdentifier: RelatedStoriesCell.identifier, for: indexPath) as! RelatedStoriesCell
//            
//            cell.selectionStyle = .none
//    
//            cell.parentViewController = self
//
//            if let relatedStories {
//                cell.configure(viewModel: relatedStories)
//            }
//                return cell
//            
//        case 10:
//            let cell = tableView.dequeueReusableCell(
//                withIdentifier: SwipeForNextCell.identifier,
//                for: indexPath
//            ) as! SwipeForNextCell
//
//            if let nextArticle = relatedStories?.relatedArticles.first {
//                cell.configure(nextHeadline: nextArticle.title ?? "Next Article")
//            }
//
//            return cell
//            
            
        default:
            return UITableViewCell()
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
     
        switch indexPath.row {

            case 3, 5, 7:
                return 17

            case 9:
                return 370
            
//            case 10:
//                return 350
//            
//            case 11:
//                return 150

            default:
                return UITableView.automaticDimension
            }
    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//
//        let offsetY = scrollView.contentOffset.y
//
//        let maxOffsetY = scrollView.contentSize.height - scrollView.bounds.height
//
//        let isAtBottom = offsetY >= maxOffsetY - 20
//
//        print("At Bottom:", isAtBottom)
//
//        onBottomReached?(isAtBottom)
//    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//
//        guard scrollView == articleTableView else { return }
//
//        let scrollableHeight = scrollView.contentSize.height - scrollView.bounds.height
//
//        guard scrollableHeight > 0 else {
//            readingProgressView.progress = 0
//            return
//        }
//
//        let progress = min(max(scrollView.contentOffset.y / scrollableHeight, 0), 1)
//
//        readingProgressView.setProgress(Float(progress), animated: false)
//    }
}

