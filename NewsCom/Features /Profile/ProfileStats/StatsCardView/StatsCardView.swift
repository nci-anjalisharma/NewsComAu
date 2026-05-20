//
//  ST.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 08/05/26.
//

import UIKit
import SnapKit


class StatsCardView: UIView {
    
    let countLabel = UILabel()
    let titleLabel = UILabel()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setupUI()
        
    }
    
    private func setupUI(){
        
        backgroundColor = .lightGray.withAlphaComponent(0.1)
        layer.cornerRadius = 10
        
        countLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        countLabel.textAlignment = .center
        countLabel.textColor = UIColor(named: "BlueSet")
        
        
        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .gray
        titleLabel.numberOfLines = 2
        
        addSubview(countLabel)
        addSubview(titleLabel)
        
        countLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.leading.trailing.equalToSuperview().inset(8)
            
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(countLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(8)
        }
    }
    
    func configure(count: String, title: String){
        countLabel.text = count
        titleLabel.text = title
    }
    
    required init?(coder: NSCoder){
        fatalError("init(coder: has not been implemented")
    }
}
