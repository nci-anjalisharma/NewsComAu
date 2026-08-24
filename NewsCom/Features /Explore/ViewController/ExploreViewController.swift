//
//  Quiz.ViewController.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 14/04/26.
//
import UIKit
internal import MetalKit
import SnapKit

final class ExploreViewController: UIViewController {

    private let viewModel = ExploreViewModel()

    private lazy var collectionView: UICollectionView = {

        let layout = UICollectionViewFlowLayout()

        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.decelerationRate = .fast

        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView.register(ExploreArticleCell.self, forCellWithReuseIdentifier: ExploreArticleCell.identifier)

        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Explore"

        setupShader()
        setupCollectionView()

        viewModel.fetchExploreData { [weak self] in
            self?.collectionView.reloadData()
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(themeChanged), name: .themeChanged, object: nil)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    @objc private func themeChanged() {

        collectionView.reloadData()

        setNeedsStatusBarAppearanceUpdate()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

private extension ExploreViewController {

    func setupShader() {

        let shader = MetalBackgroundView(frame: view.bounds)

        shader.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(shader)
    }
}

private extension ExploreViewController {

    func setupCollectionView() {

        view.addSubview(collectionView)

        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension ExploreViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        viewModel.numberOfArticles
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExploreArticleCell.identifier, for: indexPath) as! ExploreArticleCell

        guard let article = viewModel.article(at: indexPath.item) else {
            return UICollectionViewCell()
        }

        cell.configure(with: article)
        
        cell.onReadMore = { [weak self] in

            guard let self else { return }

            guard let article = self.viewModel.article(at: indexPath.item) else {
                return
            }

            let vc = FullArticleViewController()
            vc.configure(article: article, relatedStoriesArticle: self.viewModel.articles)
            
            vc.hidesBottomBarWhenPushed = true

            self.navigationController?.pushViewController(vc, animated: true)
        }

        cell.onShare = { [weak self] in

            guard
                let self,
                let article = self.viewModel.article(at: indexPath.item)
            else { return }

            let activityVC = UIActivityViewController(activityItems: [article.url ?? ""], applicationActivities: nil)

            self.present(activityVC, animated: true)
        }
        
        cell.onBookmark = { [weak self, weak cell] in

            guard
                let self,
                let cell,
                let article = self.viewModel.article(at: indexPath.item)
            else { return }

            if SavedManager.shared.isSaved(article) {

                SavedManager.shared.remove(article)
                cell.bookmarkButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
                
            } else {

                SavedManager.shared.save(article)
                
                cell.bookmarkButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
            }
        }
        return cell
    }
}

extension ExploreViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        collectionView.bounds.size
    }
}

extension ExploreViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

        cell.alpha = 0
        cell.transform = CGAffineTransform(scaleX: 0.96, y: 0.96)

        UIView.animate(withDuration: 0.35) {
            cell.alpha = 1
            cell.transform = .identity
        }
    }
}
