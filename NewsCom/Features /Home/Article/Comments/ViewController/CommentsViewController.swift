//
//  CommentsViewController.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 12/08/26.
//
import UIKit
import SnapKit

final class CommentsViewController: UIViewController {

    private let articleURL: String

    private var comments: [Comment] = []

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Comments"
        label.font = .systemFont(
            ofSize: 20,
            weight: .bold
        )
        return label
    }()

    private let countLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(
            ofSize: 14,
            weight: .medium
        )
        label.textColor = .secondaryLabel
        return label
    }()

    private let tableView: UITableView = {
        let tableView = UITableView(
            frame: .zero,
            style: .plain
        )

        tableView.separatorStyle = .none
        tableView.keyboardDismissMode = .interactive

        return tableView
    }()

    private let inputContainer = UIView()

    private let commentTextField: UITextField = {
        let textField = UITextField()

        textField.placeholder = "Add a comment..."
        textField.font = .systemFont(ofSize: 15)
        textField.backgroundColor =
            .secondarySystemBackground

        textField.layer.cornerRadius = 21

        textField.leftView = UIView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: 14,
                height: 1
            )
        )

        textField.leftViewMode = .always
        textField.returnKeyType = .send

        return textField
    }()

    private let sendButton: UIButton = {

        let button = UIButton(type: .system)

        button.setImage(
            UIImage(
                systemName: "arrow.up.circle.fill"
            ),
            for: .normal
        )

        button.tintColor = .systemBlue

        return button
    }()

    init(articleURL: String) {

        self.articleURL = articleURL

        super.init(
            nibName: nil,
            bundle: nil
        )
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupTableView()
        setupActions()
        loadComments()
    }

    private func setupUI() {

        view.backgroundColor = .systemBackground

        view.addSubview(titleLabel)
        view.addSubview(countLabel)
        view.addSubview(tableView)
        view.addSubview(inputContainer)

        inputContainer.addSubview(commentTextField)
        inputContainer.addSubview(sendButton)

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(
                view.safeAreaLayoutGuide
            ).offset(10)

            make.leading.equalToSuperview().offset(20)
        }

        countLabel.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.leading.equalTo(
                titleLabel.snp.trailing
            ).offset(8)
        }

        inputContainer.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(70)
        }

        commentTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.height.equalTo(42)
            make.trailing.equalTo(
                sendButton.snp.leading
            ).offset(-10)
        }

        sendButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(42)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(
                titleLabel.snp.bottom
            ).offset(10)

            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(
                inputContainer.snp.top
            )
        }
    }

    private func setupTableView() {

        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(
            CommentCell.self,
            forCellReuseIdentifier: CommentCell.identifier
        )
    }

    private func setupActions() {

        sendButton.addTarget(
            self,
            action: #selector(didTapSend),
            for: .touchUpInside
        )

        commentTextField.delegate = self
    }

    private func loadComments() {

        comments = CommentsManager.shared.comments(
            for: articleURL
        )

        updateCount()

        tableView.reloadData()
    }

    private func updateCount() {

        countLabel.text = "\(comments.count)"
    }

    @objc private func didTapSend() {

        guard let text = commentTextField.text?
            .trimmingCharacters(
                in: .whitespacesAndNewlines
            ),
            !text.isEmpty else {
            return
        }

        let comment = Comment(
            id: UUID(),
            text: text,
            date: Date()
        )

        CommentsManager.shared.addComment(
            comment,
            for: articleURL
        )

        comments.append(comment)

        commentTextField.text = ""

        updateCount()

        tableView.reloadData()

        let lastRow = comments.count - 1

        if lastRow >= 0 {

            tableView.scrollToRow(
                at: IndexPath(
                    row: lastRow,
                    section: 0
                ),
                at: .bottom,
                animated: true
            )
        }
    }
}

extension CommentsViewController:
    UITableViewDataSource,
    UITableViewDelegate {

    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        comments.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {

        guard let cell =
            tableView.dequeueReusableCell(
                withIdentifier: CommentCell.identifier,
                for: indexPath
            ) as? CommentCell
        else {
            return UITableViewCell()
        }

        cell.configure(
            with: comments[indexPath.row]
        )

        return cell
    }

    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        UITableView.automaticDimension
    }
}

extension CommentsViewController:
    UITextFieldDelegate {

    func textFieldShouldReturn(
        _ textField: UITextField
    ) -> Bool {

        didTapSend()

        return true
    }
}
