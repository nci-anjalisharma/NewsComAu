//
//  DiscoverTopicCell.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 17/08/26.
//

import UIKit
import SnapKit

final class DiscoverTopicCell: UITableViewCell {

    static let identifier = "DiscoverTopicCell"

    private var collectionView: UICollectionView!
    
    var onAnimeTapped: (() -> Void)?
    
    var onTopicTapped: ((String) -> Void)?

    private var topics: [ExploreTopic] = [

        ExploreTopic(id: "anime", title: "Anime", imageName: "anime"),

        ExploreTopic(id: "technology", title: "Tech",imageName: "technology"),

        ExploreTopic(id: "world", title: "World", imageName: "world"),

        ExploreTopic(id: "disney", title: "Disney", imageName: "disney")
    ]
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
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

        let layout = createLayout()

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

        collectionView.backgroundColor = .clear

        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false

        collectionView.isScrollEnabled = false

        collectionView.register(TopicCollectionViewCell.self, forCellWithReuseIdentifier: TopicCollectionViewCell.identifier)

        collectionView.dataSource = self
        collectionView.delegate = self

        contentView.addSubview(collectionView)

        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(305)
        }
    }
}


private extension DiscoverTopicCell {

        func createLayout() -> UICollectionViewLayout {

            let spacing: CGFloat = 4

            let animeItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.64), heightDimension: .fractionalHeight(1.0)))

            animeItem.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)

            let technologyItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.36), heightDimension: .fractionalHeight(1.0)))

            technologyItem.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)

            let topGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(160)), subitems: [animeItem, technologyItem])

            let worldItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.36), heightDimension: .fractionalHeight(1.0)))
            
            worldItem.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)

            let disneyItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.64), heightDimension: .fractionalHeight(1.0)))

            disneyItem.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)

            let bottomGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(125)), subitems: [worldItem, disneyItem])

            let completeGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(285)), subitems: [topGroup, bottomGroup])

            let section = NSCollectionLayoutSection(group: completeGroup)

            section.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 10, bottom: 10, trailing: 10)

            return UICollectionViewCompositionalLayout(section: section)
    }
}

extension DiscoverTopicCell: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        topics.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopicCollectionViewCell.identifier, for: indexPath) as! TopicCollectionViewCell

        let topic = topics[indexPath.item]

        cell.configure(with: topic)

        return cell
    }
}

extension DiscoverTopicCell: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let topic = topics[indexPath.item]

        print("Selected topic:", topic.title)

        if topic.id == "anime" {
            onAnimeTapped?()
        } else {
            onTopicTapped?(topic.title)
        }
    }
}
