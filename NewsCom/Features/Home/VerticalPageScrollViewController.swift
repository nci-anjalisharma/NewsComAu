








import UIKit
import SnapKit


class VerticalPageScrollViewController: UIViewController {
    var onReadMorePressed: (() -> Void)?
    
    
    
    
    
    
    
    let headlineLabel = UILabel()
    let pageControllerImageView = UIImageView()
    private let readMoreButton = UIButton(type: .system)
    
    var latestNewsArticles: [Article] = []
    
    init(headline: String, color: UIColor) {
        super.init(nibName: nil, bundle: nil)
        
        headlineLabel.text = headline
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        
        
        setupUI()
        setupDummyData()
        
        
        
        
    }

    private func setupUI() {
        
        headlineLabel.font = .systemFont(ofSize: 24, weight: .bold)
        headlineLabel.textColor = .white
        headlineLabel.numberOfLines = 0
        
        readMoreButton.setTitle("Tap to read more", for: .normal)
        readMoreButton.backgroundColor = .white.withAlphaComponent(0.2)
        readMoreButton.setTitleColor(.white, for: .normal)
        readMoreButton.layer.cornerRadius = 5
        readMoreButton.addTarget(self, action: #selector(btnTapped), for: .touchUpInside)

       
        view.addSubview(pageControllerImageView)
        view.addSubview(headlineLabel)
        view.addSubview(readMoreButton)
        
        headlineLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(40)
            make.leading.trailing.equalToSuperview().inset(30)
        }

        readMoreButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(250)
            make.height.equalTo(50)
        }
        
        
        pageControllerImageView.contentMode = .scaleAspectFill
        pageControllerImageView.clipsToBounds = true
        
        
        
        pageControllerImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        
        
    }
    
    
    func setupDummyData() {
        
        latestNewsArticles = [
            
            Article(
                title: "Apple sold for 5000. Nutritionists Concerned",
                author: "Apple Man",
                imageURL: "news13",
                description: "Increase rise in the trend of Excotic fruits like Kiwi and Dragon fruit has left apples in grave danger"),
            
            Article(
                title: "Sports",
                author: "ESPN",
                imageURL: "news12",
                description: "Chelsea secure dramatic win in final minutes after intense second half"),
            
            Article(
                title: "Politics",
                author: "BBC",
                imageURL: "news9",
                description: "Global leaders gather for climate summit discussions in Geneva")
    ]
        
    }
    
    func configure(article: Article) {
        headlineLabel.text = article.description
        pageControllerImageView.image = UIImage(named: article.imageURL)
        
    }
    
    

    @objc func btnTapped() { onReadMorePressed?() }
    
    required init?(coder: NSCoder) { fatalError() }
}
