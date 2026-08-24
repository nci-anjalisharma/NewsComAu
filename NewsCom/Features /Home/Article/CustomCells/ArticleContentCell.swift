//
//  ArticleContentCell.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 14/05/26.
//
//
//import UIKit
//import SnapKit
//
//class ArticleContentCell: UITableViewCell {
//    
//    
//    static let identifier = "ArticleContentCell"
//    
//    private let articleTextView = UITextView()
//    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        
//        setupUI()
//    }
//    
//    private func setupUI() {
//        
//        backgroundColor = .clear
//        contentView.backgroundColor = .clear
//        selectionStyle = .none
//        
//        contentView.addSubview(articleTextView)
//        
//        articleTextView.backgroundColor = .clear
//        articleTextView.textColor = .black
//        articleTextView.font = .systemFont(ofSize: 18, weight: .regular)
//        articleTextView.isEditable = false
//        articleTextView.isScrollEnabled = false
//        articleTextView.isSelectable = false
//        articleTextView.textContainerInset = .zero
//        articleTextView.textContainer.lineFragmentPadding = 0
//        
//        articleTextView.snp.makeConstraints { make in
//            make.top.bottom.equalToSuperview().inset(5)
//            make.leading.trailing.equalToSuperview().inset(20)
//        }
//    
//    }
//    func configiure(articleContent: String){
//        
//        let theme = ThemeManager.shared.currentTheme
//        articleTextView.text = articleContent
//        articleTextView.textColor = theme.colors.textColor
//    }
//    
//    
//    required init?(coder: NSCoder) {
//        fatalError()
//    }
//}




//  ArticleContentCell.swift (new)
//  NewsCom
//
//  Created by ANJALI SHARMA R on 14/05/26.
//

import UIKit
import SnapKit

final class ArticleContentCell: UITableViewCell {

    static let identifier = "ArticleContentCell"

    private let articleTextView = UITextView()

    // MARK: - Callbacks

    var onAddNote: ((NSRange, String) -> Void)?
    var onHighlight: ((NSRange, String) -> Void)?

    // MARK: - Init

    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupUI()
        setupContextMenu()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    // MARK: - UI

    private func setupUI() {

        backgroundColor = .clear
        contentView.backgroundColor = .clear
        selectionStyle = .none

        contentView.addSubview(articleTextView)

        articleTextView.backgroundColor = .clear
        articleTextView.textColor = .black

        articleTextView.font = .systemFont(
            ofSize: 18,
            weight: .regular
        )

        articleTextView.isEditable = false
        articleTextView.isScrollEnabled = false

        // IMPORTANT
        articleTextView.isSelectable = true

        articleTextView.textContainerInset = .zero
        articleTextView.textContainer.lineFragmentPadding = 0

        articleTextView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(5)
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }

    // MARK: - Configure

    func configiure(articleContent: String) {

        let theme = ThemeManager.shared.currentTheme

        articleTextView.text = articleContent
        articleTextView.textColor = theme.colors.textColor
    }

    // MARK: - Context Menu

    private func setupContextMenu() {

        let interaction = UIEditMenuInteraction(delegate: self)

        articleTextView.addInteraction(interaction)
    }

    // MARK: - Selected Text

    private func selectedTextInfo() -> (NSRange, String)? {

        let range = articleTextView.selectedRange

        guard range.length > 0 else {
            return nil
        }

        let text = articleTextView.text as NSString

        guard NSMaxRange(range) <= text.length else {
            return nil
        }

        let selectedText = text.substring(with: range)

        return (range, selectedText)
    }
}

// MARK: - UIEditMenuInteractionDelegate

extension ArticleContentCell: UIEditMenuInteractionDelegate {

    func editMenuInteraction(
        _ interaction: UIEditMenuInteraction,
        menuFor configuration: UIEditMenuConfiguration,
        suggestedActions: [UIMenuElement]
    ) -> UIMenu? {

        guard let selectedInfo = selectedTextInfo() else {
            return nil
        }

        let addNote = UIAction(
            title: "Add Note",
            image: UIImage(systemName: "note.text")
        ) { [weak self] _ in

            guard let self else {
                return
            }

            self.onAddNote?(
                selectedInfo.0,
                selectedInfo.1
            )
        }

        let highlight = UIAction(
            title: "Highlight",
            image: UIImage(systemName: "highlighter")
        ) { [weak self] _ in

            guard let self else {
                return
            }

            self.onHighlight?(
                selectedInfo.0,
                selectedInfo.1
            )
        }

        return UIMenu(
            children: [
                addNote,
                highlight
            ]
        )
    }
}
