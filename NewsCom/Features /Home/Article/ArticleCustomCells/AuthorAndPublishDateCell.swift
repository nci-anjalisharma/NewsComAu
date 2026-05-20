//
//  AuthorAndPublishDateCell.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 14/05/26.
//


import UIKit
import SnapKit

class AuthorAndPublishDateCell: UITableViewCell {
    
    static let identifier = "AuthorAndPublishDateCell"
    
    private let techStackView = UIStackView()
    private let authorImageView = UIImageView()
    private let authorNameLabel = UILabel()
    private let publishDateLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    private func setupUI(){
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(authorImageView)
        authorImageView.image = UIImage(systemName: "person.crop.circle")
        authorImageView.contentMode = .scaleAspectFill
        authorImageView.tintColor = .gray
        authorImageView.clipsToBounds = true
        authorImageView.layer.cornerRadius = 20
        
        authorImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.bottom.equalToSuperview().inset(16)
            make.width.height.equalTo(40)
            
        }
        
        contentView.addSubview(techStackView)
        
        techStackView.axis = .vertical
        techStackView.spacing = 5
        techStackView.backgroundColor = .clear
        techStackView.alignment = .leading
    
        techStackView.addArrangedSubview(authorNameLabel)
        techStackView.addArrangedSubview(publishDateLabel)
        
        techStackView.snp.makeConstraints{ make in
            make.centerY.equalTo(authorImageView)
            make.leading.equalTo(authorImageView.snp.trailing).offset(12)
            make.trailing.equalToSuperview().inset(20)
        }
        
        authorNameLabel.text = "Aman Verma"
        authorNameLabel.textColor = .black
        authorNameLabel.font = .systemFont(ofSize: 16, weight: .bold)
        
        publishDateLabel.text = "10th Oct, 2020"
        publishDateLabel.textColor = .lightGray
        publishDateLabel.font = .systemFont(ofSize: 14, weight: .regular)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
