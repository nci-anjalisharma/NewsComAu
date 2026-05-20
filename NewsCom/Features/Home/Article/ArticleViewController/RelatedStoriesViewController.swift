//
//  RelatedStoriesViewController.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 15/04/26.
//

import UIKit
import SnapKit

class RelatedStoriesViewController: UIViewController {
    
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        button.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupUI()
    }
    
    private func setupUI() {
        
        view.addSubview(cancelButton)
        
        cancelButton.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().inset(20)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(-10)
            make.height.equalTo(50)
            make.width.equalTo(150)
        }
    }
    
    @objc private func cancelButtonTapped() {
        
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
   
}
