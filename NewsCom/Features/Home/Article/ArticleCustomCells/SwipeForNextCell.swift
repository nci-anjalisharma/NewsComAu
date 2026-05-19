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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    private func setupUI(){
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        selectionStyle = .none

        swipeArrowImageView.image = UIImage(systemName: "chevron.up")

        swipeArrowImageView.tintColor = .black
        swipeArrowImageView.contentMode = .scaleAspectFit

        swipeLabel.text = "SWIPE FOR NEXT ARTICLE"
        swipeLabel.textColor = .lightGray
        swipeLabel.font = .systemFont(ofSize: 12, weight: .bold)

        swipeLabel.textAlignment = .center

        nextTitleLabel.text = "Next: The Rise of Sustainable Architecture in Urban Centers"

        nextTitleLabel.textColor = .gray.withAlphaComponent(0.5)

        nextTitleLabel.font = .systemFont(ofSize: 15)

        nextTitleLabel.numberOfLines = 2
        nextTitleLabel.textAlignment = .center

        contentView.addSubview(swipeArrowImageView)
        contentView.addSubview(swipeLabel)
        contentView.addSubview(nextTitleLabel)

        swipeArrowImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(22)
        }

        swipeLabel.snp.makeConstraints { make in
            make.top.equalTo(swipeArrowImageView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(20)
        }

        nextTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(swipeLabel.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(30)
            make.bottom.equalToSuperview().inset(150)
            }
        }

    required init?(coder: NSCoder){
        fatalError()
    }
}
