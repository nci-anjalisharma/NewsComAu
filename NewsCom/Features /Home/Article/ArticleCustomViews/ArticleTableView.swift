//
//  ArticleTableView.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 14/05/26.
//


import UIKit
import SnapKit

class ArticleTableView: UIView{

    let tableView = UITableView(frame: .zero, style: .plain)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()

    }
    
    private func setupUI(){
        
        addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            
        }
        
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.bounces = true
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        
        registerCells()
        
    }
    
    private func registerCells(){
        
        tableView.register(TopImageCell.self, forCellReuseIdentifier: TopImageCell.identifier)
        
        tableView.register(TopicAndTimeCell.self, forCellReuseIdentifier: TopicAndTimeCell.identifier)
        
        tableView.register(HeadLineCell.self, forCellReuseIdentifier: HeadLineCell.identifier)
        
        tableView.register(AuthorAndPublishDateCell.self, forCellReuseIdentifier: AuthorAndPublishDateCell.identifier)
        
        tableView.register(ArticleContentCell.self, forCellReuseIdentifier: ArticleContentCell.identifier)
        
        tableView.register(AttributedArticleContentCell.self, forCellReuseIdentifier: AttributedArticleContentCell.identifier)
        
        tableView.register(LikesAndCommentCell.self, forCellReuseIdentifier: LikesAndCommentCell.identifier)
        
        tableView.register(BreakingNewsTableViewCell.self, forCellReuseIdentifier: BreakingNewsTableViewCell.identifier)
        
        tableView.register(RelatedStoriesCell.self, forCellReuseIdentifier: RelatedStoriesCell.identifier)
        
        tableView.register(SwipeForNextCell.self, forCellReuseIdentifier: SwipeForNextCell.identifier)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
