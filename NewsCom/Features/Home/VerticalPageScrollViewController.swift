








import UIKit
import SnapKit


class VerticalPageScrollViewController: UIViewController {
    var onReadMorePressed: (() -> Void)?
    
    private let headlineLabel = UILabel()
    private let readMoreButton = UIButton(type: .system)

    init(headline: String, color: UIColor) {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = color
        headlineLabel.text = headline
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        headlineLabel.font = .systemFont(ofSize: 34, weight: .bold)
        headlineLabel.textColor = .white
        headlineLabel.numberOfLines = 0
        
        readMoreButton.setTitle("Tap to read more", for: .normal)
        readMoreButton.backgroundColor = .white.withAlphaComponent(0.2)
        readMoreButton.setTitleColor(.white, for: .normal)
        readMoreButton.layer.cornerRadius = 5
        readMoreButton.addTarget(self, action: #selector(btnTapped), for: .touchUpInside)

        view.addSubview(headlineLabel)
        view.addSubview(readMoreButton)

        headlineLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(30)
        }

        readMoreButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-40)
            make.centerX.equalToSuperview()
            make.width.equalTo(250)
            make.height.equalTo(50)
        }
    }

    @objc func btnTapped() { onReadMorePressed?() }
    
    required init?(coder: NSCoder) { fatalError() }
}
