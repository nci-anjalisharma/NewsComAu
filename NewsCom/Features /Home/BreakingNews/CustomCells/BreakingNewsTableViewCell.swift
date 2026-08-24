
//
//  BreakingNewsTableViewCell.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 10/05/26.
//

import UIKit
import SnapKit

class BreakingNewsTableViewCell: UITableViewCell{
    
    static let identifier = "BreakingNewsTableViewCell"
        
    weak var parentViewController: UIViewController?
        
    private var collectionView: UICollectionView!
        
    private var item: [Article] = []
    
    // MARK: - Data Source

    private var freeNewsArticles: [FreeNewsListArticle] = []
    private var isShowingFreeNews = false
    
    var onFreeNewsArticleTapped: ((FreeNewsListArticle) -> Void)?
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCollectionView()
    }
    
        private func setupCollectionView() {
            
            let theme = ThemeManager.shared.currentTheme
            let layout = UICollectionViewFlowLayout()
            
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 8
            layout.itemSize = CGSize(width: 280, height: 300)
            layout.estimatedItemSize = .zero
            
            layout.sectionInset = UIEdgeInsets(top: 0,left: 8, bottom: 0, right: 16)

            collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            
            contentView.addSubview(collectionView)
            
            self.contentView.backgroundColor = theme.colors.background
            collectionView.backgroundColor = theme.colors.background
            
            collectionView.showsHorizontalScrollIndicator = false

            collectionView.delegate = self
            collectionView.dataSource = self

            collectionView.register(BreakingNewsCollectionViewCell.self, forCellWithReuseIdentifier: BreakingNewsCollectionViewCell.identifier)

            
//
//            collectionView.snp.makeConstraints { make in
////                make.edges.equalToSuperview()
//                make.top.equalToSuperview().offset(20)
//                make.leading.trailing.equalToSuperview().inset(20)
//                make.height.equalTo(300)
//            }
            
            collectionView.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(8)
                make.leading.trailing.equalToSuperview()
                make.height.equalTo(300)
            }
            
            
        }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.shadowPath = UIBezierPath(roundedRect: contentView.bounds, cornerRadius: 18).cgPath
    }

        func configure(item: [Article]) {
            
            self.item = item
//            print("Received articles: \(item.count)")
            
            freeNewsArticles = []
            isShowingFreeNews = false
            
            collectionView.reloadData()
        }
    
    // MARK: - Free News API Configuration

    func configure(item: [FreeNewsListArticle]) {

        self.freeNewsArticles = item
        self.item = []
        self.isShowingFreeNews = true

        collectionView.reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BreakingNewsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if isShowingFreeNews {
            return freeNewsArticles.count
        }

        return item.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: BreakingNewsCollectionViewCell.identifier,
            for: indexPath
        ) as! BreakingNewsCollectionViewCell

        if isShowingFreeNews {

            let article = freeNewsArticles[indexPath.item]

            cell.configure(freeNewsArticle: article)

        } else {

            let article = item[indexPath.item]

            cell.configure(
                article: article
            )
        }

        return cell
    }

    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {

        if isShowingFreeNews {

            let article = freeNewsArticles[indexPath.item]

            onFreeNewsArticleTapped?(article)

            return
        }

        let vc = ArticlePageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal
        )

        vc.configure(
            with: item,
            startIndex: indexPath.item
        )

        vc.hidesBottomBarWhenPushed = true

        parentViewController?.navigationController?.pushViewController(
            vc,
            animated: true
        )
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        CGSize(width: 280, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
           return 2   // Gap between cells
       }
}

