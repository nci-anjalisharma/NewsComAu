//
//  SwipeForNextCell.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 15/05/26.
//

import UIKit
import SnapKit

class SwipeForNextCell: UITableViewCell {
    
    static let identifier = "SwipeForNextCell"
    
    private let swipeArrowImageView = UIImageView()
    private let swipeLabel = UILabel()
    private let nextTitleLabel = UILabel()
    
    private let arrowStack = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    private func setupUI(){
        let theme = ThemeManager.shared.currentTheme
        
        arrowStack.axis = .horizontal
        arrowStack.alignment = .center
        arrowStack.spacing = -8

        for _ in 0..<2 {
            let arrow = UIImageView(image: UIImage(systemName: "chevron.right"))
            arrow.tintColor = theme.colors.primary
            arrow.contentMode = .scaleAspectFit
            arrow.snp.makeConstraints {
                $0.width.height.equalTo(18)
            }
            arrowStack.addArrangedSubview(arrow)
        }
        
        backgroundColor = theme.colors.background
        contentView.backgroundColor = .clear
        selectionStyle = .none
        
//        swipeArrowImageView.image = UIImage(systemName: "chevron.up")
//        
//        swipeArrowImageView.tintColor = theme.colors.primary
//        swipeArrowImageView.contentMode = .scaleAspectFit
        
        contentView.addSubview(arrowStack)

        arrowStack.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(45)
            make.centerX.equalToSuperview()
        }
        
        swipeLabel.text = "SWIPE FOR NEXT ARTICLE"
        swipeLabel.textColor = theme.colors.secondary
        swipeLabel.font = .systemFont(ofSize: 12, weight: .bold)
        
//        swipeLabel.textAlignment = .center
        
        //        nextTitleLabel.text = "Next: The Rise of Sustainable Architecture in Urban Centers"
        
        nextTitleLabel.textColor = .gray.withAlphaComponent(0.5)
        
        nextTitleLabel.font = .systemFont(ofSize: 15)
        
        nextTitleLabel.numberOfLines = 2
        nextTitleLabel.textAlignment = .center
        
        contentView.addSubview(swipeArrowImageView)
        contentView.addSubview(swipeLabel)
        contentView.addSubview(nextTitleLabel)
        
//        swipeArrowImageView.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(24)
//            make.centerX.equalToSuperview()
//            make.width.height.equalTo(22)
//        }
//        
        startArrowAnimation()
        
        swipeLabel.textAlignment = .center

        swipeLabel.snp.makeConstraints { make in
            make.top.equalTo(arrowStack.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        nextTitleLabel.textAlignment = .center
        nextTitleLabel.numberOfLines = 2

        nextTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(swipeLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(32)
            make.bottom.lessThanOrEqualToSuperview().inset(24)
        }
    }
        
    private func startArrowAnimation() {

        let animation = CABasicAnimation(keyPath: "transform.translation.y")
        animation.fromValue = 0
        animation.toValue = -6
        animation.duration = 0.7
        animation.autoreverses = true
        animation.repeatCount = .infinity
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)

        arrowStack.layer.add(animation, forKey: "bounce")
    }
    
    func configure(nextHeadline: String) {
        nextTitleLabel.text = "Next: \(nextHeadline)"
    }

    required init?(coder: NSCoder){
        fatalError()
    }
}
