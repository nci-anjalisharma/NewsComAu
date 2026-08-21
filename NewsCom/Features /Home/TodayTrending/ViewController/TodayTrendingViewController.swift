








import UIKit
import SnapKit


class TodayTrendingViewController: UIViewController {
    
    private let containerCardView = UIView()
    private let backgroundImageView = UIImageView()
    private let gradientView = UIView()
    private let gradientLayer = CAGradientLayer()
    
    private let headlineLabel = UILabel()
//    private let topicLabel = UILabel()
//    private let timePublished = UILabel()
    private let categoryLabel = PaddingLabel()
    
//    private let topicLabel = PaddingLabel()
    
    private var article: Article?
    var onTap: ((Article) -> Void)?
    
    @objc private func didTapArticle() {

        guard let article else { return }

        onTap?(article)
    }
        
    init(){
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .clear
        containerCardView.backgroundColor = .clear
        setupUI()
    }
        
//        NotificationCenter.default.addObserver(self, selector: #selector(themeChanged), name: .themeChanged, object: nil)
//    }
    
//    @objc private func themeChanged() {
//        applyTheme()
//    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        gradientLayer.frame = gradientView.bounds
        
    }

    private func setupUI() {
        view.addSubview(containerCardView)
    
        containerCardView.addSubview(backgroundImageView)
        containerCardView.addSubview(gradientView)
//        containerCardView.addSubview(topicLabel)
        containerCardView.addSubview(headlineLabel)
//        containerCardView.addSubview(timePublished)
        containerCardView.addSubview(categoryLabel)
        
        gradientView.layer.addSublayer(gradientLayer)
        
        containerCardView.layer.cornerRadius = 28
        containerCardView.clipsToBounds = true
        

        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true
        backgroundImageView.addImagePlaceholder()
//        containerCardView.addSubview(backgroundImageView)
        
        gradientLayer.locations = [0.0, 0.55, 1.0]
        gradientView.layer.cornerRadius = 28
//        containerCardView.addSubview(gradientView)

//        topicLabel.font = .systemFont(ofSize: 12, weight: .semibold)
//        
//        topicLabel.textAlignment = .center
//        topicLabel.layer.cornerRadius = 17
//        topicLabel.clipsToBounds = true
//        topicLabel.layoutMargins = .init(top: 0, left: 14, bottom: 0, right: 14)
//        containerCardView.addSubview(topicLabel)
        
        categoryLabel.layer.cornerRadius = 17
        categoryLabel.clipsToBounds = true

        headlineLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        headlineLabel.numberOfLines = 2
    
        headlineLabel.textAlignment = .left
//        containerCardView.addSubview(headlineLabel)
        
        headlineLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
//        topicLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
//        timePublished.font = .systemFont(ofSize: 12, weight: .semibold)
//        timePublished.textColor = .white
//        timePublished.textAlignment = .center
        
        categoryLabel.font = .systemFont(ofSize: 14, weight: .bold)
        categoryLabel.textColor = .white
        categoryLabel.textAlignment = .center
        
//        topicLabel.snp.remakeConstraints { make in
//            make.leading.equalToSuperview().offset(24)
//            make.bottom.equalTo(headlineLabel.snp.top).offset(-18)
//            make.height.equalTo(34)
//        }
        
        headlineLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
//            make.bottom.equalTo(timePublished.snp.top).offset(-16)
            make.bottom.equalToSuperview().offset(-20)
        }

        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        containerCardView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
//        gradientView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
        
//        containerCardView.addSubview(timePublished)
//        containerCardView.addSubview(categoryLabel)
        
        headlineLabel.applyTextShadow()
//        topicLabel.applyTextShadow()
        
//        timePublished.applyTextShadow()
        categoryLabel.applyTextShadow()
        
//        timePublished.applyTextShadow()
//        categoryLabel.applyTextShadow()
        
//        timePublished.snp.makeConstraints { make in
////            make.leading.equalTo(headlineLabel)
////            make.bottom.equalToSuperview().inset(24)
//            
//            make.leading.equalTo(categoryLabel.snp.trailing).offset(12)
//            make.centerY.equalTo(categoryLabel)
//        }

        categoryLabel.snp.makeConstraints { make in
//            make.leading.equalTo(timePublished.snp.trailing).offset(12)
//            make.centerY.equalTo(timePublished)
            
            make.leading.equalTo(headlineLabel).offset(-5)
            make.bottom.equalTo(headlineLabel.snp.top).offset(-12)
        }
        
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.black.withAlphaComponent(0.25).cgColor,
            UIColor.black.withAlphaComponent(0.95).cgColor
        ]
        
        gradientLayer.locations = [0, 0.55, 1]

        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapArticle))
        
        view.addGestureRecognizer(tap)
    }
    
    private func formattedDate(from isoDate: String) -> String {
        let formatter = ISO8601DateFormatter()

        guard let date = formatter.date(from: isoDate) else {
            return isoDate
        }

        let output = DateFormatter()
        output.dateFormat = "dd MMM • h:mm a"

        return output.string(from: date)
    }

    func configure(article: Article) {

        self.article = article

        let theme = ThemeManager.shared.currentTheme

        if let sourceName = article.source?.name {
            categoryLabel.text = sourceName
        } else {
            categoryLabel.text = "Unknown"
        }
        
        headlineLabel.text = article.title
//        timePublished.text = formattedDate(from: article.publishedAt ?? " ")

        backgroundImageView.loadImage(from: article.urlToImage ?? "")

//        view.backgroundColor = theme.colors.background
        
        view.backgroundColor = .clear

        categoryLabel.backgroundColor = theme.colors.secondary.withAlphaComponent(0.9)
        categoryLabel.textColor = .white

        
        headlineLabel.textColor = .white

      
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
