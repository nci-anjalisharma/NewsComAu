//
//  ForYouArticleCell.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 17/08/26.
//

import UIKit
import SnapKit

final class ForYouArticleCell: UICollectionViewCell {

    static let identifier = "ForYouArticleCell"

    private let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView()

        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true

        return imageView
    }()

    private let reasonLabel: UILabel = {
        let label = UILabel()

        label.font = .systemFont(ofSize: 15, weight: .medium)

        label.textColor = .secondaryLabel
        label.numberOfLines = 1

        return label
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()

        label.font = .systemFont(ofSize: 24, weight: .medium)

        label.textColor = .label
        label.numberOfLines = 3

        return label
    }()

    private let readTimeLabel: UILabel = {
        let label = UILabel()

        label.font = .systemFont(ofSize: 15, weight: .medium)

        label.textColor = .secondaryLabel

        return label
    }()

    private let bookmarkButton: UIButton = {
        let button = UIButton(type: .system)

        let image = UIImage(systemName: "bookmark")

        button.setImage(image, for: .normal)

        button.tintColor = .label

        button.backgroundColor = UIColor.secondarySystemBackground

        button.layer.cornerRadius = 20

        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    private func setupUI() {

        contentView.backgroundColor = .clear

        contentView.addSubview(cardView)

        cardView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        cardView.addSubview(imageView)
        cardView.addSubview(reasonLabel)
        cardView.addSubview(titleLabel)
        cardView.addSubview(readTimeLabel)
        cardView.addSubview(bookmarkButton)

        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(235)
        }

        reasonLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(reasonLabel.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(20)
        }

        readTimeLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(20)
        }

        bookmarkButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(14)
            make.width.height.equalTo(40)
        }
    }

    func configure(article: Article, reason: String) {

        reasonLabel.text = reason
        titleLabel.text = article.title

        readTimeLabel.text = "6 min read"

        imageView.image = UIImage(systemName: "photo")
        imageView.tintColor = .secondaryLabel
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        imageView.image = nil
        titleLabel.text = nil
        reasonLabel.text = nil
        readTimeLabel.text = nil
    }
}
