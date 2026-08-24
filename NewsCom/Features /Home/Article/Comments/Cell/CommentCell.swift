//
//  CommentCell.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 12/08/26.
//

import UIKit
import SnapKit

final class CommentCell: UITableViewCell {

    static let identifier = "CommentCell"

    private let avatarView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 20
        return view
    }()

    private let avatarLabel: UILabel = {
        let label = UILabel()
        label.text = "A"
        label.font = .systemFont(
            ofSize: 14,
            weight: .bold
        )
        label.textAlignment = .center
        return label
    }()

    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "You"
        label.font = .systemFont(
            ofSize: 14,
            weight: .semibold
        )
        return label
    }()

    private let commentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.numberOfLines = 0
        return label
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .secondaryLabel
        return label
    }()

    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(
            style: style,
            reuseIdentifier: reuseIdentifier
        )

        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    private func setupUI() {

        selectionStyle = .none
        backgroundColor = .clear

        contentView.addSubview(avatarView)
        avatarView.addSubview(avatarLabel)

        contentView.addSubview(usernameLabel)
        contentView.addSubview(commentLabel)
        contentView.addSubview(dateLabel)

        avatarView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(14)
            make.width.height.equalTo(40)
        }

        avatarLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        usernameLabel.snp.makeConstraints { make in
            make.top.equalTo(avatarView)
            make.leading.equalTo(
                avatarView.snp.trailing
            ).offset(12)
            make.trailing.equalToSuperview().offset(-20)
        }

        commentLabel.snp.makeConstraints { make in
            make.top.equalTo(
                usernameLabel.snp.bottom
            ).offset(4)

            make.leading.equalTo(usernameLabel)
            make.trailing.equalToSuperview().offset(-20)
        }

        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(
                commentLabel.snp.bottom
            ).offset(5)

            make.leading.equalTo(usernameLabel)
            make.bottom.equalToSuperview().offset(-14)
        }
    }

    func configure(with comment: Comment) {

        commentLabel.text = comment.text

        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .short

        dateLabel.text = formatter.localizedString(
            for: comment.date,
            relativeTo: Date()
        )
    }
}
