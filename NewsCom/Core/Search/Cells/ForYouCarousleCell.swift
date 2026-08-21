//
//  ForYouCarousle.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 17/08/26.
//

import UIKit
import SnapKit

final class ForYouCarouselCell: UITableViewCell {

    static let identifier = "ForYouCarouselCell"

    private let sectionTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "For You"
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textColor = .label
        return label
    }()

    private let seeAllButton: UIButton = {
        let button = UIButton(type: .system)

        var configuration = UIButton.Configuration.plain()
        configuration.title = "See all  →"
        configuration.baseForegroundColor = .label
        configuration.contentInsets = .zero

        button.configuration = configuration

        return button
    }()

    private lazy var collectionView: UICollectionView = {

        let layout = createLayout()

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false

        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.register(ForYouArticleCell.self, forCellWithReuseIdentifier: ForYouArticleCell.identifier)

        return collectionView
    }()

    private var articles: [Article] = []

    private let recommendationReasons = ["Because you read Technology", "Based on your saved articles", "You often read Anime", "Trending in your interests"]

    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    private func setupUI() {

        selectionStyle = .none

        backgroundColor = ThemeManager.shared.currentTheme.colors.background

        contentView.backgroundColor = .clear

        contentView.addSubview(sectionTitleLabel)
        contentView.addSubview(seeAllButton)
        contentView.addSubview(collectionView)

        sectionTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.leading.equalToSuperview().inset(20)
        }

        seeAllButton.snp.makeConstraints { make in
            make.centerY.equalTo(sectionTitleLabel)
            make.trailing.equalToSuperview().inset(20)
        }

        collectionView.snp.makeConstraints { make in
            make.top.equalTo(sectionTitleLabel.snp.bottom).offset(14)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(8)
        }
    }

    private func createLayout() -> UICollectionViewCompositionalLayout {

        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))

        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(280), heightDimension: .fractionalHeight(1.0))

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)

        section.orthogonalScrollingBehavior = .groupPaging

        section.interGroupSpacing = 12

        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)

        return UICollectionViewCompositionalLayout(section: section)
    }

    func configure(with articles: [Article]) {

        self.articles = articles
        collectionView.reloadData()
    }
}

extension ForYouCarouselCell: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articles.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ForYouArticleCell.identifier, for: indexPath) as! ForYouArticleCell

        let article = articles[indexPath.item]

        let reason = recommendationReasons[indexPath.item % recommendationReasons.count]

        cell.configure(article: article, reason: reason)

        return cell
    }
}

extension ForYouCarouselCell: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
}
