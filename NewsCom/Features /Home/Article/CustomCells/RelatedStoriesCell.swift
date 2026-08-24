//
//  RelatedStoriesCell.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 18/05/26.
//

import UIKit
import SnapKit

class RelatedStoriesCell: UITableViewCell  {
    
    static let identifier = "RelatedStoriesCell"
    var collectionView: UICollectionView!
    weak var parentViewController: UIViewController?
    
    private var viewModel: RelatedStoriesViewModel?
    private var homeViewModel = HomeViewModel()
    
    private let titleLabel = UILabel()
    private let theme = ThemeManager.shared.currentTheme
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCollectionViews()
    }
    
    private func setupCollectionViews(){

        let layout = UICollectionViewFlowLayout()

        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 5
        layout.itemSize = CGSize(width: 280, height: 300)
        layout.estimatedItemSize = .zero
        
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false

        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView.register(BreakingNewsCollectionViewCell.self, forCellWithReuseIdentifier: BreakingNewsCollectionViewCell.identifier)

        contentView.addSubview(collectionView)
        
        contentView.addSubview(titleLabel)

        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.text = "Related Stories"

        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(25)
            make.leading.trailing.equalToSuperview().inset(20)
        }

        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func configure(viewModel: RelatedStoriesViewModel){
        
        contentView.backgroundColor = theme.colors.background
        
        self.viewModel = viewModel
        collectionView.reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension RelatedStoriesCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let viewModel,
              let article = viewModel.article(at: indexPath.item) else {
            return UICollectionViewCell()
        }

        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: BreakingNewsCollectionViewCell.identifier,
            for: indexPath
        ) as! BreakingNewsCollectionViewCell

        cell.configure(article: article)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 280, height: 300)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
//    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        
        guard let viewModel else { return }
        
        let vc = ArticlePageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        vc.hidesBottomBarWhenPushed = true
        vc.configure(with: viewModel.relatedArticles, startIndex: indexPath.item)
        
        parentViewController?.navigationController?.pushViewController(vc, animated: true)
        
    }
    
//    func collectionView(
//           _ collectionView: UICollectionView,
//           layout collectionViewLayout: UICollectionViewLayout,
//           minimumLineSpacingForSectionAt section: Int
//       ) -> CGFloat {
//           return 20   // Gap between cells
//       }
}
