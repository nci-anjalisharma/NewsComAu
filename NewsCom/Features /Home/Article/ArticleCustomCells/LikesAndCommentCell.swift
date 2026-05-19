//
//  LikesAndCommentCell.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 15/05/26.
//

import UIKit
import SnapKit

class LikesAndCommentCell: UITableViewCell {
    
    private var isLiked: Bool = false
    
    static let identifier = "LikesAndCommentCell"
    
    private var likesImageButton = UIButton(type: .system)
    private let likesCountLabel = UILabel()
    
    private var commentImageButton = UIButton(type: .system)
    private let commentCountLabel = UILabel()
    
    private let moreButton = UIButton()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
        
    }
    
    private func setupUI(){
        
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        selectionStyle = .none
        
        
        likesImageButton.setImage(UIImage(systemName: "heart"), for: .normal)
        likesImageButton.addTarget(self, action: #selector(didTapLike), for: .touchUpInside)
        likesImageButton.tintColor = .systemRed
        
        likesCountLabel.text = "1.4k"
        likesCountLabel.textColor = .black
        likesCountLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        
        commentImageButton.setImage(UIImage(systemName: "text.bubble"), for: .normal)
        commentImageButton.addTarget(self, action: #selector(didTapComment), for: .touchUpInside)
        commentImageButton.tintColor = .black
        
        commentCountLabel.text = "56"
        commentCountLabel.textColor = .black
        commentCountLabel.font = .systemFont(ofSize: 14, weight: .semibold)

        moreButton.setImage(UIImage(systemName: "ellipsis.circle"), for: .normal)
        
        
        let likesStack = UIStackView(arrangedSubviews: [likesImageButton, likesCountLabel])
        
        likesStack.axis = .horizontal
        likesStack.spacing = 6
        likesStack.alignment = .center
        
        let commentsStack = UIStackView(arrangedSubviews: [commentImageButton, commentCountLabel])
        
        commentsStack.axis = .horizontal
        commentsStack.spacing = 6
        commentsStack.alignment = .center
        
        let leftStack = UIStackView(arrangedSubviews: [likesStack, commentsStack])
        leftStack.spacing = 10
        
        let mainStack = UIStackView(arrangedSubviews: [leftStack, moreButton])
        mainStack.axis = .horizontal
        mainStack.distribution = .equalSpacing
        mainStack.alignment = .center
        
        
        contentView.addSubview(mainStack)
        
        mainStack.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(20)
        }

    }
    
    @objc func didTapComment(){
        
    }
    
    @objc func didTapLike(){
        
        isLiked.toggle()
        
        let heartImage = isLiked ? "heart.fill" : "heart"
            
            likesImageButton.setImage(UIImage(systemName: heartImage), for: .normal)
        }
        
        required init?(coder: NSCoder){
            fatalError()
        }
}
