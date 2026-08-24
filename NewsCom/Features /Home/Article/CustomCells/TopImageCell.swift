//
//  TopImageCell.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 14/05/26.
//


import UIKit
import SnapKit


class TopImageCell: UITableViewCell {
    
    
    static let identifier = "TopImageCell"

    private let articleImageView = UIImageView()
    
    private let gradientView = UIView()
    private let gradientLayer = CAGradientLayer()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        
    }
    
    private func setupUI() {
        
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(articleImageView)
        contentView.addSubview(gradientView)
        
        articleImageView.image = UIImage(named: "news6")
        articleImageView.contentMode = .scaleAspectFill
        articleImageView.clipsToBounds = true
        articleImageView.layer.cornerRadius = 0
        
        articleImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(500)
        }
        
//        gradientView.snp.makeConstraints { make in
//            make.leading.trailing.bottom.equalToSuperview()
//            make.height.equalTo(150)
//        }
//        
//        gradientLayer.colors = [
//            theme.colors.primary.withAlphaComponent(0).cgColor,
//            theme.colors.secondary.withAlphaComponent(0.3).cgColor,
//            UIColor.white.cgColor
//        ]
//        gradientLayer.locations = [0.0, 0.6, 1.0]
//        gradientView.layer.addSublayer(gradientLayer)
        
    }
    
    override func layoutSubviews() {
            super.layoutSubviews()
            gradientLayer.frame = gradientView.bounds
        }
    
    func configure(imageName: String){
        let theme = ThemeManager.shared.currentTheme
        contentView.backgroundColor = theme.colors.background
        
        loadImage(from: imageName)
    }
    
    private func loadImage(from urlString: String) {

        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in

            guard let data = data else { return }

            DispatchQueue.main.async {
                self?.articleImageView.image = UIImage(data: data)
            }

        }.resume()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
