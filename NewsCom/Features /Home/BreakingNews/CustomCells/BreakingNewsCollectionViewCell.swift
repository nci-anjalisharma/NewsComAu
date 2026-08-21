//
//  BreakingNewsCollectionViewCell.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 10/05/26.
//

import UIKit
import SnapKit


class BreakingNewsCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "BreakingNewsCollectionViewCell"

    private let breakingNewsImage = UIImageView()
    private let titleLabel = UILabel()
    private let breakingHeadLine = UILabel()
    
    private let shadowView = UIView()
    private let cardView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addShadow()
        setupUI()
        
//
//        layer.shadowColor = UIColor.black.cgColor
//            layer.shadowOpacity = 0.12
//            layer.shadowRadius = 12
//            layer.shadowOffset = CGSize(width: 0, height: 6)
//            layer.masksToBounds = false
//
//            contentView.layer.cornerRadius = 18
//            contentView.layer.masksToBounds = true
//        
    }
    
    private func addShadow(){
        contentView.addSubview(shadowView)

        shadowView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }

        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOpacity = 0.2
        shadowView.layer.shadowRadius = 16
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 8)
        shadowView.layer.masksToBounds = false

        shadowView.addSubview(cardView)

        cardView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        cardView.layer.cornerRadius = 16
        cardView.clipsToBounds = true
    }

    private func setupUI() {
        
        cardView.addSubview(breakingNewsImage)
        cardView.addSubview(titleLabel)
        cardView.addSubview(breakingHeadLine)
        
        breakingNewsImage.addImagePlaceholder()
        
//        contentView.layer.cornerRadius = 16
//        contentView.clipsToBounds = true
        
        breakingHeadLine.clipsToBounds = true
        
        breakingNewsImage.contentMode = .scaleAspectFill
        breakingNewsImage.clipsToBounds = true
        
        titleLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        
        titleLabel.numberOfLines = 2
        
        breakingHeadLine.font = .systemFont(ofSize: 16, weight: .semibold)
      
        breakingHeadLine.numberOfLines = 0
//        
//        contentView.addSubview(breakingHeadLine)
//        contentView.addSubview(breakingNewsImage)
//        contentView.addSubview(titleLabel)
//        
        breakingHeadLine.setContentHuggingPriority(.defaultLow, for: .vertical)
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        breakingNewsImage.snp.makeConstraints { make in

            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(180)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(breakingNewsImage.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview().inset(10)
            make.height.greaterThanOrEqualTo(20)
        }
        
        breakingHeadLine.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview().inset(10)
            make.bottom.equalToSuperview()
        }
        
        breakingHeadLine.setContentHuggingPriority(.defaultLow, for: .vertical)
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }

    func configure(article: Article) {
        
        let theme = ThemeManager.shared.currentTheme
        
        cardView.backgroundColor = theme.colors.secondary.withAlphaComponent(0.1)

        titleLabel.textColor = theme.colors.secondary

        titleLabel.text = article.source?.name ?? "News"
        breakingHeadLine.textColor = theme.colors.primary
        breakingHeadLine.text = article.title ?? ""

        breakingNewsImage.loadImage(from: article.urlToImage ?? "")
    }
    
    func configure(freeNewsArticle: FreeNewsListArticle) {

        let theme = ThemeManager.shared.currentTheme

        cardView.backgroundColor =
            theme.colors.secondary.withAlphaComponent(0.1)

        titleLabel.textColor = theme.colors.secondary
        titleLabel.text = freeNewsArticle.publisher

        breakingHeadLine.textColor = theme.colors.primary
        breakingHeadLine.text = freeNewsArticle.title

        // Show placeholder while the detail request is loading
        breakingNewsImage.showPlaceholder()

        FreeNewsAPIManager.shared.fetchArticleDetails(
            uuid: freeNewsArticle.uuid
        ) { [weak self] result in

            guard let self else { return }

            DispatchQueue.main.async {
                switch result {

                case .success(let response):

                    if let thumbnail = response.data.thumbnail,
                       !thumbnail.isEmpty {

                        self.breakingNewsImage.loadImage(
                            from: thumbnail
                        )
                    }

                case .failure:
                    self.breakingNewsImage.showPlaceholder()
                }
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

        breakingNewsImage.showPlaceholder()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
