//
//  TopicCollectionViewCell.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 17/08/26.
//

import UIKit
import SnapKit

final class TopicCollectionViewCell: UICollectionViewCell {

    static let identifier = "TopicCollectionViewCell"

    private let imageView = UIImageView()
    private let titleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    private func setupUI() {

        let theme = ThemeManager.shared.currentTheme

        backgroundColor = .clear
        contentView.backgroundColor = theme.colors.secondary

        contentView.layer.cornerRadius = 20
        contentView.clipsToBounds = true

        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true

        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)

        titleLabel.textColor = .white
        titleLabel.numberOfLines = 2

        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)

        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-16)
        }
    }

    func configure(with topic: ExploreTopic) {

        titleLabel.text = topic.title

        imageView.image = UIImage(named: topic.imageName)
    }
}
