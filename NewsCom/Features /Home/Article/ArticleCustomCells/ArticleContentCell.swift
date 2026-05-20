//
//  ArticleContentCell.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 14/05/26.
//

import UIKit
import SnapKit

class ArticleContentCell: UITableViewCell {
    
    
    static let identifier = "ArticleContentCell"
    
    private let articleTextView = UITextView()
    
    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    private func setupUI() {
        
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(articleTextView)
        
        articleTextView.backgroundColor = .clear
        articleTextView.textColor = .black
        articleTextView.font = .systemFont(ofSize: 18, weight: .regular)
        articleTextView.isEditable = false
        articleTextView.isScrollEnabled = false
        articleTextView.isSelectable = false
        articleTextView.textContainerInset = .zero
        articleTextView.textContainer.lineFragmentPadding = 0
        articleTextView.text = """
            In the heart of the digital revolution, we often focus on the hardware—the sleek screens, the faster chips, and the ubiquitous connectivity. 
            Yet, the most profound changes are happening in the invisible layers of our daily interactions. Artificial intelligence is no longer a distant concept discussed in laboratory halls; it is the silent curator of our modern existence.
            In the heart of the digital revolution, we often focus on the hardware—the sleek screens, the faster chips, and the ubiquitous connectivity. 
            Yet, the most profound changes are happening in the invisible layers of our daily interactions. Artificial intelligence is no longer a distant concept discussed in laboratory halls; it is the silent curator of our modern existence.
            In the heart of the digital revolution, we often focus on the hardware—the sleek screens, the faster chips, and the ubiquitous connectivity. 
            Yet, the most profound changes are happening in the invisible layers of our daily interactions. Artificial intelligence is no longer a distant concept discussed in laboratory halls; it is the silent curator of our modern existence.
            """
//        let attributedText = NSMutableAttributedString(string: articleText)
//        
//        attributedText.addAttributes([.font: UIFont.systemFont(ofSize: 48,weight: .bold ), .foregroundColor: UIColor.black], range: NSRange(location: 0, length: 1))
//        
//        attributedText.addAttributes([.font: UIFont.systemFont(ofSize: 18, weight: .regular), .foregroundColor: UIColor.black], range: NSRange(location: 1, length: articleText.count - 1))
//        
//        articleTextView.attributedText = attributedText
        
        articleTextView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(12)
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
