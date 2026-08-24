//
//  ArticlePageViewCOntroller.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 19/05/26.
//


import UIKit
import SnapKit

class ArticlePageViewController: UIPageViewController{
    
    weak var savedArticlesDelegate: SaveArticlesDelegate?
    
    private var articles: [Article] = []
    
    private var pages: [FullArticleViewController] = []
    
    private var currentIndex: Int = 0
    
    private var pagingEnabled = false
    
    var isSaved: Bool = false
    
    private let saveButton = UIButton(type: .system)
    
    var shareButton: UIBarButtonItem!
    var celebrationButton: UIBarButtonItem!
    
    private lazy var readButton: UIButton = {

        let button = UIButton(type: .system)

        button.setImage(
            UIImage(systemName: "speaker.wave.2.fill"),
            for: .normal
        )

        button.tintColor = ThemeManager.shared.currentTheme.colors.secondary

        button.addTarget(
            self,
            action: #selector(readTapped),
            for: .touchUpInside
        )

        return button
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        print("ArticlePageViewController viewDidLoad")
        
        dataSource = self
        delegate = self
        
        savedArticlesDelegate = self
        
        setupNavigationBar()
        updateBookmarkIcon()
    }
    
    
    private func setupNavigationBar() {
        
        saveButton.setImage(UIImage(systemName: "bookmark"), for: .normal)

        saveButton.tintColor = ThemeManager.shared.currentTheme.colors.primary

        saveButton.addTarget(self, action: #selector(didTapAdd), for: .touchUpInside)
        saveButton.setImage(UIImage(systemName: "bookmark"), for: .normal)

        saveButton.tintColor = .label
        saveButton.addTarget(self, action: #selector(didTapAdd), for: .touchUpInside)
        
//        navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: readButton)]

        let bookmarkItem = UIBarButtonItem(customView: saveButton)
        
        let readAloutItem = UIBarButtonItem(customView: readButton)
        
        shareButton = UIBarButtonItem(title: nil, image: UIImage(systemName: "square.and.arrow.up"), target: self, action: #selector(didTapShare))
//        celebrationButton = UIBarButtonItem(title: nil, image:  UIImage(systemName: "wand.and.stars"), target: self, action: #selector(didTapCelebrateButton))
        
//        navigationItem.rightBarButtonItems = [
//            bookmarkItem,
//            shareButton,
//            celebrationButton
//        ]
        
        self.navigationItem.rightBarButtonItems = [bookmarkItem, shareButton]
    }
    
    @objc
    private func readTapped() {

        guard !articles.isEmpty,
              currentIndex < articles.count else {
            return
        }

        let article = articles[currentIndex]

        let articleText = """
        \(article.title ?? "")

        \(article.description ?? "")

        \(article.content ?? "")
        """

        if ReadAloudManager.shared.isSpeaking {

            ReadAloudManager.shared.pause()

            readButton.setImage(UIImage(systemName: "play.fill"), for: .normal)

        } else if ReadAloudManager.shared.isPaused {

            ReadAloudManager.shared.resume()

            readButton.setImage(
                UIImage(systemName: "pause.fill"),
                for: .normal
            )

        } else {

            ReadAloudManager.shared.speak(text: articleText)

            readButton.setImage(
                UIImage(systemName: "pause.fill"),
                for: .normal
            )
        }
    }
    
    func configure(with articles: [Article], startIndex: Int){
        self.articles = articles
        self.currentIndex = min(max(startIndex, 0), articles.count - 1)
        
        setupPages()
        updateBookmarkIcon()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    private func setupPages() {
        
        pages = articles.map { article in

            let vc = FullArticleViewController()

            vc.configure(
                article: article,
                relatedStoriesArticle: articles
            )

            vc.onBottomReached = { [weak self] isAtBottom in

                self?.setPagingEnabled(isAtBottom)
            }
            
//            vc.onDoubleTap = { [weak self, weak vc] point in
//                guard
//                    let self,
//                    let vc
//                else { return }
//
//                let convertedPoint = vc.view.convert(point, from: vc.articleTableView.tableView)
//
//                self.toggleSaveCurrentArticle(at: convertedPoint)
//            }
            
            vc.onDoubleTap = { [weak self, weak vc] point in
                guard
                    let self,
                    let vc
                else { return }

                let convertedPoint = vc.view.convert(
                    point,
                    from: vc.articleTableView.tableView
                )

                switch DoubleTapPreferenceManager.shared.selectedEffect {

                case .save:
                    self.toggleSaveCurrentArticle(at: convertedPoint)

                case .confetti:
                    CelebrationManager.launch(in: self.view)

                case .hearts:
                    HeartsManager.launch(in: self.view)

                case .fireworks:
                    SparklesManager.launch(in: self.view)

                case .crax:
                    CraxManager.launch(in: self.view)
                }
            }

            return vc
        }
        guard !pages.isEmpty else { return }
        
        setViewControllers([pages[currentIndex]], direction: .forward, animated: false)
        setPagingEnabled(false)
        
        ReadingHistoryManager.shared.add(articles[currentIndex])
        checkReadingMilestone()
    
    }
    
//    private func checkReadingMilestone() {
//
//        let count = ReadingHistoryManager.shared.history.count
//
//        guard let milestone = ReadingMilestoneManager.shared.checkMilestone(
//            currentCount: count
//        ) else {
//            return
//        }
//
//        CelebrationManager.launch(in: view)
//        showMilestoneAlert(for: milestone)
//    }
    
    private func checkReadingMilestone() {

        let count = ReadingHistoryManager.shared.history.count

        print("Checking milestone:", count)

        if let milestone = ReadingMilestoneManager.shared.checkMilestone(currentCount: count) {

            CelebrationManager.launch(in: view)
            showMilestoneBanner(for: milestone)

        } else {

            print("No milestone")
        }
    }

//    private func showMilestoneAlert(for milestone: Int) {
//
//        let alert = UIAlertController(
//            title: "Milestone Reached!",
//            message: "You've read \(milestone) articles!",
//            preferredStyle: .alert
//        )
//
//        alert.addAction(UIAlertAction(title: "Continue", style: .default))
//
//        present(alert, animated: true)
//    }
    
    private func showMilestoneBanner(for milestone: Int) {

        let unlockView = MilestoneUnlockView()

        let title: String

        switch milestone {

        case 5:
            title = "Explorer"

        case 10:
            title = "Reader"

        case 15:
            title = "News Buff"

        case 20:
            title = "Dedicated Reader"

        case 25:
            title = "Avid Reader"

        case 50:
            title = "News Master"

        default:
            title = "Milestone"
        }

        unlockView.configure(
            title: title,
            subtitle: "You've read \(milestone) articles!"
        )

        view.addSubview(unlockView)

        unlockView.snp.makeConstraints {

            $0.center.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(40)
        }

        unlockView.playAnimation()
    }
    
    private func setPagingEnabled(_ enabled: Bool) {

        pagingEnabled = enabled

        print("Paging Enabled:", enabled)
    }
    
    private func updateBookmarkIcon() {
        
        guard !articles.isEmpty else { return }
        
        let article = articles[currentIndex]
        
        saveButton.setImage(UIImage(systemName: SavedManager.shared.isSaved(article) ? "bookmark.fill": "bookmark"), for: .normal)
    }
    
    private func saveButtonCenterInView() -> CGPoint {

        guard
            let navigationBar = navigationController?.navigationBar,
            let buttonSuperview = saveButton.superview
        else {
            return CGPoint(
                x: view.bounds.width - 30,
                y: 60
            )
        }

        return buttonSuperview.convert(
            saveButton.center,
            to: view
        )
    }
    
    private func toggleSaveCurrentArticle(at point: CGPoint? = nil, animated: Bool = true) {

        let article = articles[currentIndex]
        let isAlreadySaved = SavedManager.shared.isSaved(article)

        if isAlreadySaved {
            SavedManager.shared.remove(article)
            savedArticlesDelegate?.didRemoveSaveArticle(article)
        } else {
            SavedManager.shared.save(article)
            savedArticlesDelegate?.didSaveArticle(article)
        }

        if animated,
           let point = point {

            playReadingEffect(
                from: point,
                saved: !isAlreadySaved
            )

        } else {

            updateBookmarkIcon()
        }
    }
    
    private func playReadingEffect(from point: CGPoint, saved: Bool) {

        switch DoubleTapPreferenceManager.shared.selectedEffect {

        case .save:

            BookmarkAnimationManager.shared.play(
                in: view,
                from: point,
                to: saveButtonCenterInView(),
                saved: saved
            ) { [weak self] in
                self?.updateBookmarkIcon()
                self?.animateSaveButton()
            }

        case .confetti:

            CelebrationManager.launch(in: view)
            updateBookmarkIcon()

        case .hearts:

            HeartsManager.launch(in: view)
            updateBookmarkIcon()

        case .fireworks:

            SparklesManager.launch(in: view)
            updateBookmarkIcon()

        case .crax:

            CraxManager.launch(in: view)
            updateBookmarkIcon()
        }
    }
    
    
    private func animateSaveButton() {

        UIView.animate(
            withDuration: 0.15,
            animations: {

                self.saveButton.transform =
                    CGAffineTransform(scaleX: 1.35, y: 1.35)

            }) { _ in

                UIView.animate(withDuration: 0.15) {

                    self.saveButton.transform = .identity

                }
            }
    }
    
    @objc func didTapCelebrateButton() {
       
        CelebrationManager.launch(in: self.view)
//        CManager.launch(in: view)
    }
    
   
    @objc func didTapAdd() {
        toggleSaveCurrentArticle(animated: false)
    }
    
    @objc func didTapShare(){
        
        guard currentIndex < articles.count else { return }

            let article = articles[currentIndex]

            let text = """
            Check out this article:

            \(article.title ?? "")
            
            \(article.url ?? "")
            """
        
            let activityVC = UIActivityViewController(activityItems: [text], applicationActivities: nil)
            present(activityVC, animated: true)
    }
}

extension ArticlePageViewController: SaveArticlesDelegate {

    func didSaveArticle(_ article: Article) {
        
    }
    
    func didRemoveSaveArticle(_ article: Article) {
        
    }
}

extension ArticlePageViewController:  UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let currentViewController = viewController as? FullArticleViewController, let index = pages.firstIndex(of: currentViewController), index > 0 else {
            return nil
        }
        return pages[index - 1]
    }

//    
//    func pageViewController(
//        _ pageViewController: UIPageViewController,
//        viewControllerBefore viewController: UIViewController
//    ) -> UIViewController? {
//
//        guard pagingEnabled else {
//            return nil
//        }
//
//        guard
//            let currentViewController = viewController as? FullArticleViewController,
//            let index = pages.firstIndex(of: currentViewController),
//            index > 0
//        else {
//            return nil
//        }
//
//        return pages[index - 1]
//    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentViewController = viewController as? FullArticleViewController, let index = pages.firstIndex(of: currentViewController), index < (pages.count - 1) else {
            return nil
        }
        return pages[index + 1]
    }
//    
//    func pageViewController(
//        _ pageViewController: UIPageViewController,
//        viewControllerAfter viewController: UIViewController
//    ) -> UIViewController? {
//
//        guard pagingEnabled else {
//            return nil
//        }
//
//        guard
//            let currentViewController = viewController as? FullArticleViewController,
//            let index = pages.firstIndex(of: currentViewController),
//            index < pages.count - 1
//        else {
//            return nil
//        }
//
//        return pages[index + 1]
//    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {

        guard completed,
            let visibleVC = viewControllers?.first as? FullArticleViewController,
            let index = pages.firstIndex(of: visibleVC) else { return }

        currentIndex = index
        ReadingHistoryManager.shared.add(articles[currentIndex])
        checkReadingMilestone()
        updateBookmarkIcon()
    }
}

