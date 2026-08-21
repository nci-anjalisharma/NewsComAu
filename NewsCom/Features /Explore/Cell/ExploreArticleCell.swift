//
//  ExploreArticleCell.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 13/07/26.
//

import UIKit
import SnapKit

final class ExploreArticleCell: UICollectionViewCell {

    static let identifier = "ExploreArticleCell"
    
    var onReadMore: (() -> Void)?
    var onBookmark: (() -> Void)?
    var onShare: (() -> Void)?

    private let imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 28
        return image
    }()

    private let gradientView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()

    private let contentCard: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.92)
        view.layer.cornerRadius = 24
        return view
    }()

    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .systemBlue
        return label
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 28)
        label.numberOfLines = 3
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        label.numberOfLines = 4
        label.textColor = .secondaryLabel
        return label
    }()

    let readMoreButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Read More", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        return button
    }()

    let bookmarkButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "bookmark"), for: .normal)
        return button
    }()

    let shareButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        addGradient()
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        imageView.image = nil
        categoryLabel.text = nil
        titleLabel.text = nil
        descriptionLabel.text = nil
    }
}

private extension ExploreArticleCell {

    func setupViews() {

        backgroundColor = .clear
        contentView.backgroundColor = .clear

        contentView.addSubview(imageView)
        imageView.addSubview(gradientView)

        contentView.addSubview(contentCard)

        contentCard.addSubview(categoryLabel)
        contentCard.addSubview(titleLabel)
        contentCard.addSubview(descriptionLabel)

        contentCard.addSubview(readMoreButton)
        contentCard.addSubview(bookmarkButton)
        contentCard.addSubview(shareButton)
        
        readMoreButton.addTarget(self, action: #selector(readMoreTapped), for: .touchUpInside)

        bookmarkButton.addTarget(self, action: #selector(bookmarkTapped), for: .touchUpInside)

        shareButton.addTarget(self, action: #selector(shareTapped), for: .touchUpInside)
    }
}

private extension ExploreArticleCell {

    @objc func readMoreTapped() {
        onReadMore?()
    }

    @objc func bookmarkTapped() {
        onBookmark?()
    }

    @objc func shareTapped() {
        onShare?()
    }
}

private extension ExploreArticleCell {

    func setupConstraints() {

        imageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalToSuperview().multipliedBy(0.52)
        }

        gradientView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        contentCard.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(-24)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().offset(-90)
        }

        categoryLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(20)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(categoryLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalTo(titleLabel)
        }

        readMoreButton.snp.makeConstraints {
            $0.leading.equalTo(titleLabel)
            $0.bottom.equalToSuperview().offset(-20)
        }

        shareButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-20)
            $0.centerY.equalTo(readMoreButton)
        }

        bookmarkButton.snp.makeConstraints {
            $0.trailing.equalTo(shareButton.snp.leading).offset(-18)
            $0.centerY.equalTo(readMoreButton)
        }
    }
}

private extension ExploreArticleCell {

    func addGradient() {

        gradientView.layer.sublayers?.removeAll()

        let gradient = CAGradientLayer()

        gradient.frame = gradientView.bounds
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.withAlphaComponent(0.7).cgColor]
        gradient.locations = [0.4, 1.0]

        gradientView.layer.addSublayer(gradient)
    }
}

extension ExploreArticleCell {

    func configure(with article: Article) {
        
        let theme = ThemeManager.shared.currentTheme

        titleLabel.text = article.title
        descriptionLabel.text = article.description
        categoryLabel.text = article.source?.name ?? "News"
        
        titleLabel.textColor = theme.colors.primary
        descriptionLabel.textColor = theme.colors.textColor
        categoryLabel.textColor = theme.colors.secondary
        
        readMoreButton.tintColor = theme.colors.secondary
        shareButton.tintColor = theme.colors.secondary
        bookmarkButton.tintColor = theme.colors.secondary
        

        if let imageURL = article.urlToImage {
            imageView.loadImage(from: imageURL)
        } else {
            imageView.image = UIImage(named: "sunflowers 1")
        }
        
        let saved = SavedManager.shared.isSaved(article)

        bookmarkButton.setImage(UIImage(systemName: saved ? "bookmark.fill" : "bookmark"), for: .normal)
    }
}
