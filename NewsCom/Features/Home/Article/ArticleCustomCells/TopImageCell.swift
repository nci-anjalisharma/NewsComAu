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
        
        gradientView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(150)
        }
        
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.black.withAlphaComponent(0.3).cgColor,
            UIColor.black.cgColor
        ]
        gradientLayer.locations = [0.0, 0.6, 1.0]
        
        gradientLayer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 140)
    }
    
    func configure(imageName: String){
        articleImageView.image = UIImage(named: imageName)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
