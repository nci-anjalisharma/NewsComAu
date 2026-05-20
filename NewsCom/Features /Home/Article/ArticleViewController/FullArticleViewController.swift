//
//  FullArticleViewController.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 13/04/26.
//


import UIKit
import SnapKit

class FullArticleViewController: UIViewController {
    
    var article: Article?
    let articleLabel = UILabel()
    var articleText: String?
    
    let articleTableView = ArticleTableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        articleTableView.tableView.delegate = self
        articleTableView.tableView.dataSource = self
        
        setupTableView()
    }
    
    private func setupTableView(){
        
        view.addSubview(articleTableView)
        
        articleTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension FullArticleViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
            
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: TopImageCell.identifier, for: indexPath) as! TopImageCell
            
            cell.configure(imageName: article?.imageURL ?? "")
            
            return cell
            
        case 1:
            return tableView.dequeueReusableCell(withIdentifier: TopicAndTimeCell.identifier, for: indexPath)
            
        case 2:
            return tableView.dequeueReusableCell(withIdentifier: HeadLineCell.identifier, for: indexPath)
            
        case 3:
            return tableView.dequeueReusableCell(withIdentifier: AuthorAndPublishDateCell.identifier, for: indexPath)
            
        case 4:
            return tableView.dequeueReusableCell(withIdentifier: ArticleContentCell.identifier, for: indexPath)
            
        case 5:
            return tableView.dequeueReusableCell(withIdentifier: AttributedArticleContentCell.identifier, for: indexPath)
            
        case 6:
            return tableView.dequeueReusableCell(withIdentifier: LikesAndCommentCell.identifier, for: indexPath)
        case 7:
            return tableView.dequeueReusableCell(withIdentifier: RelatedStoriesCell.identifier, for: indexPath)
            
        default:
            return tableView.dequeueReusableCell(withIdentifier: SwipeForNextCell.identifier, for: indexPath)
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 7 {
            return 300
        }
            return UITableView.automaticDimension
    }
}
