//
//  StatsTableViewCell.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 07/05/26.
//


import UIKit
import SnapKit

class StatsTableViewCell: UITableViewCell {
    
    private let stackView = UIStackView()
    
    private let articlesCard = StatsCardView()
    private let savedCard = StatsCardView()
    private let milestonesCard = StatsCardView()
    
    let theme = ThemeManager.shared.currentTheme
    
    var onReadTapped: (() -> Void)?
    var onSavedTapped: (() -> Void)?
    var onMilestonesTapped: (() -> Void)?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupStackView()
        
    }
    
    private func setupStackView() {
        
        stackView.axis = .horizontal
        stackView.spacing = 6
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .clear
//        stackView.backgroundColor = theme.colors.surface
//        contentView.backgroundColor = .clear
        
//        contentView.layer.cornerRadius = 24
//        contentView.layer.borderWidth = 1
//        contentView.layer.borderColor = theme.colors.background.cgColor
//        contentView.layer.borderColor = UIColor.clear.cgColor

        contentView.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            
            make.top.equalToSuperview().offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(10)
//            make.edges.equalToSuperview()
            make.height.equalTo(100)
        }
        
        [articlesCard, savedCard, milestonesCard].forEach{
            
            stackView.addArrangedSubview($0)
            $0.isUserInteractionEnabled = true
        }
        
//        articlesCard.isUserInteractionEnabled = true
//        savedCard.isUserInteractionEnabled = true
//        milestonesCard.isUserInteractionEnabled = true

        articlesCard.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapReadCard)))

        savedCard.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapSavedCard)))

        milestonesCard.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapMilestonesCard)))
    }
    
    func configure(articlesRead: String, saved: String, topics: String) {
        
       // contentView.backgroundColor = theme.surface.background
        self.backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        articlesCard.configure(count: "\(ReadingHistoryManager.shared.history.count)", title: "ARTICLES READ")
        savedCard.configure(count: "\(SavedManager.shared.fetchSavedArticles().count)", title: "SAVED")
        milestonesCard.configure(count: "\(ReadingMilestoneManager.shared.unlockedCount())", title: "MILESTONES")
        
        [articlesCard, savedCard, milestonesCard].forEach{

            $0.backgroundColor = theme.colors.surface
        }
    }
    
    @objc private func didTapReadCard() {

        animate(articlesCard)
        onReadTapped?()
    }

    @objc private func didTapSavedCard() {

        animate(savedCard)
        onSavedTapped?()
    }
    
    @objc private func didTapMilestonesCard() {

        animate(milestonesCard)
        onMilestonesTapped?()
    }
    
    private func animate(_ view: UIView) {

        UIView.animate(withDuration: 0.1, animations: {

            view.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)

        }) { _ in

            UIView.animate(withDuration: 0.1) {

                view.transform = .identity
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
    
    
 
