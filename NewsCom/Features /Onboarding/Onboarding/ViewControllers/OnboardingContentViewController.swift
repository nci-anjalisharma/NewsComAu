


import UIKit
import SnapKit

class OnboardingContentViewController: UIViewController {

    private let item: OnboardingItem
    
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()

    private let gradientView = UIView()
    private let gradientLayer = CAGradientLayer()

    init(item: OnboardingItem) {
        self.item = item
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad(){
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {

        view.backgroundColor = .black

        imageView.image = UIImage(named: item.imageName)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true

        titleLabel.text = item.title
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(
            ofSize: 40,
            weight: .bold
        )

        subtitleLabel.text = item.subtitle
        subtitleLabel.textColor = .white
        subtitleLabel.numberOfLines = 0
        subtitleLabel.font = .systemFont(ofSize: 18)

        view.addSubview(imageView)
        view.addSubview(gradientView)
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)

        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        gradientView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(24)
            $0.bottom.equalTo(subtitleLabel.snp.top).offset(-16)
        }

        subtitleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-220)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        gradientLayer.frame = gradientView.bounds

        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.black.withAlphaComponent(0.7).cgColor
        ]

        gradientLayer.locations = [0.4, 1.0]

        if gradientLayer.superlayer == nil {
            gradientView.layer.addSublayer(gradientLayer)
        }
    }
    
}
