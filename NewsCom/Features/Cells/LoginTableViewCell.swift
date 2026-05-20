//
//  LoginTableViewCell.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 07/05/26.
//

import UIKit
import SnapKit

class LoginTableViewCell: UITableViewCell {
    
    
    private lazy var myButton:UIButton = {
        let button = UIButton()
        if RootNavigationService.isUserLoggedIn == true {
            button.setTitle("LOG OUT", for: .normal)
        } else {
            button.setTitle("LOGIN", for: .normal)
        }
        button.setTitleColor(UIColor(named: "loginRed"), for: .normal)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 16
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor(named: "loginRed")?.withAlphaComponent(0.1).cgColor
        button.addTarget(self, action: #selector(didTapSetting), for: .touchUpInside)
        
        return button
    }()
     
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
     
    
    private func setupUI() {
        
        contentView.addSubview(myButton)
        
        myButton.snp.makeConstraints{ make in
            make.topMargin.equalToSuperview().inset(20)
            make.leading.trailing.equalToSuperview().inset(100)
            make.height.equalTo(45)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(20)

        }
        
    
    }
    
    
    @objc private func didTapSetting(_ sender: UIButton) {
        
        let currentTitle = sender.currentTitle ?? ""
        
        if currentTitle == "LOG OUT" {
             
            RootNavigationService.shared.showOnboardingPage()
            
        } else if currentTitle == "LOGIN" {
            
            RootNavigationService.shared.showLoginPage()
        }
    }
    
    
    
    
    
    required init?(coder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    
}
