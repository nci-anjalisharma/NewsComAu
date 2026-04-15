//
//  FullArticleViewController.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 13/04/26.
//


import UIKit
import SnapKit

class FullArticleViewController: UIViewController {
    
    private lazy var relatedStories: UIButton = {
        let button = UIButton()
        button.setTitle("Related Stories", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(relatedStoriesTap), for: .touchUpInside)
        
        return button
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        
        view.addSubview(relatedStories)
        
        relatedStories.snp.makeConstraints { (make) in
            
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(50)
            make.width.equalTo(150)
            
        }
        
        
          
    }
    
    @objc private func relatedStoriesTap() {
        
        let vc = RelatedStoriesViewController()
        vc.title = "Related Stories"
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}
