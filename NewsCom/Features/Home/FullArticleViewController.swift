//
//  FullArticleViewController.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 13/04/26.
//


import UIKit
import SnapKit

class FullArticleViewController: UIViewController {
    
    
    let articleLabel = UILabel()
    var articleText: String?
    
    var saveButton: UIBarButtonItem!
    var shareButton: UIBarButtonItem!
    var celebrationButton: UIBarButtonItem!
    
    var isSaved: Bool = false
    





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
        
        
        
        
        saveButton = UIBarButtonItem(title: nil, image: UIImage(systemName: "bookmark"), target: self, action: #selector(didTapAdd))
        
        shareButton = UIBarButtonItem(title: nil, image: UIImage(systemName: "square.and.arrow.up"), target: self, action: #selector(didTapShare))
        celebrationButton = UIBarButtonItem(title: nil, image:  UIImage(systemName: "wand.and.stars"), target: self, action: #selector(didTapCelebrateButton))
        navigationItem.rightBarButtonItems = [saveButton, shareButton, celebrationButton]
        
        
        
        articleLabel.numberOfLines = 0
        articleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        
        view.addSubview(articleLabel)
        
        articleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        articleLabel.text = articleText
        
          
        
    }
    
    @objc func didTapCelebrateButton() {
       
        CelebrationManager.launch(in: self.view)
    }
   

    @objc func didTapAdd() {
    
        isSaved.toggle()
        
        let imageName = isSaved ? "bookmark.fill" : "bookmark"
        
        saveButton.image = UIImage(systemName: imageName)
        

    }
    
    @objc func didTapShare(){
        
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
