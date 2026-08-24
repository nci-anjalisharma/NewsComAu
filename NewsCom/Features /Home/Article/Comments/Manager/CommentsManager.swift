//
//  CommentsManager.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 12/08/26.
//
import Foundation

final class CommentsManager {

    static let shared = CommentsManager()

    private let keyPrefix = "article_comments_"

    private init() {}

    func comments(for articleURL: String) -> [Comment] {

        let key = keyPrefix + articleURL

        guard let data = UserDefaults.standard.data(forKey: key) else {
            return defaultComments()
        }

        do {
            return try JSONDecoder().decode(
                [Comment].self,
                from: data
            )
        } catch {
            print("Failed to load comments:", error)
            return []
        }
    }

    func addComment(_ comment: Comment, for articleURL: String) {

        let key = keyPrefix + articleURL

        var existingComments = comments(for: articleURL)

        existingComments.append(comment)

        do {
            let data = try JSONEncoder().encode(existingComments)

            UserDefaults.standard.set(
                data,
                forKey: key
            )

            print("Comment saved for article")
        } catch {
            print("Failed to save comment:", error)
        }

        NotificationCenter.default.post(name: .commentsChanged, object: articleURL)
    }

    private func defaultComments() -> [Comment] {

        [
            Comment(id: UUID(), text: "This is actually really interesting!",
                date: Date().addingTimeInterval(-3600)),

            Comment(id: UUID(), text: "I didn't know about this. Thanks for sharing.", date: Date().addingTimeInterval(-7200)),

            Comment(id: UUID(), text: "Definitely worth reading.", date: Date().addingTimeInterval(-10800))
        ]
    }
}

extension Notification.Name {
    static let commentsChanged = Notification.Name("commentsChanged")
}
